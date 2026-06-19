import { pool } from '../config/db.js';
import { gradeQuestion } from './gradingService.js';

export async function getStudentLevels(userId) {
  const { rows: userRows } = await pool.query('select is_premium from users where id = $1', [userId]);
  const isPremium = userRows[0]?.is_premium || false;

  const { rows } = await pool.query(
    `select l.*,
            (
              l.is_paid
              or (
                l.part_id is not null
                and exists (
                  select 1 from levels previous_in_part
                  where previous_in_part.part_id = l.part_id
                    and previous_in_part.level_order < l.level_order
                )
                and not exists (
                  select 1 from levels next_in_part
                  where next_in_part.part_id = l.part_id
                    and next_in_part.level_order > l.level_order
                )
              )
            ) as effective_is_paid,
            (
              coalesce(up.completed, false)
              or coalesce(up.best_score, 0) >= l.passing_score
            ) as completed,
            coalesce(up.unlocked, false) as progress_unlocked,
            coalesce(up.best_score, 0) as best_score,
            case
              when previous_level.id is null then true
              else (
                coalesce(previous_progress.completed, false)
                or coalesce(previous_progress.best_score, 0) >= previous_level.passing_score
              )
            end as previous_completed
     from levels l
     left join user_progress up on up.level_id = l.id and up.user_id = $1
     left join lateral (
       select pl.id, pl.passing_score
       from levels pl
       where (
         (l.part_id is not null and pl.part_id = l.part_id)
         or (l.part_id is null and pl.part_id is null)
       )
       and pl.level_order < l.level_order
       order by pl.level_order desc
       limit 1
     ) previous_level on true
     left join user_progress previous_progress
       on previous_progress.level_id = previous_level.id and previous_progress.user_id = $1
     order by l.level_order asc`,
    [userId],
  );

  return rows.map((level) => {
    const unlocked = level.level_order === 1 || level.progress_unlocked || level.previous_completed;
    const lockedByProgress = !unlocked;
    const lockedByPayment = level.effective_is_paid && !isPremium;

    return {
      ...level,
      is_paid: level.effective_is_paid,
      unlocked,
      locked: lockedByProgress || lockedByPayment,
      lockedReason: lockedByProgress ? 'Terminez le niveau precedent' : lockedByPayment ? 'Abonnement requis' : null,
    };
  });
}

export async function assertLevelAccess(userId, levelId) {
  const { rows } = await pool.query(
    `select l.*, u.is_premium,
            (
              l.is_paid
              or (
                l.part_id is not null
                and exists (
                  select 1 from levels previous_in_part
                  where previous_in_part.part_id = l.part_id
                    and previous_in_part.level_order < l.level_order
                )
                and not exists (
                  select 1 from levels next_in_part
                  where next_in_part.part_id = l.part_id
                    and next_in_part.level_order > l.level_order
                )
              )
            ) as effective_is_paid,
            coalesce(up.unlocked, false) as progress_unlocked,
            case
              when previous_level.id is null then true
              else (
                coalesce(previous_progress.completed, false)
                or coalesce(previous_progress.best_score, 0) >= previous_level.passing_score
              )
            end as previous_completed
     from levels l
     join users u on u.id = $2
     left join user_progress up on up.level_id = l.id and up.user_id = u.id
     left join lateral (
       select pl.id, pl.passing_score
       from levels pl
       where (
         (l.part_id is not null and pl.part_id = l.part_id)
         or (l.part_id is null and pl.part_id is null)
       )
       and pl.level_order < l.level_order
       order by pl.level_order desc
       limit 1
     ) previous_level on true
     left join user_progress previous_progress
       on previous_progress.level_id = previous_level.id and previous_progress.user_id = u.id
     where l.id = $1`,
    [levelId, userId],
  );
  const level = rows[0];

  if (!level) {
    return { allowed: false, status: 404, message: 'Niveau introuvable' };
  }

  const unlocked = level.level_order === 1 || level.progress_unlocked || level.previous_completed;
  if (!unlocked) {
    return { allowed: false, status: 403, message: 'Terminez le niveau precedent' };
  }

  if (level.effective_is_paid && !level.is_premium) {
    return { allowed: false, status: 403, message: 'Abonnement requis pour acceder a ce quiz' };
  }

  return { allowed: true, level };
}

