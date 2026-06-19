import { BarChart3, CheckCircle2, Target, XCircle } from 'lucide-react';
import { useEffect, useState } from 'react';
import api from '../../api/api.js';

export default function Scores() {
  const [scores, setScores] = useState(null);
  const [error, setError] = useState('');

  useEffect(() => {
    api
      .get('/api/student/scores')
      .then(({ data }) => setScores(data))
      .catch((err) => setError(err.message));
  }, []);

  if (error) {
    return <p className="error">{error}</p>;
  }

  if (!scores) {
    return (
      <section className="panel">
        <h1>Chargement des scores</h1>
        <p>Analyse de vos tentatives.</p>
      </section>
    );
  }

  const totalAnswers = scores.summary.correctAnswers + scores.summary.incorrectAnswers;
  const correctRate = totalAnswers ? Math.round((scores.summary.correctAnswers / totalAnswers) * 100) : 0;

  return (
    <section className="stack">
      <div className="page-title">
        <h1>Scores</h1>
        <p>Statistiques, progression et correction globale de vos reponses.</p>
      </div>

      <div className="stats-grid">
        <Stat icon={<Target />} label="Moyenne" value={`${scores.summary.averagePercent}%`} />
        <Stat icon={<CheckCircle2 />} label="Reponses correctes" value={scores.summary.correctAnswers} />
        <Stat icon={<XCircle />} label="Reponses incorrectes" value={scores.summary.incorrectAnswers} />
        <Stat icon={<BarChart3 />} label="Precision" value={`${correctRate}%`} />
      </div>

      <article className="panel">
        <div className="section-head">
          <div>
            <h2>Analyse par quiz</h2>
            <p>Vos meilleurs scores et moyennes par quiz tente.</p>
          </div>
        </div>
        {scores.byLevel.length ? (
          <div className="score-list">
            {scores.byLevel.map((level) => (
              <div className="score-row" key={level.id}>
                <div>
                  <strong>{level.title}</strong>
                  <span>{level.attempts} tentative(s)</span>
                </div>
                <ProgressBar value={level.bestPercent} />
                <span>{level.bestPercent}% meilleur</span>
              </div>
            ))}
          </div>
        ) : (
          <p>Aucun score pour le moment.</p>
        )}
      </article>

      <article className="panel">
        <div className="section-head">
          <div>
            <h2>Dernieres tentatives</h2>
            <p>Correction rapide avec reponses correctes et incorrectes.</p>
          </div>
        </div>
        {scores.attempts.length ? (
          <div className="attempt-list">
            {scores.attempts.map((attempt) => (
              <div className="attempt-row" key={attempt.id}>
                <div>
                  <strong>{attempt.levelTitle}</strong>
                  <span>{attempt.finishedAt ? new Date(attempt.finishedAt).toLocaleString('fr-FR') : 'En cours'}</span>
                </div>
                <span>{attempt.score}/{attempt.totalPoints}</span>
                <span>{attempt.percent}%</span>
                <span className="good-text">{attempt.correctAnswers} correctes</span>
                <span className="bad-text">{attempt.incorrectAnswers} incorrectes</span>
              </div>
            ))}
          </div>
        ) : (
          <p>Terminez un quiz pour voir vos statistiques.</p>
        )}
      </article>
    </section>
  );
}

function Stat({ icon, label, value }) {
  return (
    <article className="stat-card">
      {icon}
      <span>{label}</span>
      <strong>{value}</strong>
    </article>
  );
}

function ProgressBar({ value }) {
  return (
    <div className="score-bar">
      <div style={{ width: `${value}%` }} />
    </div>
  );
}
