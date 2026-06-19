export default function TextAnswerQuestion({ value = {}, onChange }) {
  return (
    <label>
      Reponse
      <input value={value.text || ''} onChange={(event) => onChange({ text: event.target.value })} />
    </label>
  );
}