export async function getQuestionsForStudent(userId, levelId, includeCorrections = false) {
  const access = await assertLevelAccess(userId, levelId);
  if (!access.allowed) {
    const error = new Error(access.message);
    error.status = access.status;
    throw error;
  }

  return loadQuestions(levelId, includeCorrections);
}

export async function getStudentProgress(userId) {
  const { rows } = await pool.query(
    `select l.id as level_id, l.title, l.level_order, l.is_paid,
            (
              coalesce(up.completed, false)
              or coalesce(up.best_score, 0) >= l.passing_score
            ) as completed,
            (
              previous_level.id is null
              or l.level_order = 1
              or coalesce(up.unlocked, false)
              or coalesce(previous_progress.completed, false)
              or coalesce(previous_progress.best_score, 0) >= previous_level.passing_score
            ) as unlocked,
            coalesce(up.best_score, 0) as best_score,
            up.updated_at
     from levels l
     left join user_progress up on up.level_id = l.id and up.user_id = $1
     left join lateral (
       select pl.id, pl.passing_score
       from levels pl
       where (
         (l.part_id is not null and pl.part_id = l.part_id)
         or (l.part_id is null and pl.part_id is null)
       )
       and pl.level_order < l.level_order
       order by pl.level_order desc
       limit 1
     ) previous_level on true
     left join user_progress previous_progress
       on previous_progress.level_id = previous_level.id and previous_progress.user_id = $1
     order by l.level_order asc`,
    [userId],
  );

  return rows;
}

export async function getAttemptResult(userId, attemptId) {
  const { rows: attemptRows } = await pool.query(
    `select qa.*, l.title as level_title
     from quiz_attempts qa
     join levels l on l.id = qa.level_id
     where qa.id = $1 and qa.user_id = $2`,
    [attemptId, userId],
  );
  const attempt = attemptRows[0];

  if (!attempt) {
    const error = new Error('Tentative introuvable');
    error.status = 404;
    throw error;
  }

  const { rows: answers } = await pool.query(
    `select sa.question_id as "questionId", sa.answer_data as "answerData",
            sa.is_correct as "isCorrect", sa.points_earned as "pointsEarned",
            q.question_text as "questionText", q.explanation
     from student_answers sa
     join questions q on q.id = sa.question_id
     where sa.attempt_id = $1
     order by q.created_at asc`,
    [attemptId],
  );

  return {
    attempt,
    score: attempt.score,
    totalPoints: attempt.total_points,
    percent: attempt.total_points === 0 ? 0 : Math.round((attempt.score / attempt.total_points) * 100),
    passed: attempt.passed,
    corrections: answers,
  };
}

