import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { pool } from '../config/db.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const moduleRoot = path.resolve(__dirname, '../../../module');

const moduleCatalog = [
  {
    slug: 'biochimie-structurale',
    title: 'Biochimie structurale',
    description: 'Proteines, glucides et lipides avec les quiz importes depuis le dossier module.',
    parts: [
      {
        slug: 'proteines',
        title: 'Proteines',
        sourceFiles: ['proteines.html'],
        keywords: ['proteine', 'proteines', 'protein'],
      },
      {
        slug: 'glucides',
        title: 'Glucides',
        sourceFiles: ['glucides.html'],
        keywords: ['glucide', 'glucides'],
      },
      {
        slug: 'lipides',
        title: 'Lipides',
        sourceFiles: ['lipides.html'],
        keywords: ['lipide', 'lipides'],
      },
    ],
  },
  {
    slug: 'anatomie-physiologie-humaine',
    title: 'Anatomie et physiologie humaine',
    description: 'Cardio, digestion et respiration selon les documents presents dans le dossier module.',
    parts: [
      {
        slug: 'cardio',
        title: 'Cardio',
        sourceFiles: ['cardio.doc', 'cardio2.doc'],
        keywords: ['cardio', 'coeur', 'circulation'],
      },
      {
        slug: 'digestion',
        title: 'Digestion',
        sourceFiles: ['digestion.pdf'],
        keywords: ['digestion', 'digestif', 'estomac'],
      },
      {
        slug: 'respiration',
        title: 'Respiration',
        sourceFiles: ['respiration.doc'],
        keywords: ['respiration', 'poumon', 'respiratoire'],
      },
    ],
  },
];

export async function ensureCatalogTables() {
  await pool.query(`
    create table if not exists modules (
      id uuid primary key default uuid_generate_v4(),
      title varchar(160) not null,
      description text,
      slug varchar(180) not null unique,
      module_order integer not null default 1,
      created_at timestamptz not null default now()
    );

    create table if not exists module_parts (
      id uuid primary key default uuid_generate_v4(),
      module_id uuid not null references modules(id) on delete cascade,
      title varchar(160) not null,
      description text,
      slug varchar(180) not null unique,
      part_order integer not null default 1,
      source_files text[] not null default '{}',
      keywords text[] not null default '{}',
      created_at timestamptz not null default now()
    );

    alter table levels add column if not exists part_id uuid references module_parts(id) on delete set null;
    create index if not exists module_parts_module_id_idx on module_parts(module_id);
    create index if not exists levels_part_id_idx on levels(part_id);
  `);

  for (const [moduleIndex, module] of moduleCatalog.entries()) {
    const { rows: moduleRows } = await pool.query(
      `insert into modules (title, description, slug, module_order)
       values ($1, $2, $3, $4)
       on conflict (slug) do update set
         title = excluded.title,
         description = excluded.description,
         module_order = excluded.module_order
       returning id`,
      [module.title, module.description, module.slug, moduleIndex + 1],
    );

    for (const [partIndex, part] of module.parts.entries()) {
      await pool.query(
        `insert into module_parts (module_id, title, slug, part_order, source_files, keywords)
         values ($1, $2, $3, $4, $5, $6)
         on conflict (slug) do update set
           module_id = excluded.module_id,
           title = excluded.title,
           part_order = excluded.part_order,
           source_files = excluded.source_files,
           keywords = excluded.keywords`,
        [moduleRows[0].id, part.title, part.slug, partIndex + 1, part.sourceFiles, part.keywords],
      );
    }
  }

  await linkExistingLevelsToParts();
  await ensureDefaultPaidQuizAccess();
}

function normalizeText(value) {
  return value
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();
}

function sourceStatus(sourceFiles) {
  return sourceFiles.map((fileName) => ({
    name: fileName,
    exists: fs.existsSync(path.join(moduleRoot, fileName)),
  }));
}

