import QcmQuestion from './QcmQuestion.jsx';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:4000';

export default function DiagramChoiceQuestion({ question, value, onChange }) {
  return (
    <div className="diagram-question">
      {question.image_url && <img src={`${API_URL}${question.image_url}`} alt="" />}
      <QcmQuestion question={question} value={value} onChange={onChange} />
    </div>
  );
}
