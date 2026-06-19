import { useEffect, useState } from 'react';
import api from '../../api/api.js';

export default function ResultsAdmin() {
  const [results, setResults] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    api.get('/api/admin/results').then(({ data }) => setResults(data)).catch((err) => setError(err.message));
  }, []);

  return (
    <section className="panel">
      <h1>Resultats etudiants</h1>
      {error && <p className="error">{error}</p>}
      <div className="table">
        <div className="table-row head"><span>Etudiant</span><span>Module / partie</span><span>Quiz</span><span>Score</span><span>Statut</span><span>Date</span></div>
        {results.map((result) => (
          <div className="table-row" key={result.id}>
            <span>{result.student_name}</span>
            <span>{result.module_title ? `${result.module_title} / ${result.part_title}` : 'Non classe'}</span>
            <span>{result.level_title}</span>
            <span>{result.score}/{result.total_points}</span>
            <span>{result.passed ? 'Reussi' : 'Echoue'}</span>
            <span>{new Date(result.finished_at || result.started_at).toLocaleDateString()}</span>
          </div>
        ))}
      </div>
    </section>
  );
}
