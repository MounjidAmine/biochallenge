export default function FillBlankQuestion({ question, value = {}, onChange }) {
  const count = Math.max(question.items?.length || 1, 1);
  const blanks = value.blanks || Array.from({ length: count }, () => '');

  function updateBlank(index, nextValue) {
    const next = [...blanks];
    next[index] = nextValue;
    onChange({ blanks: next });
  }

  return (
    <div className="blank-grid">
      {Array.from({ length: count }).map((_, index) => (
        <label key={index}>
          Blanc {index + 1}
          <input value={blanks[index] || ''} onChange={(event) => updateBlank(index, event.target.value)} />
        </label>
      ))}
    </div>
  );
}
