import { ArrowLeft, ArrowRight, CheckCircle2, Clock3, XCircle } from 'lucide-react';
import { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import api from '../../api/api.js';
import QuestionRenderer from '../../components/questions/QuestionRenderer.jsx';

export default function Quiz() {
  const { levelId } = useParams();
  const [questions, setQuestions] = useState([]);
  const [answers, setAnswers] = useState({});
  const [currentIndex, setCurrentIndex] = useState(0);
  const [result, setResult] = useState(null);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    setLoading(true);
    setError('');
    api
      .get(`/api/student/levels/${levelId}/questions`)
      .then(({ data }) => {
        setQuestions(data);
        setAnswers({});
        setCurrentIndex(0);
        setResult(null);
      })
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false));
  }, [levelId]);

  function saveAnswer(questionId, value) {
    setAnswers((current) => ({ ...current, [questionId]: value }));
  }

  function goNext() {
    setCurrentIndex((index) => Math.min(index + 1, questions.length - 1));
  }

  function goPrevious() {
    setCurrentIndex((index) => Math.max(index - 1, 0));
  }

  async function submit() {
    setError('');
    setSubmitting(true);

    try {
      const payload = Object.entries(answers).map(([questionId, answer_data]) => ({
        questionId,
        answer_data,
      }));
      const { data } = await api.post(`/api/student/levels/${levelId}/submit`, { answers: payload });
      sessionStorage.setItem(`attempt:${data.attempt.id}`, JSON.stringify(data));
      setResult(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  }

  if (loading) {
    return (
      <section className="panel">
        <h1>Chargement du quiz</h1>
        <p>Preparation des questions du quiz.</p>
      </section>
    );
  }

  if (result) {
    return <QuizResult result={result} />;
  }

  const currentQuestion = questions[currentIndex];
  const answeredCount = Object.keys(answers).length;
  const remainingCount = Math.max(questions.length - answeredCount, 0);

  return (
    <section className="stack">
      <div className="page-title quiz-title">
        <h1>Quiz</h1>
        <p>
          Question {questions.length ? currentIndex + 1 : 0}/{questions.length} · {answeredCount} reponse(s)
          enregistree(s)
        </p>
      </div>

      {error && <p className="error">{error}</p>}

      {isSubscriptionError(error) ? (
        <article className="panel empty-state">
          <h2>Abonnement requis</h2>
          <p>Ce quiz fait partie des contenus premium. Activez votre abonnement pour y acceder.</p>
          <Link className="button-link premium-cta" to="/student/premium">
            Voir les offres d'abonnement
          </Link>
        </article>
      ) : !currentQuestion ? (
        <article className="panel">
          <h2>Aucune question</h2>
          <p>Ce quiz ne contient pas encore de questions.</p>
        </article>
      ) : (
        <>
          <div className="quiz-hud" aria-label="Tableau de bord du quiz">
            <div className="hud-score good">
              <CheckCircle2 size={32} />
              <strong>{answeredCount}</strong>
            </div>
            <div className="hud-score bad">
              <XCircle size={32} />
              <strong>{remainingCount}</strong>
            </div>
            <div className="hud-timer">
              <Clock3 size={26} />
              <strong>
                {currentIndex + 1}/{questions.length}
              </strong>
            </div>
          </div>
          <QuizProgress current={currentIndex + 1} total={questions.length} />
          <article className="question-card quiz-game-card">
            <span className="eyebrow">
              {currentQuestion.type} · {currentQuestion.points} point(s)
            </span>
            <h2>
              {currentIndex + 1}. {currentQuestion.question_text}
            </h2>
            <QuestionRenderer
              question={currentQuestion}
              value={answers[currentQuestion.id] || {}}
              onChange={(value) => saveAnswer(currentQuestion.id, value)}
            />
          </article>

          <div className="quiz-actions">
            <button type="button" className="secondary-btn" disabled={currentIndex === 0} onClick={goPrevious}>
              <ArrowLeft size={18} />
              Precedent
            </button>

            {currentIndex < questions.length - 1 ? (
              <button type="button" onClick={goNext}>
                Suivant
                <ArrowRight size={18} />
              </button>
            ) : (
              <button type="button" disabled={submitting} onClick={submit}>
                <CheckCircle2 size={18} />
                {submitting ? 'Soumission...' : 'Soumettre toutes les reponses'}
              </button>
            )}
          </div>
        </>
      )}
    </section>
  );
}

function isSubscriptionError(error) {
  return String(error || '').toLowerCase().includes('abonnement');
}

function QuizProgress({ current, total }) {
  const percent = total === 0 ? 0 : Math.round((current / total) * 100);

  return (
    <div className="quiz-progress" aria-label={`Progression ${percent}%`}>
      <div style={{ width: `${percent}%` }} />
    </div>
  );
}

function QuizResult({ result }) {
  return (
    <section className="stack">
      <div className="result-hero">
        <span>{result.passed ? 'Reussi' : 'Non valide'}</span>
        <h1>
          {result.score}/{result.totalPoints} points
        </h1>
        <p>
          {result.percent}% · {result.passed ? 'quiz complete' : 'score insuffisant'}
        </p>
      </div>

      <div className="panel">
        <h2>Correction</h2>
        {result.corrections.map((correction, index) => (
          <article className="correction-card" key={correction.questionId}>
            <div className={correction.isCorrect ? 'status-dot good' : 'status-dot bad'}>
              {correction.isCorrect ? <CheckCircle2 size={18} /> : <XCircle size={18} />}
            </div>
            <div>
              <span className="eyebrow">
                Question {index + 1} · {correction.pointsEarned} point(s)
              </span>
              <h3>{correction.questionText}</h3>
              <p>{correction.explanation || 'Aucune explication renseignee.'}</p>
              {correction.correctOptions?.length > 0 && (
                <small>
                  Bonne(s) option(s) : {correction.correctOptions.map((option) => option.option_text).join(', ')}
                </small>
              )}
              {correction.correctItems?.length > 0 && (
                <small>
                  Reponse(s) attendue(s) :{' '}
                  {correction.correctItems.map((item) => `${item.label}: ${item.correct_answer}`).join(' · ')}
                </small>
              )}
            </div>
          </article>
        ))}
      </div>

      <Link className="button-link" to="/student/modules">
        Retour aux modules
      </Link>
    </section>
  );
}
