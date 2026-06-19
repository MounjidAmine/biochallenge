function normalizeText(value) {
  return String(value ?? '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/\s+/g, '');
}

function asString(value) {
  return String(value);
}

function sameOrderedIds(submitted = [], expected = []) {
  return (
    submitted.length === expected.length &&
    submitted.map(asString).every((value, index) => value === asString(expected[index]))
  );
}

function sameUnorderedIds(submitted = [], expected = []) {
  const submittedIds = submitted.map(asString).sort();
  const expectedIds = expected.map(asString).sort();

  return (
    submittedIds.length === expectedIds.length &&
    submittedIds.every((value, index) => value === expectedIds[index])
  );
}

function correctOptions(question) {
  return (question.options || []).filter((option) => option.is_correct);
}

function itemsByOrder(question) {
  return [...(question.items || [])].sort((a, b) => a.item_order - b.item_order);
}

function answerByItemId(entries = [], itemId) {
  return entries.find((entry) => asString(entry.item_id) === asString(itemId))?.answer;
}

export function gradeQcmSingle(question, answerData = {}) {
  const correct = correctOptions(question);
  return correct.length === 1 && asString(answerData.option_id) === asString(correct[0].id);
}

export function gradeQcmMultiple(question, answerData = {}) {
  return sameUnorderedIds(
    answerData.option_ids || [],
    correctOptions(question).map((option) => option.id),
  );
}

export function gradeTrueFalse(question, answerData = {}) {
  const correct = correctOptions(question);

  if (correct.length === 0) {
    return false;
  }

  const expected = normalizeText(correct[0].option_text) === 'vrai' || correct[0].option_text === 'true';
  return Boolean(answerData.value) === expected;
}

export function gradeTextAnswer(question, answerData = {}) {
  return (question.items || []).some(
    (item) => normalizeText(answerData.text) === normalizeText(item.correct_answer),
  );
}

export function gradeFillBlank(question, answerData = {}) {
  const blanks = answerData.blanks || [];
  const expectedItems = itemsByOrder(question);

  return (
    blanks.length === expectedItems.length &&
    blanks.every((blank, index) => normalizeText(blank) === normalizeText(expectedItems[index].correct_answer))
  );
}

export function gradeDiagramChoice(question, answerData = {}) {
  const correct = correctOptions(question);
  return correct.length === 1 && asString(answerData.option_id) === asString(correct[0].id);
}

export function gradeDiagramLabeling(question, answerData = {}) {
  const labels = answerData.labels || [];
  const expectedItems = question.items || [];

  return (
    expectedItems.length > 0 &&
    expectedItems.every(
      (item) => normalizeText(answerByItemId(labels, item.id)) === normalizeText(item.correct_answer),
    )
  );
}

export function gradeMatching(question, answerData = {}) {
  const pairs = answerData.pairs || [];
  const expectedItems = question.items || [];

  return (
    expectedItems.length > 0 &&
    expectedItems.every(
      (item) => normalizeText(answerByItemId(pairs, item.id)) === normalizeText(item.correct_answer),
    )
  );
}

export function gradeOrdering(question, answerData = {}) {
  return sameOrderedIds(
    answerData.order || [],
    itemsByOrder(question).map((item) => item.id),
  );
}

export function gradeQuestion(question, answerData = {}) {
  const graders = {
    qcm_single: gradeQcmSingle,
    qcm_multiple: gradeQcmMultiple,
    true_false: gradeTrueFalse,
    text_answer: gradeTextAnswer,
    fill_blank: gradeFillBlank,
    diagram_choice: gradeDiagramChoice,
    diagram_labeling: gradeDiagramLabeling,
    matching: gradeMatching,
    ordering: gradeOrdering,
  };
  const grade = graders[question.type];
  const isCorrect = grade ? grade(question, answerData) : false;

  return {
    isCorrect,
    pointsEarned: isCorrect ? question.points : 0,
  };
}
