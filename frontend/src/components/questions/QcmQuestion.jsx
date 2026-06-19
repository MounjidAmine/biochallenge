export default function QcmQuestion({ question, value = {}, onChange }) {
  const isMultiple = question.type === 'qcm_multiple';
  const selectedIds = value.option_ids || [];

  function toggleOption(optionId, checked) {
    if (!isMultiple) {
      onChange({ option_id: optionId });
      return;
    }

    const next = new Set(selectedIds);
    checked ? next.add(optionId) : next.delete(optionId);
    onChange({ option_ids: [...next] });
  }

  function handleTrueFalse(option) {
    const text = String(option.option_text).toLowerCase();
    onChange({ value: text === 'vrai' || text === 'true' });
  }

  return (
    <div className="options-list">
      {question.options.map((option) => (
        <label className="option" key={option.id}>
          <input
            type={isMultiple ? 'checkbox' : 'radio'}
            name={question.id}
            checked={
              isMultiple
                ? selectedIds.includes(option.id)
                : question.type === 'true_false'
                  ? value.value === (String(option.option_text).toLowerCase() === 'vrai' || String(option.option_text).toLowerCase() === 'true')
                  : value.option_id === option.id
            }
            onChange={(event) => {
              if (question.type === 'true_false') handleTrueFalse(option);
              else toggleOption(option.id, event.target.checked);
            }}
          />
          <OptionContent text={option.option_text} />
        </label>
      ))}
    </div>
  );
}

function OptionContent({ text }) {
  const value = String(text || '');

  if (!value.trimStart().startsWith('<svg')) {
    return <span>{value}</span>;
  }

  const svgEnd = value.indexOf('</svg>');
  const svg = svgEnd >= 0 ? value.slice(0, svgEnd + 6) : value;
  const label = svgEnd >= 0 ? value.slice(svgEnd + 6).trim() : '';

  return (
    <span className="option-visual">
      <span dangerouslySetInnerHTML={{ __html: svg }} />
      {label && <span>{label}</span>}
    </span>
  );
}
