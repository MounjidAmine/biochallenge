const fs = require('fs');
const vm = require('vm');

const html = fs.readFileSync('proteines_exercices_source.html', 'utf8');
let script = html.match(/<script>([\s\S]*?)<\/script>/)[1];
script = script.slice(0, script.indexOf('/* INIT */'));

const context = {};
vm.createContext(context);
vm.runInContext(`${script}\nglobalThis.__quiz = { D1, D2, D3 };`, context);

const { D1, D2, D3 } = context.__quiz;

const levelIds = [
  'dddddddd-dddd-dddd-dddd-dddddddddd01',
  'dddddddd-dddd-dddd-dddd-dddddddddd02',
  'dddddddd-dddd-dddd-dddd-dddddddddd03',
];

const levels = [
  [
    'Biochimie - Proteines : QCM cours',
    'Fonctions, structures, liaisons et proprietes des proteines.',
    3,
    70,
  ],
  [
    'Biochimie - Proteines : structures des acides amines',
    'Identifier les structures chimiques des 20 acides amines.',
    4,
    70,
  ],
  [
    'Biochimie - Proteines : classification',
    'Classer les acides amines par familles et proprietes.',
    5,
    70,
  ],
];

function sql(value) {
  return String(value ?? '').replace(/'/g, "''");
}

function cleanHtml(value) {
  return String(value || '')
    .replace(/<\/?strong>/g, '')
    .replace(/<\/?em>/g, '')
    .replace(/<br\s*\/?>/g, ' ')
    .replace(/<[^>]+>/g, '')
    .replace(/\s+/g, ' ')
    .trim();
}

function questionId(number) {
  return `cccccccc-cccc-cccc-cccc-${String(number).padStart(12, '0')}`;
}

const questions = [];

function addQuestions(levelIndex, sourceQuestions, offset, svgOptions = false) {
  sourceQuestions.forEach((question, index) => {
    questions.push({
      id: questionId(offset + index + 1),
      levelId: levelIds[levelIndex],
      text: question.q,
      explanation: cleanHtml(question.fb),
      options: question.opts.map((option, optionIndex) => ({
        text: svgOptions ? `${option.svg}\n${option.lb}` : String(option),
        isCorrect: optionIndex === question.c,
        order: optionIndex + 1,
      })),
    });
  });
}

addQuestions(0, D1, 0);
addQuestions(1, D2, 10, true);
addQuestions(2, D3, 30);

let output = '\n-- Quiz Biochimie - Les Proteines, importe depuis proteines_exercices_source.html\n';

output += `update levels
set level_order = case id
  when 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3' then -6
  when 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4' then -7
  when 'dddddddd-dddd-dddd-dddd-dddddddddd01' then -3
  when 'dddddddd-dddd-dddd-dddd-dddddddddd02' then -4
  when 'dddddddd-dddd-dddd-dddd-dddddddddd03' then -5
  else level_order
end
where id in (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4',
  'dddddddd-dddd-dddd-dddd-dddddddddd01',
  'dddddddd-dddd-dddd-dddd-dddddddddd02',
  'dddddddd-dddd-dddd-dddd-dddddddddd03'
);

`;

output += 'insert into levels (id, title, description, level_order, is_paid, passing_score)\nvalues\n';
output += levels
  .map(
    (level, index) =>
      `  ('${levelIds[index]}', '${sql(level[0])}', '${sql(level[1])}', ${level[2]}, false, ${level[3]})`,
  )
  .join(',\n');
output += `\non conflict (id) do update set
  title = excluded.title,
  description = excluded.description,
  level_order = excluded.level_order,
  is_paid = excluded.is_paid,
  passing_score = excluded.passing_score;

update levels
set level_order = case id
  when 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3' then 6
  when 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4' then 7
  else level_order
end
where id in (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4'
);

`;

output += 'insert into questions (id, level_id, type, question_text, image_url, explanation, points)\nvalues\n';
output += questions
  .map(
    (question) =>
      `  ('${question.id}', '${question.levelId}', 'qcm_single', '${sql(question.text)}', null, '${sql(
        question.explanation,
      )}', 1)`,
  )
  .join(',\n');
output += `\non conflict (id) do update set
  level_id = excluded.level_id,
  type = excluded.type,
  question_text = excluded.question_text,
  image_url = excluded.image_url,
  explanation = excluded.explanation,
  points = excluded.points;

`;

output += 'insert into question_options (question_id, option_text, is_correct, option_order)\nvalues\n';
output += questions
  .flatMap((question) =>
    question.options.map(
      (option) =>
        `  ('${question.id}', '${sql(option.text)}', ${option.isCorrect}, ${option.order})`,
    ),
  )
  .join(',\n');
output += `\non conflict (question_id, option_order) do update set
  option_text = excluded.option_text,
  is_correct = excluded.is_correct;
`;

fs.writeFileSync('backend/db/proteines_seed.sql', output, 'utf8');
console.log(`Generated ${questions.length} questions in backend/db/proteines_seed.sql`);