export async function submitQuiz(userId, levelId, submittedAnswers = []) {
  const client = await pool.connect();

  try {
    const access = await assertLevelAccess(userId, levelId);
    if (!access.allowed) {
      const error = new Error(access.message);
      error.status = access.status;
      throw error;
    }

    const questions = await loadQuestions(levelId, true);
    const totalPoints = questions.reduce((sum, question) => sum + question.points, 0);
    const corrections = questions.map((question) => {
      const submitted = submittedAnswers.find(
        (answer) => answer.question_id === question.id || answer.questionId === question.id,
      );
      const answerData = submitted?.answer_data || submitted?.answerData || submitted || {};
      const grade = gradeQuestion(question, answerData);

      return {
        question,
        answerData,
        isCorrect: grade.isCorrect,
        pointsEarned: grade.pointsEarned,
      };
    });

    const score = corrections.reduce((sum, correction) => sum + correction.pointsEarned, 0);
    const percent = totalPoints === 0 ? 0 : Math.round((score / totalPoints) * 100);
    const passed = percent >= access.level.passing_score;

    await client.query('begin');
    const { rows: attempts } = await client.query(
      `insert into quiz_attempts (user_id, level_id, score, total_points, passed, finished_at)
       values ($1, $2, $3, $4, $5, now())
       returning *`,
      [userId, levelId, score, totalPoints, passed],
    );
    const attempt = attempts[0];

    for (const correction of corrections) {
      await client.query(
        `insert into student_answers (attempt_id, question_id, answer_data, is_correct, points_earned)
         values ($1, $2, $3, $4, $5)`,
        [
          attempt.id,
          correction.question.id,
          correction.answerData,
          correction.isCorrect,
          correction.pointsEarned,
        ],
      );
    }

    await upsertCurrentLevelProgress(client, userId, levelId, passed, percent);

    if (passed) {
      await unlockNextLevel(client, userId, access.level.id);
    }

    await client.query('commit');

    return {
      attempt,
      score,
      totalPoints,
      percent,
      passed,
      corrections: corrections.map((correction) => ({
        questionId: correction.question.id,
        questionText: correction.question.question_text,
        isCorrect: correction.isCorrect,
        pointsEarned: correction.pointsEarned,
        explanation: correction.question.explanation,
        correctOptions: correction.question.options.filter((option) => option.is_correct),
        correctItems: correction.question.items,
      })),
    };
  } catch (error) {
    await client.query('rollback');
    throw error;
  } finally {
    client.release();
  }
}

async function upsertCurrentLevelProgress(client, userId, levelId, completed, bestScore) {
  await client.query(
    `insert into user_progress (user_id, level_id, completed, unlocked, best_score, updated_at)
     values ($1, $2, $3, true, $4, now())
     on conflict (user_id, level_id)
     do update set
       completed = user_progress.completed or excluded.completed,
       unlocked = true,
       best_score = greatest(user_progress.best_score, excluded.best_score),
       updated_at = now()`,
    [userId, levelId, completed, bestScore],
  );
}

async function unlockNextLevel(client, userId, currentLevelId) {
  await client.query(
    `insert into user_progress (user_id, level_id, completed, unlocked, best_score, updated_at)
     select $1, next_level.id, false, true, 0, now()
     from levels current_level
     join lateral (
       select next_level.id
       from levels next_level
       where (
         (current_level.part_id is not null and next_level.part_id = current_level.part_id)
         or (current_level.part_id is null and next_level.part_id is null)
       )
       and next_level.level_order > current_level.level_order
       order by next_level.level_order asc
       limit 1
     ) next_level on true
     where current_level.id = $2
     on conflict (user_id, level_id)
     do update set unlocked = true, updated_at = now()`,
    [userId, currentLevelId],
  );
}

async function loadQuestions(levelId, includeCorrections) {
  const { rows } = await pool.query(
    `select q.*,
            coalesce(
              json_agg(distinct jsonb_build_object(
                'id', qo.id,
                'option_text', qo.option_text,
                'is_correct', ${includeCorrections ? 'qo.is_correct' : 'false'},
                'option_order', qo.option_order
              )) filter (where qo.id is not null),
              '[]'
            ) as options,
            coalesce(
              json_agg(distinct jsonb_build_object(
                'id', qi.id,
                'label', qi.label,
                'correct_answer', ${includeCorrections ? 'qi.correct_answer' : "''"},
                'position_x', qi.position_x,
                'position_y', qi.position_y,
                'item_order', qi.item_order
              )) filter (where qi.id is not null),
              '[]'
            ) as items
     from questions q
     left join question_options qo on qo.question_id = q.id
     left join question_items qi on qi.question_id = q.id
     where q.level_id = $1
     group by q.id
     order by q.created_at asc`,
    [levelId],
  );

  return rows.map((question) => ({
    ...question,
    options: question.options.sort((a, b) => a.option_order - b.option_order),
    items: question.items.sort((a, b) => a.item_order - b.item_order),
  }));
}
