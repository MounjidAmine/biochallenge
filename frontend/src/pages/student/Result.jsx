import { CheckCircle2, XCircle } from 'lucide-react';
import { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import api from '../../api/api.js';

export default function Result() {
  const { attemptId } = useParams();
  const [result, setResult] = useState(() => JSON.parse(sessionStorage.getItem(`attempt:${attemptId}`) || 'null'));
  const [error, setError] = useState('');

  useEffect(() => {
    if (result) return;

    api
      .get(`/api/student/attempts/${attemptId}`)
      .then(({ data }) => setResult(data))
      .catch((err) => setError(err.message));
  }, [attemptId, result]);

  if (!result) {
    return (
      <section className="panel">
        <h1>{error ? 'Resultat indisponible' : 'Chargement du resultat'}</h1>
        {error && <p>{error}</p>}
        <Link className="button-link" to="/student/modules">Retour aux modules</Link>
      </section>
    );
  }

  return (
    <section className="stack">
      <div className="result-hero">
        <span>{result.passed ? 'Reussi' : 'A retravailler'}</span>
        <h1>{result.score}/{result.totalPoints} points</h1>
        <p>{result.percent}% · {result.passed ? 'quiz valide' : 'score insuffisant'}</p>
      </div>
      <div className="panel">
        {result.corrections.map((item) => (
          <div className="correction-row" key={item.questionId}>
            {item.isCorrect ? <CheckCircle2 /> : <XCircle />}
            <div>
              <strong>{item.questionText}</strong>
              <p>{item.explanation}</p>
            </div>
            <span>{item.pointsEarned} pt</span>
          </div>
        ))}
      </div>
    </section>
  );
}
