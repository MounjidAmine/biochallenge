import { pool } from '../config/db.js';
import { ensureCatalogTables, getStudentModules } from '../services/studentDashboardService.js';

const questionTypes = new Set([
  'qcm_single',
  'qcm_multiple',
  'true_false',
  'text_answer',
  'fill_blank',
  'diagram_choice',
  'diagram_labeling',
  'matching',
  'ordering',
]);

function parseQuestionPayload(req) {
  const payload = req.body.payload ? JSON.parse(req.body.payload) : req.body;

  return {
    ...payload,
    image_url: req.file ? `/uploads/${req.file.filename}` : payload.image_url || payload.imageUrl || null,
    options: payload.options || payload.question_options || [],
    items: payload.items || payload.question_items || [],
  };
}

function numberOrNull(value) {
  return value === '' || value === undefined || value === null ? null : Number(value);
}

function slugify(value) {
  return String(value)
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

function toTextArray(value) {
  if (Array.isArray(value)) return value.map((item) => String(item).trim()).filter(Boolean);
  return String(value || '')
    .split(',')
    .map((item) => item.trim())
    .filter(Boolean);
}

export async function getLevels(_req, res, next) {
  try {
    await ensureCatalogTables();
    const { rows } = await pool.query(
      `select l.*, p.title as part_title, p.slug as part_slug,
              m.id as module_id, m.title as module_title
       from levels l
       left join module_parts p on p.id = l.part_id
       left join modules m on m.id = p.module_id
       order by l.level_order asc`,
    );
    res.json(rows);
  } catch (error) {
    next(error);
  }
}

export async function getModules(_req, res, next) {
  try {
    res.json(await getStudentModules(null));
  } catch (error) {
    next(error);
  }
}

export async function createModule(req, res, next) {
  const { title, description = '', module_order = 1 } = req.body;

  try {
    await ensureCatalogTables();
    const { rows } = await pool.query(
      `insert into modules (title, description, slug, module_order)
       values ($1, $2, $3, $4)
       returning *`,
      [title, description, slugify(req.body.slug || title), module_order],
    );
    res.status(201).json(rows[0]);
  } catch (error) {
    next(error);
  }
}

export async function updateModule(req, res, next) {
  const { title, description = '', module_order = 1 } = req.body;

  try {
    await ensureCatalogTables();
    const { rows } = await pool.query(
      `update modules
       set title = $1, description = $2, slug = $3, module_order = $4
       where id = $5
       returning *`,
      [title, description, slugify(req.body.slug || title), module_order, req.params.id],
    );

    if (!rows[0]) {
      res.status(404).json({ message: 'Module introuvable' });
      return;
    }

    res.json(rows[0]);
  } catch (error) {
    next(error);
  }
}

export async function deleteModule(req, res, next) {
  try {
    await ensureCatalogTables();
    await pool.query('delete from modules where id = $1', [req.params.id]);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
}

export async function createPart(req, res, next) {
  const { module_id, title, description = '', part_order = 1, source_files = [], keywords = [] } = req.body;

  try {
    await ensureCatalogTables();
    const { rows } = await pool.query(
      `insert into module_parts (module_id, title, description, slug, part_order, source_files, keywords)
       values ($1, $2, $3, $4, $5, $6, $7)
       returning *`,
      [module_id, title, description, slugify(req.body.slug || title), part_order, toTextArray(source_files), toTextArray(keywords)],
    );
    res.status(201).json(rows[0]);
  } catch (error) {
    next(error);
  }
}

export async function updatePart(req, res, next) {
  const { module_id, title, description = '', part_order = 1, source_files = [], keywords = [] } = req.body;

  try {
    await ensureCatalogTables();
    const { rows } = await pool.query(
      `update module_parts
       set module_id = $1, title = $2, description = $3, slug = $4,
           part_order = $5, source_files = $6, keywords = $7
       where id = $8
       returning *`,
      [
        module_id,
        title,
        description,
        slugify(req.body.slug || title),
        part_order,
        toTextArray(source_files),
        toTextArray(keywords),
        req.params.id,
      ],
    );

    if (!rows[0]) {
      res.status(404).json({ message: 'Partie introuvable' });
      return;
    }

    res.json(rows[0]);
  } catch (error) {
    next(error);
  }
}

export async function deletePart(req, res, next) {
  try {
    await ensureCatalogTables();
    await pool.query('delete from module_parts where id = $1', [req.params.id]);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
}

export async function createLevel(req, res, next) {
  const { title, description, level_order, is_paid = false, passing_score = 70, part_id = null } = req.body;

  try {
    await ensureCatalogTables();
    const { rows } = await pool.query(
      `insert into levels (title, description, level_order, is_paid, passing_score, part_id)
       values ($1, $2, $3, $4, $5, $6)
       returning *`,
      [title, description, level_order, is_paid, passing_score, part_id],
    );
    res.status(201).json(rows[0]);
  } catch (error) {
    next(error);
  }
}

export async function updateLevel(req, res, next) {
  const { title, description, level_order, is_paid = false, passing_score = 70, part_id = null } = req.body;

  try {
    await ensureCatalogTables();
    const { rows } = await pool.query(
      `update levels
       set title = $1, description = $2, level_order = $3, is_paid = $4, passing_score = $5, part_id = $6
       where id = $7
       returning *`,
      [title, description, level_order, is_paid, passing_score, part_id, req.params.id],
    );

    if (!rows[0]) {
      res.status(404).json({ message: 'Niveau introuvable' });
      return;
    }

    res.json(rows[0]);
  } catch (error) {
    next(error);
  }
}

export async function deleteLevel(req, res, next) {
  try {
    await pool.query('delete from levels where id = $1', [req.params.id]);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
}

export async function getQuestions(req, res, next) {
  try {
    await ensureCatalogTables();
    const params = [];
    const filters = [];
    if (req.query.level_id) {
      params.push(req.query.level_id);
      filters.push(`q.level_id = $${params.length}`);
    }
    if (req.query.part_id) {
      params.push(req.query.part_id);
      filters.push(`l.part_id = $${params.length}`);
    }
    const where = filters.length ? `where ${filters.join(' and ')}` : '';

    const { rows } = await pool.query(
      `select q.*, l.title as level_title, l.part_id, p.title as part_title,
              coalesce(json_agg(distinct qo.*) filter (where qo.id is not null), '[]') as options,
              coalesce(json_agg(distinct qi.*) filter (where qi.id is not null), '[]') as items
       from questions q
       join levels l on l.id = q.level_id
       left join module_parts p on p.id = l.part_id
       left join question_options qo on qo.question_id = q.id
       left join question_items qi on qi.question_id = q.id
       ${where}
       group by q.id, l.title, l.part_id, p.title
       order by q.created_at desc`,
      params,
    );
    res.json(rows);
  } catch (error) {
    next(error);
  }
}

export async function createQuestion(req, res, next) {
  const client = await pool.connect();

  try {
    const payload = parseQuestionPayload(req);

    if (!questionTypes.has(payload.type)) {
      res.status(400).json({ message: 'Type de question invalide' });
      return;
    }

    await client.query('begin');
    const { rows } = await client.query(
      `insert into questions (level_id, type, question_text, image_url, explanation, points)
       values ($1, $2, $3, $4, $5, $6)
       returning *`,
      [
        payload.level_id,
        payload.type,
        payload.question_text,
        payload.image_url,
        payload.explanation || null,
        payload.points || 1,
      ],
    );

    await replaceQuestionChildren(client, rows[0].id, payload.options, payload.items);
    await client.query('commit');

    res.status(201).json(rows[0]);
  } catch (error) {
    await client.query('rollback');
    next(error);
  } finally {
    client.release();
  }
}

export async function updateQuestion(req, res, next) {
  const client = await pool.connect();

  try {
    const payload = parseQuestionPayload(req);

    if (!questionTypes.has(payload.type)) {
      res.status(400).json({ message: 'Type de question invalide' });
      return;
    }

    await client.query('begin');
    const { rows } = await client.query(
      `update questions
       set level_id = $1, type = $2, question_text = $3,
           image_url = coalesce($4, image_url), explanation = $5, points = $6
       where id = $7
       returning *`,
      [
        payload.level_id,
        payload.type,
        payload.question_text,
        payload.image_url,
        payload.explanation || null,
        payload.points || 1,
        req.params.id,
      ],
    );

    if (!rows[0]) {
      await client.query('rollback');
      res.status(404).json({ message: 'Question introuvable' });
      return;
    }

    await replaceQuestionChildren(client, req.params.id, payload.options, payload.items);
    await client.query('commit');

    res.json(rows[0]);
  } catch (error) {
    await client.query('rollback');
    next(error);
  } finally {
    client.release();
  }
}

export async function deleteQuestion(req, res, next) {
  try {
    await pool.query('delete from questions where id = $1', [req.params.id]);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
}

export async function uploadQuestionImage(req, res) {
  if (!req.file) {
    res.status(400).json({ message: 'Image manquante' });
    return;
  }

  res.status(201).json({
    image_url: `/uploads/${req.file.filename}`,
  });
}

export async function getResults(_req, res, next) {
  try {
    await ensureCatalogTables();
    const { rows } = await pool.query(
      `select qa.id, qa.user_id, qa.level_id, qa.score, qa.total_points, qa.passed,
              qa.started_at, qa.finished_at,
              u.name as student_name, u.email as student_email,
              l.title as level_title,
              p.title as part_title,
              m.title as module_title
       from quiz_attempts qa
       join users u on u.id = qa.user_id
       join levels l on l.id = qa.level_id
       left join module_parts p on p.id = l.part_id
       left join modules m on m.id = p.module_id
       order by coalesce(qa.finished_at, qa.started_at) desc`,
    );
    res.json(rows);
  } catch (error) {
    next(error);
  }
}

export async function getLevelAnalytics(req, res, next) {
  const { levelId } = req.params;

  try {
    const { rows: levelRows } = await pool.query(
      `select id, title, level_order, is_paid, passing_score
       from levels
       where id = $1`,
      [levelId],
    );
    const level = levelRows[0];

    if (!level) {
      res.status(404).json({ message: 'Niveau introuvable' });
      return;
    }

    const { rows: summaryRows } = await pool.query(
      `select
          count(u.id)::int as total_students,
          count(up.id)::int as students_with_progress,
          count(*) filter (where coalesce(up.completed, false))::int as completed_students,
          count(*) filter (where coalesce(up.unlocked, l.level_order = 1))::int as unlocked_students,
          coalesce(round(avg(up.best_score))::int, 0) as average_best_score,
          coalesce(max(up.best_score), 0)::int as best_score
       from users u
       cross join levels l
       left join user_progress up on up.user_id = u.id and up.level_id = l.id
       where u.role = 'student' and l.id = $1`,
      [levelId],
    );

    const { rows: studentRows } = await pool.query(
      `select
          u.id as user_id,
          u.name,
          u.email,
          u.is_premium,
          coalesce(up.unlocked, l.level_order = 1) as unlocked,
          coalesce(up.completed, false) as completed,
          coalesce(up.best_score, 0)::int as best_score,
          up.updated_at,
          count(qa.id)::int as attempts,
          coalesce(max(qa.score), 0)::int as max_points,
          max(qa.finished_at) as last_attempt_at,
          bool_or(coalesce(qa.passed, false)) as passed_attempt
       from users u
       cross join levels l
       left join user_progress up on up.user_id = u.id and up.level_id = l.id
       left join quiz_attempts qa on qa.user_id = u.id and qa.level_id = l.id
       where u.role = 'student' and l.id = $1
       group by u.id, u.name, u.email, u.is_premium, up.unlocked, up.completed, up.best_score, up.updated_at, l.level_order
       order by completed desc, best_score desc, attempts desc, u.name asc`,
      [levelId],
    );

    const summary = summaryRows[0];
    res.json({
      level,
      summary: {
        ...summary,
        completion_rate:
          summary.total_students === 0
            ? 0
            : Math.round((summary.completed_students / summary.total_students) * 100),
      },
      students: studentRows.map((student) => ({
        ...student,
        status: student.completed
          ? 'completed'
          : student.unlocked
            ? 'in_progress'
            : 'locked',
      })),
    });
  } catch (error) {
    next(error);
  }
}

async function replaceQuestionChildren(client, questionId, options = [], items = []) {
  await client.query('delete from question_options where question_id = $1', [questionId]);
  await client.query('delete from question_items where question_id = $1', [questionId]);

  for (const [index, option] of options.entries()) {
    await client.query(
      `insert into question_options (question_id, option_text, is_correct, option_order)
       values ($1, $2, $3, $4)`,
      [
        questionId,
        option.option_text || option.optionText,
        Boolean(option.is_correct ?? option.isCorrect),
        option.option_order || option.optionOrder || index + 1,
      ],
    );
  }

  for (const [index, item] of items.entries()) {
    await client.query(
      `insert into question_items
       (question_id, label, correct_answer, position_x, position_y, item_order)
       values ($1, $2, $3, $4, $5, $6)`,
      [
        questionId,
        item.label,
        item.correct_answer || item.correctAnswer,
        numberOrNull(item.position_x ?? item.positionX),
        numberOrNull(item.position_y ?? item.positionY),
        item.item_order || item.itemOrder || index + 1,
      ],
    );
  }
}