export async function getStudentProfile(userId) {
  const { rows } = await pool.query(
    `select u.id, u.name, u.email, u.role, u.is_premium as "isPremium", u.created_at as "createdAt",
            count(distinct qa.id)::int as "attemptCount",
            count(distinct up.level_id) filter (where up.completed)::int as "completedLevels",
            coalesce(round(avg(case when qa.total_points > 0 then qa.score::numeric * 100 / qa.total_points end)), 0)::int
              as "averageScore"
     from users u
     left join quiz_attempts qa on qa.user_id = u.id
     left join user_progress up on up.user_id = u.id
     where u.id = $1
     group by u.id`,
    [userId],
  );

  return rows[0];
}

export async function getStudentModules(userId) {
  await ensureCatalogTables();

  const { rows: catalogRows } = await pool.query(
    `select m.id as module_id, m.title as module_title, m.description as module_description,
            m.slug as module_slug, m.module_order,
            p.id as part_id, p.title as part_title, p.description as part_description,
            p.slug as part_slug, p.part_order, p.source_files, p.keywords
     from modules m
     left join module_parts p on p.module_id = m.id
     order by m.module_order asc, p.part_order asc`,
  );

  const { rows: levels } = await pool.query(
    `select l.id, l.title, l.description, l.level_order, l.is_paid, l.passing_score,
            l.part_id,
            count(q.id)::int as "questionCount",
            (
              coalesce(up.completed, false)
              or coalesce(up.best_score, 0) >= l.passing_score
            ) as completed,
            (
              previous_level.id is null
              or coalesce(up.unlocked, false)
              or coalesce(previous_progress.completed, false)
              or coalesce(previous_progress.best_score, 0) >= previous_level.passing_score
            ) as unlocked,
            (
              not (
                previous_level.id is null
                or coalesce(up.unlocked, false)
                or coalesce(previous_progress.completed, false)
                or coalesce(previous_progress.best_score, 0) >= previous_level.passing_score
              )
              or (l.is_paid and not u.is_premium)
            ) as locked,
            case
              when not (
                previous_level.id is null
                or coalesce(up.unlocked, false)
                or coalesce(previous_progress.completed, false)
                or coalesce(previous_progress.best_score, 0) >= previous_level.passing_score
              ) then 'Terminez le quiz precedent'
              when l.is_paid and not u.is_premium then 'Abonnement requis'
              else null
            end as "lockedReason",
            coalesce(up.best_score, 0) as "bestScore"
     from levels l
     join users u on u.id = $1
     left join questions q on q.level_id = l.id
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
     group by l.id, u.is_premium, up.completed, up.unlocked, up.best_score,
       previous_level.id, previous_level.passing_score, previous_progress.completed, previous_progress.best_score
     order by l.level_order asc`,
    [userId],
  );

  const modules = [];
  for (const row of catalogRows) {
    let module = modules.find((item) => item.id === row.module_id);
    if (!module) {
      module = {
        id: row.module_id,
        slug: row.module_slug,
        title: row.module_title,
        description: row.module_description,
        module_order: row.module_order,
        parts: [],
      };
      modules.push(module);
    }

    if (row.part_id) {
      module.parts.push({
        id: row.part_id,
        slug: row.part_slug,
        title: row.part_title,
        description: row.part_description,
        part_order: row.part_order,
        sourceFiles: row.source_files || [],
        keywords: row.keywords || [],
      });
    }
  }

  return modules.map((module) => ({
    ...module,
    parts: module.parts.map((part) => {
      const quizzes = levels.filter((level) => {
        const searchable = normalizeText(`${level.title} ${level.description || ''}`);
        if (level.part_id) return level.part_id === part.id;
        return part.keywords.some((keyword) => searchable.includes(normalizeText(keyword)));
      });

      return {
        id: part.id,
        slug: part.slug,
        title: part.title,
        description: part.description,
        part_order: part.part_order,
        keywords: part.keywords,
        sources: sourceStatus(part.sourceFiles),
        quizzes,
        quizCount: quizzes.length,
        questionCount: quizzes.reduce((sum, quiz) => sum + quiz.questionCount, 0),
      };
    }),
  }));
}

