const fs = require('fs');
const vm = require('vm');

const PART_SLUGS = {
  proteines: 'proteines',
  glucides: 'glucides',
  lipides: 'lipides',
  cardio: 'cardio',
  respiration: 'respiration',
};

const htmlSpecs = [
  {
    key: 'glucides',
    file: 'module/glucides.html',
    prefix: '10000000-0000-0000-0000',
    levelPrefix: '11111111-2222-3333-4444',
    orderStart: 8,
    levels: [
      ['Biochimie - Glucides : QCM cours', 'Definitions, classification, proprietes et reactions des glucides.'],
      ['Biochimie - Glucides : structures', 'Identifier les structures des oses et osides.'],
      ['Biochimie - Glucides : classification', 'Classer les glucides et reconnaitre leurs proprietes.'],
    ],
  },
  {
    key: 'lipides',
    file: 'module/lipides.html',
    prefix: '20000000-0000-0000-0000',
    levelPrefix: '22222222-3333-4444-5555',
    orderStart: 11,
    levels: [
      ['Biochimie - Lipides : QCM cours', 'Definitions, acides gras, phospholipides et proprietes des lipides.'],
      ['Biochimie - Lipides : structures', 'Identifier les structures des lipides et acides gras.'],
      ['Biochimie - Lipides : classification', 'Classer les lipides et reconnaitre leurs proprietes.'],
    ],
  },
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

function cleanText(value) {
  return String(value || '')
    .replace(/\u0000/g, '')
    .replace(/\u000b/g, '\n')
    .replace(/\r/g, '\n')
    .replace(/[ \t]+\n/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .trim();
}

function id(prefix, number) {
  return `${prefix}-${String(number).padStart(12, '0')}`;
}

function readDocText(file) {
  const buffer = fs.readFileSync(file);
  const latin = buffer.toString('latin1');
  const utf16 = buffer.toString('utf16le');
  return cleanText(`${latin}\n${utf16}`);
}

function readHtmlData(spec) {
  const html = fs.readFileSync(spec.file, 'utf8');
  let script = html.match(/<script>([\s\S]*?)<\/script>/)?.[1];
  if (!script) throw new Error(`No script in ${spec.file}`);
  script = script.slice(0, script.indexOf('/* INIT */'));

  const context = {};
  vm.createContext(context);
  vm.runInContext(`${script}\nglobalThis.__quiz = { D1, D2, D3 };`, context);

  const source = [context.__quiz.D1, context.__quiz.D2, context.__quiz.D3];
  const levelIds = spec.levels.map((_, index) => id(spec.levelPrefix, index + 1));
  const questions = [];
  let offset = 1;

  source.forEach((items, levelIndex) => {
    items.forEach((question) => {
      questions.push({
        id: id(spec.prefix, offset++),
        levelId: levelIds[levelIndex],
        type: 'qcm_single',
        text: question.q,
        explanation: cleanHtml(question.fb),
        options: question.opts.map((option, optionIndex) => ({
          text: typeof option === 'object' ? `${option.svg || ''}\n${option.lb || ''}`.trim() : String(option),
          isCorrect: optionIndex === question.c,
          order: optionIndex + 1,
        })),
      });
    });
  });

  return {
    partSlug: PART_SLUGS[spec.key],
    levels: spec.levels.map((level, index) => ({
      id: levelIds[index],
      title: level[0],
      description: level[1],
      order: spec.orderStart + index,
    })),
    questions,
  };
}

function parseCardioDoc() {
  const text = readDocText('module/cardio.doc');
  const match = text.match(/Q1[\s\S]*?Q10[\s\S]*?Le c.t. gauche\./);
  if (!match) return [];
  const block = match[0].replace(/\r/g, '');
  const regex = /Q(\d+)\s*-?\s*([\s\S]*?)(?=\nQ\d+\s*-?|$)/g;
  const questions = [];
  let item;

  while ((item = regex.exec(block))) {
    const lines = cleanText(item[2]).split('\n').map((line) => line.trim()).filter(Boolean);
    const answer = lines.pop();
    const question = lines.join(' ');
    if (question && answer) {
      questions.push({ question, answer });
    }
  }

  return questions;
}

function parseCardio2Doc() {
  const text = readDocText('module/cardio2.doc');
  const start = text.indexOf('QUESTIONS ET REPONSES');
  if (start === -1) return [];
  const block = text.slice(start).replace(/\r/g, '');
  const regex = /(?:^|\n)\s*(\d+)\.\s+([\s\S]*?)(?=\n\s*\d+\.\s+|$)/g;
  const questions = [];
  let item;

  while ((item = regex.exec(block))) {
    const lines = cleanText(item[2]).split('\n').map((line) => line.trim()).filter(Boolean);
    const question = lines.shift();
    const answer = lines.join(' ');
    if (question && answer && questions.length < 40) {
      questions.push({ question, answer });
    }
  }

  return questions;
}

function makeTextAnswerLevel({ levelId, title, description, order, partSlug, questionPrefix, pairs }) {
  const questions = pairs.map((pair, index) => ({
    id: id(questionPrefix, index + 1),
    levelId,
    type: 'text_answer',
    text: pair.question,
    explanation: pair.answer,
    items: [{ label: 'Reponse', correct_answer: pair.answer, item_order: 1 }],
  }));

  return {
    partSlug,
    levels: [{ id: levelId, title, description, order }],
    questions,
  };
}

function makeQcmLevel({ levelId, title, description, order, partSlug, questionPrefix, questions }) {
  return {
    partSlug,
    levels: [{ id: levelId, title, description, order }],
    questions: questions.map((question, index) => ({
      id: id(questionPrefix, index + 1),
      levelId,
      type: 'qcm_single',
      text: question.q,
      explanation: question.explanation || `Bonne reponse : ${question.options[question.correct]}.`,
      options: question.options.map((text, optionIndex) => ({
        text,
        isCorrect: optionIndex === question.correct,
        order: optionIndex + 1,
      })),
    })),
  };
}

const respirationQuestions = [
  { q: 'Quelle structure pulmonaire est le site principal des echanges gazeux ?', options: ['Bronches', 'Alveoles', 'Trachee', 'Plevre'], correct: 1 },
  { q: 'Le surfactant pulmonaire a pour role principal :', options: ["Transporter l'oxygene", 'Reduire la tension superficielle dans les alveoles', 'Proteger les bronches des infections', 'Produire du mucus'], correct: 1 },
  { q: 'Quelle cellule produit le surfactant dans les poumons ?', options: ['Pneumocyte de type I', 'Pneumocyte de type II', 'Macrophage alveolaire', 'Cellule ciliee'], correct: 1 },
  { q: 'Les alveoles sont entourees de :', options: ['Cartilage', 'Capillaires pulmonaires', 'Bronchioles', 'Membrane basale epaisse'], correct: 1 },
  { q: "Quel muscle est principalement responsable de l'inspiration normale ?", options: ['Muscles intercostaux externes', 'Diaphragme', 'Sternocleidomastoidien', 'Scalenes'], correct: 1 },
  { q: 'La ventilation pulmonaire est regulee par quel centre ?', options: ['Cortex moteur', 'Bulbe rachidien', 'Hypothalamus', 'Moelle epiniere lombaire'], correct: 1 },
  { q: 'La plevre viscerale recouvre :', options: ['La cage thoracique', 'Les poumons', 'Le diaphragme', 'Les bronches'], correct: 1 },
  { q: 'Le dioxyde de carbone est transporte dans le sang principalement sous forme :', options: ['Dissous dans le plasma', "Combine a l'hemoglobine", 'Sous forme de bicarbonate', 'Sous forme de carbone libre'], correct: 2 },
  { q: "Le transport principal de l'O2 dans le sang se fait via :", options: ['Plasma libre', 'Hemoglobine', 'Leucocytes', 'Plaquettes'], correct: 1 },
  { q: 'Lequel de ces gaz joue le role principal dans la stimulation de la respiration ?', options: ['Oxygene', 'Dioxyde de carbone', 'Azote', 'Methane'], correct: 1 },
  { q: 'Les macrophages alveolaires ont pour fonction principale :', options: ['Produire du surfactant', 'Detruire les particules etrangeres', "Transporter l'oxygene", 'Secreter du mucus'], correct: 1 },
  { q: 'Les bronchioles terminales menent directement a :', options: ['Bronches principales', 'Alveoles', 'Bronchioles respiratoires', 'Trachee'], correct: 2 },
  { q: 'Le volume pulmonaire augmente lors de :', options: ['Inspiration', 'Expiration', 'Repos', 'Apnee'], correct: 0 },
  { q: "L'expiration au repos est :", options: ['Active', 'Hormonale', 'Volontaire', 'Passive'], correct: 3 },
  { q: 'Lequel de ces organes ne fait pas partie des voies respiratoires superieures ?', options: ['Le larynx', 'La trachee', 'Le pharynx', 'Le nez'], correct: 1 },
  { q: "Comment appelle-t-on le volume d'air inhale ou exhale lors d'une respiration normale ?", options: ['Volume courant (VC)', 'Volume residuel (VR)', 'Volume de reserve inspiratoire (VRI)', 'Capacite vitale (CV)'], correct: 0 },
  { q: 'Laquelle de ces structures contient des anneaux de cartilage en forme de C pour maintenir son ouverture ?', options: ["L'oesophage", 'Les capillaires pulmonaires', 'La trachee', 'Les bronchioles'], correct: 2 },
  { q: "Qu'est-ce que l'espace mort anatomique ?", options: ["Le volume d'air dans les voies de conduction qui ne participe pas aux echanges gazeux", 'Une zone pulmonaire detruite par une pathologie', "Le volume d'air restant apres une expiration forcee", "L'espace entre les deux feuillets de la plevre"], correct: 0 },
  { q: "La diffusion de l'oxygene a travers la membrane alveolo-capillaire depend de :", options: ['La tension superficielle', "La surface disponible et l'epaisseur de la membrane", 'La presence de macrophages', 'La secretion de mucus'], correct: 1 },
  { q: 'Quel type d epithelium tapisse la majorite des voies respiratoires superieures ?', options: ['Epithelium squameux stratifie', 'Epithelium pseudo-stratifie cilie avec cellules caliciformes', 'Epithelium cubique simple', 'Epithelium cylindrique simple'], correct: 1 },
  { q: "Qu'indique une deviation vers la droite de la courbe de dissociation de l'oxyhemoglobine ?", options: ["Une augmentation de l'affinite de l'hemoglobine pour l'oxygene", 'Une baisse du 2,3-DPG', 'Une diminution de la temperature corporelle', 'Une baisse du pH sanguin (acidose)'], correct: 3 },
  { q: 'Quelle est la principale difference entre les chemorecepteurs centraux et peripheriques ?', options: ['Les peripheriques ne sont sensibles qu au pH', 'Les centraux reagissent plus rapidement que les peripheriques', 'Les peripheriques sont les seuls sensibles a une baisse directe de la PaO2', 'Les centraux sont situes dans les corps carotidiens'], correct: 2 },
  { q: 'La capacite residuelle fonctionnelle (CRF) est la somme de quels volumes ?', options: ['Volume de reserve expiratoire + volume residuel', 'Volume courant + volume de reserve expiratoire', 'Volume de reserve inspiratoire + volume courant', 'Volume residuel + capacite vitale'], correct: 0 },
  { q: "Dans le modele de West, pourquoi le rapport ventilation/perfusion (V/Q) est-il plus eleve a l'apex du poumon ?", options: ['La ventilation y est maximale', "Il n'y a pas d'alveoles a l'apex", 'Le surfactant y est absent', "La gravite reduit massivement la perfusion a l'apex"], correct: 3 },
  { q: "Quelle loi physique explique que la vitesse de diffusion d'un gaz est inversement proportionnelle a l'epaisseur de la membrane ?", options: ['Loi de Poiseuille', 'Loi de Henry', 'Loi de Dalton', 'Loi de Fick'], correct: 3 },
  { q: 'Un patient presente un rapport de Tiffeneau (VEMS/CV) abaisse. Quel est le diagnostic le plus probable ?', options: ['Anemie severe', 'Syndrome obstructif (ex : asthme)', 'Syndrome restrictif (ex : fibrose)', 'Embolie pulmonaire'], correct: 1 },
  { q: 'Au repos, la pression intrapleurale est normalement :', options: ['Toujours egale a la pression alveolaire', 'Positive par rapport a la pression atmospherique', 'Negative (subatmospherique)', 'Nulle'], correct: 2 },
  { q: "Quel effet a une hyperventilation sur l'equilibre acido-basique ?", options: ['Augmente la concentration de protons (H+)', 'Provoque une alcalose respiratoire', "N'a aucun effet sur le pH", 'Provoque une acidose respiratoire'], correct: 1 },
  { q: "L'innervation parasympathique des poumons via le nerf vague (X) provoque :", options: ['Une inhibition des secretions de mucus', 'Une acceleration du rythme respiratoire', 'Une bronchoconstriction', 'Une bronchodilatation'], correct: 2 },
  { q: 'Quelle structure anatomique empeche les aliments de penetrer dans les voies respiratoires lors de la deglutition ?', options: ["L'epiglotte", 'Le cartilage cricoide', 'Les cordes vocales', 'La glotte'], correct: 0 },
  { q: "La pression partielle en oxygene dans l'air alveolaire (PAO2) est d'environ :", options: ['40 mmHg', '760 mmHg', '100 mmHg', '160 mmHg'], correct: 2 },
  { q: "Lors d'un exercice intense, comment evolue la pression arterielle pulmonaire ?", options: ['Elle diminue fortement', 'Elle reste parfaitement identique au repos', 'Elle depasse la pression arterielle systemique', 'Elle augmente legerement grace au recrutement de capillaires'], correct: 3 },
];

const imports = [
  ...htmlSpecs.map(readHtmlData),
  makeTextAnswerLevel({
    levelId: '33333333-4444-5555-6666-000000000001',
    title: 'Anatomie - Cardio : questions courtes',
    description: 'Questions et reponses de base extraites de cardio.doc.',
    order: 14,
    partSlug: PART_SLUGS.cardio,
    questionPrefix: '30000000-0000-0000-0000',
    pairs: parseCardioDoc(),
  }),
  makeTextAnswerLevel({
    levelId: '33333333-4444-5555-6666-000000000002',
    title: 'Anatomie - Cardio : physiologie cardiovasculaire',
    description: 'Questions et reponses extraites de cardio2.doc.',
    order: 15,
    partSlug: PART_SLUGS.cardio,
    questionPrefix: '31000000-0000-0000-0000',
    pairs: parseCardio2Doc(),
  }),
  makeQcmLevel({
    levelId: '44444444-5555-6666-7777-000000000001',
    title: 'Anatomie - Respiration : QCM',
    description: 'QCM respiration extraits de respiration.doc.',
    order: 16,
    partSlug: PART_SLUGS.respiration,
    questionPrefix: '40000000-0000-0000-0000',
    questions: respirationQuestions,
  }),
];

const allLevels = imports.flatMap((item) => item.levels.map((level) => ({ ...level, partSlug: item.partSlug })));
const allQuestions = imports.flatMap((item) => item.questions);
const allOptions = allQuestions.flatMap((question) => question.options?.map((option) => ({ ...option, questionId: question.id })) || []);
const allItems = allQuestions.flatMap((question) => question.items?.map((item) => ({ ...item, questionId: question.id })) || []);

let output = '-- Quiz importes depuis le dossier module (hors proteines deja seed).\n\n';

output += 'insert into levels (id, title, description, level_order, is_paid, passing_score, part_id)\nvalues\n';
output += allLevels
  .map((level) => `  ('${level.id}', '${sql(level.title)}', '${sql(level.description)}', ${level.order}, false, 70, (select id from module_parts where slug = '${level.partSlug}'))`)
  .join(',\n');
output += `\non conflict (id) do update set
  title = excluded.title,
  description = excluded.description,
  level_order = excluded.level_order,
  is_paid = excluded.is_paid,
  passing_score = excluded.passing_score,
  part_id = excluded.part_id;

`;

output += 'insert into questions (id, level_id, type, question_text, image_url, explanation, points)\nvalues\n';
output += allQuestions
  .map((question) => `  ('${question.id}', '${question.levelId}', '${question.type}', '${sql(question.text)}', null, '${sql(question.explanation)}', 1)`)
  .join(',\n');
output += `\non conflict (id) do update set
  level_id = excluded.level_id,
  type = excluded.type,
  question_text = excluded.question_text,
  image_url = excluded.image_url,
  explanation = excluded.explanation,
  points = excluded.points;

`;

if (allOptions.length) {
  output += 'insert into question_options (question_id, option_text, is_correct, option_order)\nvalues\n';
  output += allOptions
    .map((option) => `  ('${option.questionId}', '${sql(option.text)}', ${option.isCorrect}, ${option.order})`)
    .join(',\n');
  output += `\non conflict (question_id, option_order) do update set
  option_text = excluded.option_text,
  is_correct = excluded.is_correct;

`;
}

if (allItems.length) {
  output += 'insert into question_items (question_id, label, correct_answer, position_x, position_y, item_order)\nvalues\n';
  output += allItems
    .map((item) => `  ('${item.questionId}', '${sql(item.label)}', '${sql(item.correct_answer)}', null, null, ${item.item_order})`)
    .join(',\n');
  output += `\non conflict (question_id, item_order) do update set
  label = excluded.label,
  correct_answer = excluded.correct_answer,
  position_x = excluded.position_x,
  position_y = excluded.position_y;
`;
}

fs.writeFileSync('backend/db/module_quiz_seed.sql', output, 'utf8');
console.log(`Generated ${allLevels.length} levels, ${allQuestions.length} questions, ${allOptions.length} options, ${allItems.length} items.`);
