export default function MatchingQuestion({ question, value = {}, onChange }) {
  const pairs = value.pairs || [];

  function updatePair(itemId, answer) {
    const withoutCurrent = pairs.filter((item) => item.item_id !== itemId);
    onChange({ pairs: [...withoutCurrent, { item_id: itemId, answer }] });
  }

  return (
    <div className="blank-grid">
      {question.items.map((item) => (
        <label key={item.id}>
          {item.label}
          <input
            value={pairs.find((pair) => pair.item_id === item.id)?.answer || ''}
            onChange={(event) => updatePair(item.id, event.target.value)}
          />
        </label>
      ))}
    </div>
  );
}