async function linkExistingLevelsToParts() {
  const { rows: parts } = await pool.query('select id, keywords from module_parts');
  const { rows: levels } = await pool.query('select id, title, description from levels where part_id is null');

  for (const level of levels) {
    const searchable = normalizeText(`${level.title} ${level.description || ''}`);
    const part = parts.find((candidate) =>
      (candidate.keywords || []).some((keyword) => searchable.includes(normalizeText(keyword))),
    );

    if (part) {
      await pool.query('update levels set part_id = $1 where id = $2', [part.id, level.id]);
    }
  }
}

async function ensureDefaultPaidQuizAccess() {
  await pool.query(`
    with parts_with_multiple_quizzes as (
      select part_id
      from levels
      where part_id is not null
      group by part_id
      having count(*) > 1
    ),
    last_quiz_per_part as (
      select distinct on (l.part_id) l.id
      from levels l
      join parts_with_multiple_quizzes p on p.part_id = l.part_id
      order by l.part_id, l.level_order desc
    )
    update levels
    set is_paid = true
    where id in (select id from last_quiz_per_part)
  `);
}

export async function getStudentScores(userId) {
  const { rows: summaryRows } = await pool.query(
    `select count(qa.id)::int as "attemptCount",
            coalesce(sum(qa.score), 0)::int as "earnedPoints",
            coalesce(sum(qa.total_points), 0)::int as "totalPoints",
            count(qa.id) filter (where qa.passed)::int as "passedAttempts",
            coalesce(round(avg(case when qa.total_points > 0 then qa.score::numeric * 100 / qa.total_points end)), 0)::int
              as "averagePercent",
            coalesce(sum(answer_stats.correct), 0)::int as "correctAnswers",
            coalesce(sum(answer_stats.incorrect), 0)::int as "incorrectAnswers"
     from quiz_attempts qa
     left join (
       select attempt_id,
              count(*) filter (where is_correct)::int as correct,
              count(*) filter (where not is_correct)::int as incorrect
       from student_answers
       group by attempt_id
     ) answer_stats on answer_stats.attempt_id = qa.id
     where qa.user_id = $1`,
    [userId],
  );

  const { rows: attempts } = await pool.query(
    `select qa.id, qa.score, qa.total_points as "totalPoints", qa.passed,
            qa.finished_at as "finishedAt", l.title as "levelTitle",
            case when qa.total_points = 0 then 0 else round(qa.score::numeric * 100 / qa.total_points)::int end as percent,
            count(sa.id) filter (where sa.is_correct)::int as "correctAnswers",
            count(sa.id) filter (where not sa.is_correct)::int as "incorrectAnswers"
     from quiz_attempts qa
     join levels l on l.id = qa.level_id
     left join student_answers sa on sa.attempt_id = qa.id
     where qa.user_id = $1
     group by qa.id, l.title
     order by qa.finished_at desc nulls last, qa.started_at desc
     limit 20`,
    [userId],
  );

  const { rows: byLevel } = await pool.query(
    `select l.id, l.title,
            count(qa.id)::int as attempts,
            coalesce(max(case when qa.total_points > 0 then round(qa.score::numeric * 100 / qa.total_points)::int end), 0)
              as "bestPercent",
            coalesce(round(avg(case when qa.total_points > 0 then qa.score::numeric * 100 / qa.total_points end)), 0)::int
              as "averagePercent"
     from levels l
     left join quiz_attempts qa on qa.level_id = l.id and qa.user_id = $1
     group by l.id
     having count(qa.id) > 0
     order by "bestPercent" desc, l.level_order asc`,
    [userId],
  );

  return {
    summary: summaryRows[0],
    attempts,
    byLevel,
  };
}

