export function validateBody(schema) {
  return (req, res, next) => {
    const errors = [];

    for (const [field, rules] of Object.entries(schema)) {
      const value = req.body[field];
      const label = rules.label || field;

      if (rules.required && isEmpty(value)) {
        errors.push(`${label} est requis`);
        continue;
      }

      if (isEmpty(value)) continue;

      if (rules.type && !matchesType(value, rules.type)) {
        errors.push(`${label} doit etre de type ${rules.type}`);
      }

      if (rules.email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(String(value))) {
        errors.push(`${label} doit etre un email valide`);
      }

      if (rules.minLength && String(value).length < rules.minLength) {
        errors.push(`${label} doit contenir au moins ${rules.minLength} caracteres`);
      }

      if (rules.min !== undefined && Number(value) < rules.min) {
        errors.push(`${label} doit etre superieur ou egal a ${rules.min}`);
      }

      if (rules.max !== undefined && Number(value) > rules.max) {
        errors.push(`${label} doit etre inferieur ou egal a ${rules.max}`);
      }

      if (rules.enum && !rules.enum.includes(value)) {
        errors.push(`${label} est invalide`);
      }
    }

    if (errors.length > 0) {
      res.status(400).json({ message: 'Donnees invalides', errors });
      return;
    }

    next();
  };
}

export function validateQuestion(req, res, next) {
  let payload;

  try {
    payload = req.body.payload ? JSON.parse(req.body.payload) : req.body;
  } catch (_error) {
    res.status(400).json({ message: 'Payload question invalide' });
    return;
  }

  const errors = [];
  const questionTypes = [
    'qcm_single',
    'qcm_multiple',
    'true_false',
    'text_answer',
    'fill_blank',
    'diagram_choice',
    'diagram_labeling',
    'matching',
    'ordering',
  ];

  if (isEmpty(payload.level_id)) errors.push('Le niveau est requis');
  if (!questionTypes.includes(payload.type)) errors.push('Le type de question est invalide');
  if (isEmpty(payload.question_text)) errors.push('Le texte de la question est requis');
  if (payload.points !== undefined && Number(payload.points) < 1) errors.push('Les points doivent etre superieurs a 0');

  const options = payload.options || payload.question_options || [];
  const items = payload.items || payload.question_items || [];

  if (['qcm_single', 'qcm_multiple', 'true_false', 'diagram_choice'].includes(payload.type)) {
    if (!Array.isArray(options) || options.length < 2) {
      errors.push('Au moins deux options sont requises');
    }

    if (!options.some((option) => Boolean(option.is_correct ?? option.isCorrect))) {
      errors.push('Au moins une bonne reponse doit etre cochee');
    }

    if (options.some((option) => isEmpty(option.option_text || option.optionText))) {
      errors.push('Chaque option doit contenir un texte');
    }
  }

  if (['text_answer', 'fill_blank', 'diagram_labeling', 'matching', 'ordering'].includes(payload.type)) {
    if (!Array.isArray(items) || items.length < 1) {
      errors.push('Au moins un item est requis');
    }

    if (items.some((item) => isEmpty(item.label))) {
      errors.push('Chaque item doit contenir un label');
    }

    if (items.some((item) => isEmpty(item.correct_answer || item.correctAnswer))) {
      errors.push('Chaque item doit contenir une reponse correcte');
    }
  }

  if (['diagram_choice', 'diagram_labeling'].includes(payload.type) && isEmpty(payload.image_url || payload.imageUrl) && !req.file) {
    errors.push('Une image est requise pour ce type de question');
  }

  if (errors.length > 0) {
    res.status(400).json({ message: 'Question invalide', errors });
    return;
  }

  next();
}

export function validateSubmitAnswers(req, res, next) {
  if (!Array.isArray(req.body.answers)) {
    res.status(400).json({ message: 'Le champ answers doit etre un tableau' });
    return;
  }

  const invalidAnswer = req.body.answers.some(
    (answer) => isEmpty(answer.questionId || answer.question_id) || typeof (answer.answer_data || answer.answerData || {}) !== 'object',
  );

  if (invalidAnswer) {
    res.status(400).json({ message: 'Format des reponses invalide' });
    return;
  }

  next();
}

function isEmpty(value) {
  return value === undefined || value === null || String(value).trim() === '';
}

function matchesType(value, type) {
  if (type === 'number') return !Number.isNaN(Number(value));
  if (type === 'boolean') return typeof value === 'boolean';
  if (type === 'array') return Array.isArray(value);
  return typeof value === type;
}
