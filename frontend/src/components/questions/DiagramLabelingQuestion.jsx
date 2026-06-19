const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:4000';

export default function DiagramLabelingQuestion({ question, value = {}, onChange }) {
  const labels = value.labels || [];

  function updateLabel(itemId, answer) {
    const withoutCurrent = labels.filter((item) => item.item_id !== itemId);
    onChange({ labels: [...withoutCurrent, { item_id: itemId, answer }] });
  }

  return (
    <div className="diagram-question">
      {question.image_url && <img src={`${API_URL}${question.image_url}`} alt="" />}
      <div className="blank-grid">
        {question.items.map((item) => (
          <label key={item.id}>
            {item.label}
            <input
              value={labels.find((label) => label.item_id === item.id)?.answer || ''}
              onChange={(event) => updateLabel(item.id, event.target.value)}
            />
          </label>
        ))}
      </div>
    </div>
  );
}