async function ensureCompetitionTables() {
  await pool.query(`
    create table if not exists competition_friends (
      id uuid primary key default uuid_generate_v4(),
      owner_id uuid not null references users(id) on delete cascade,
      friend_name varchar(160) not null,
      friend_email varchar(255),
      created_at timestamptz not null default now()
    );

    create index if not exists competition_friends_owner_id_idx on competition_friends(owner_id);
  `);
}

export async function getStudentCompetition(userId) {
  await ensureCompetitionTables();

  const { rows: leaderboard } = await pool.query(
    `select u.id, u.name, u.email,
            count(qa.id)::int as attempts,
            count(qa.id) filter (where qa.passed)::int as "passedAttempts",
            coalesce(max(case when qa.total_points > 0 then round(qa.score::numeric * 100 / qa.total_points)::int end), 0)
              as "bestPercent",
            coalesce(round(avg(case when qa.total_points > 0 then qa.score::numeric * 100 / qa.total_points end)), 0)::int
              as "averagePercent",
            coalesce(sum(qa.score), 0)::int as "earnedPoints",
            coalesce(sum(qa.total_points), 0)::int as "totalPoints",
            max(qa.finished_at) as "lastAttemptAt"
     from users u
     left join quiz_attempts qa on qa.user_id = u.id
     where u.role = 'student'
     group by u.id
     order by "bestPercent" desc, "averagePercent" desc, attempts desc, u.name asc`,
  );

  const { rows: recentAttempts } = await pool.query(
    `select qa.id, qa.score, qa.total_points as "totalPoints", qa.passed,
            qa.finished_at as "finishedAt",
            u.name as "studentName",
            l.title as "quizTitle",
            case when qa.total_points = 0 then 0 else round(qa.score::numeric * 100 / qa.total_points)::int end as percent
     from quiz_attempts qa
     join users u on u.id = qa.user_id
     join levels l on l.id = qa.level_id
     where u.role = 'student'
     order by qa.finished_at desc nulls last, qa.started_at desc
     limit 10`,
  );

  const { rows: friends } = await pool.query(
    `select cf.id, cf.friend_name as "friendName", cf.friend_email as "friendEmail",
            u.id as "studentId", u.name as "studentName", u.email as "studentEmail",
            coalesce(stats.attempts, 0)::int as attempts,
            coalesce(stats.best_percent, 0)::int as "bestPercent",
            coalesce(stats.average_percent, 0)::int as "averagePercent",
            stats.last_attempt_at as "lastAttemptAt"
     from competition_friends cf
     left join users u on lower(u.email) = lower(cf.friend_email)
     left join lateral (
       select count(qa.id)::int as attempts,
              coalesce(max(case when qa.total_points > 0 then round(qa.score::numeric * 100 / qa.total_points)::int end), 0)
                as best_percent,
              coalesce(round(avg(case when qa.total_points > 0 then qa.score::numeric * 100 / qa.total_points end)), 0)::int
                as average_percent,
              max(qa.finished_at) as last_attempt_at
       from quiz_attempts qa
       where qa.user_id = u.id
     ) stats on true
     where cf.owner_id = $1
     order by "bestPercent" desc, cf.created_at asc`,
    [userId],
  );

  return {
    leaderboard,
    recentAttempts,
    friends,
  };
}

export async function addCompetitionFriend(userId, friendName, friendEmail = null) {
  await ensureCompetitionTables();

  const { rows } = await pool.query(
    `insert into competition_friends (owner_id, friend_name, friend_email)
     values ($1, $2, $3)
     returning id, friend_name as "friendName", friend_email as "friendEmail", created_at as "createdAt"`,
    [userId, friendName, friendEmail || null],
  );

  return rows[0];
}

export async function deleteCompetitionFriend(userId, friendId) {
  await ensureCompetitionTables();

  await pool.query('delete from competition_friends where id = $1 and owner_id = $2', [friendId, userId]);
}
