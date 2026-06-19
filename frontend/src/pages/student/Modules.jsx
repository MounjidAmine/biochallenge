import { ArrowLeft, BookOpen, CreditCard, FileText, Layers3, Lock, PlayCircle } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import api from '../../api/api.js';
import { useAuth } from '../../auth/AuthContext.jsx';

export default function Modules() {
  const { moduleSlug, partSlug } = useParams();
  const { user } = useAuth();
  const [modules, setModules] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    api
      .get('/api/student/modules')
      .then(({ data }) => setModules(data))
      .catch((err) => setError(err.message));
  }, [user?.isPremium]);

  const currentModule = useMemo(
    () => modules.find((module) => module.slug === moduleSlug),
    [modules, moduleSlug],
  );
  const currentPart = useMemo(
    () => currentModule?.parts.find((part) => part.slug === partSlug),
    [currentModule, partSlug],
  );

  if (error) {
    return <p className="error">{error}</p>;
  }

  if (!modules.length) {
    return (
      <section className="panel">
        <h1>Chargement des modules</h1>
        <p>Lecture du catalogue base sur le dossier module.</p>
      </section>
    );
  }

  if (currentPart) {
    return <PartView module={currentModule} part={currentPart} />;
  }

  if (currentModule) {
    return <ModuleView module={currentModule} />;
  }

  return (
    <section className="stack">
      <div className="page-title">
        <h1>Modules</h1>
        <p>Choisissez un module, puis une partie pour acceder aux quiz disponibles.</p>
      </div>

      <div className="module-grid">
        {modules.map((module) => (
          <Link className="module-card" key={module.slug} to={`/student/modules/${module.slug}`}>
            <Layers3 size={24} />
            <div>
              <span className="eyebrow">{module.parts.length} parties</span>
              <h2>{module.title}</h2>
              <p>{module.description}</p>
            </div>
            <strong>{module.parts.reduce((sum, part) => sum + part.quizCount, 0)} quiz</strong>
          </Link>
        ))}
      </div>
    </section>
  );
}

function ModuleView({ module }) {
  return (
    <section className="stack">
      <div className="section-head">
        <div>
          <Link className="text-link" to="/student/modules">
            <ArrowLeft size={16} />
            Modules
          </Link>
          <h1>{module.title}</h1>
          <p>{module.description}</p>
        </div>
      </div>

      <div className="part-grid">
        {module.parts.map((part) => (
          <article className="part-card" key={part.slug}>
            <BookOpen size={22} />
            <div>
              <span className="eyebrow">{part.questionCount} questions</span>
              <h2>{part.title}</h2>
              <p>{part.quizCount ? `${part.quizCount} quiz disponible(s)` : 'Document present, quiz non importe'}</p>
            </div>
            <Link className="button-link" to={`/student/modules/${module.slug}/${part.slug}`}>
              <PlayCircle size={18} />
              Ouvrir
            </Link>
          </article>
        ))}
      </div>
    </section>
  );
}

function PartView({ module, part }) {
  return (
    <section className="stack">
      <div className="section-head">
        <div>
          <Link className="text-link" to={`/student/modules/${module.slug}`}>
            <ArrowLeft size={16} />
            {module.title}
          </Link>
          <h1>{part.title}</h1>
          <p>Quiz rattaches a cette partie du module.</p>
        </div>
      </div>

      {part.quizzes.length ? (
        <div className="level-grid">
          {part.quizzes.map((quiz) => (
            <article className={`level-card${quiz.locked ? ' locked' : ''}`} key={quiz.id}>
              <div>
                <div className="access-row">
                  <span className="eyebrow">{quiz.questionCount} question(s)</span>
                  <span className={quiz.is_paid ? 'access-pill premium' : 'access-pill free'}>
                    {quiz.is_paid ? 'Abonnement' : 'Gratuit'}
                  </span>
                </div>
                <h2>{quiz.title}</h2>
                <p>{quiz.description}</p>
              </div>
              <div className="card-footer">
                <span>Meilleur score : {quiz.bestScore}%</span>
                {quiz.locked && quiz.lockedReason === 'Abonnement requis' ? (
                  <Link className="button-link premium-cta" to="/student/premium">
                    <CreditCard size={18} />
                    S'abonner pour acceder
                  </Link>
                ) : quiz.locked ? (
                  <button type="button" disabled>
                    <Lock size={18} />
                    {quiz.lockedReason || 'Quiz verrouille'}
                  </button>
                ) : (
                  <Link className="button-link" to={`/student/quiz/${quiz.id}`}>
                    <PlayCircle size={18} />
                    Lancer le quiz
                  </Link>
                )}
              </div>
            </article>
          ))}
        </div>
      ) : (
        <article className="panel empty-state">
          <FileText size={28} />
          <h2>Aucun quiz importe pour cette partie</h2>
          <p>Le fichier est bien reference dans le dossier module, mais aucune question n'est encore disponible en base.</p>
        </article>
      )}
    </section>
  );
}
