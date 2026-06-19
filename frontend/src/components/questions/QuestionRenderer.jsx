import DiagramChoiceQuestion from './DiagramChoiceQuestion.jsx';
import DiagramLabelingQuestion from './DiagramLabelingQuestion.jsx';
import FillBlankQuestion from './FillBlankQuestion.jsx';
import MatchingQuestion from './MatchingQuestion.jsx';
import OrderingQuestion from './OrderingQuestion.jsx';
import QcmQuestion from './QcmQuestion.jsx';
import TextAnswerQuestion from './TextAnswerQuestion.jsx';

export default function QuestionRenderer({ question, value, onChange }) {
  const props = { question, value, onChange };

  if (question.type === 'qcm_single' || question.type === 'qcm_multiple' || question.type === 'true_false') {
    return <QcmQuestion {...props} />;
  }

  if (question.type === 'text_answer') return <TextAnswerQuestion {...props} />;
  if (question.type === 'fill_blank') return <FillBlankQuestion {...props} />;
  if (question.type === 'diagram_choice') return <DiagramChoiceQuestion {...props} />;
  if (question.type === 'diagram_labeling') return <DiagramLabelingQuestion {...props} />;
  if (question.type === 'matching') return <MatchingQuestion {...props} />;
  if (question.type === 'ordering') return <OrderingQuestion {...props} />;

  return <p>Type de question non supporte.</p>;
}
