import { BookOpen, GraduationCap, Layers3, ListChecks, Trophy } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import api from '../../api/api.js';

export default function Dashboard() {
  const [stats, setStats] = useState({ modules: 0, parts: 0, quizzes: 0, questions: 0, attempts: 0, students: 0 });
  const [modules, setModules] = useState([]);
  const [levels, setLevels] = useState([]);
  const [selectedLevelId, setSelectedLevelId] = useState('');
  const [analytics, setAnalytics] = useState(null);
  const [error, setError] = useState('');

  useEffect(() => {
    Promise.all([
      api.get('/api/admin/levels'),
      api.get('/api/admin/questions'),
      api.get('/api/admin/results'),
      api.get('/api/admin/modules'),
    ])
      .then(([levelsRes, questionsRes, resultsRes, modulesRes]) => {
        setLevels(levelsRes.data);
        setModules(modulesRes.data);
        setSelectedLevelId(levelsRes.data[0]?.id || '');
        setStats({
          modules: modulesRes.data.length,
          parts: modulesRes.data.reduce((sum, module) => sum + module.parts.length, 0),
          quizzes: levelsRes.data.length,
          questions: questionsRes.data.length,
          attempts: resultsRes.data.length,
          students: new Set(resultsRes.data.map((row) => row.user_id)).size,
        });
      })
      .catch((err) => setError(err.message));
  }, []);

  useEffect(() => {
    if (!selectedLevelId) return;

    api
      .get(`/api/admin/levels/${selectedLevelId}/analytics`)
      .then(({ data }) => setAnalytics(data))
      .catch((err) => setError(err.message));
  }, [selectedLevelId]);

  const groupedStudents = useMemo(() => {
    const students = analytics?.students || [];

    return {
      completed: students.filter((student) => student.status === 'completed'),
      inProgress: students.filter((student) => student.status === 'in_progress'),
      locked: students.filter((student) => student.status === 'locked'),
    };
  }, [analytics]);

  return (
    <section className="stack">
      <div className="page-title">
        <h1>Dashboard admin</h1>
        <p>Analyse des modules, parties, quiz et resultats des etudiants.</p>
      </div>

      {error && <p className="error">{error}</p>}

      <div className="stats-grid">
        <Stat icon={<Layers3 />} label="Modules" value={stats.modules} />
        <Stat icon={<BookOpen />} label="Parties" value={stats.parts} />
        <Stat icon={<BookOpen />} label="Quiz" value={stats.quizzes} />
        <Stat icon={<ListChecks />} label="Questions" value={stats.questions} />
        <Stat icon={<Trophy />} label="Tentatives" value={stats.attempts} />
        <Stat icon={<GraduationCap />} label="Etudiants actifs" value={stats.students} />
      </div>

      <section className="panel">
        <div className="section-head">
          <div>
            <h2>Vue modules</h2>
            <p>Repartition des quiz importes dans chaque partie.</p>
          </div>
        </div>
        <div className="module-summary-grid">
          {modules.map((module) => (
            <article className="student-group" key={module.slug}>
              <h3>{module.title}</h3>
              <div className="student-list">
                {module.parts.map((part) => (
                  <div className="student-row" key={part.slug}>
                    <div>
                      <strong>{part.title}</strong>
                      <span>
                        {part.quizCount} quiz · {part.questionCount} question(s)
                      </span>
                    </div>
                    <div className="student-meta">
                      {part.sources.map((source) => (
                        <span key={source.name}>{source.name}</span>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </article>
          ))}
        </div>
      </section>

      <section className="panel">
        <div className="analytics-header">
          <div>
            <h2>Analyse par quiz</h2>
            <p>Choisissez un quiz pour voir qui l'a termine, qui est en cours, et qui reste bloque.</p>
          </div>
          <label>
            Quiz
            <select value={selectedLevelId} onChange={(event) => setSelectedLevelId(event.target.value)}>
              {levels.map((level) => (
                <option key={level.id} value={level.id}>
                  {level.level_order}. {level.title}
                </option>
              ))}
            </select>
          </label>
        </div>

        {analytics && (
          <>
            <div className="analytics-grid">
              <MiniStat label="Inscrits" value={analytics.summary.total_students} />
              <MiniStat label="Ont termine" value={analytics.summary.completed_students} />
              <MiniStat label="Taux reussite" value={`${analytics.summary.completion_rate}%`} />
              <MiniStat label="Score moyen" value={`${analytics.summary.average_best_score}%`} />
              <MiniStat label="Meilleur score" value={`${analytics.summary.best_score}%`} />
              <MiniStat label="Debloques" value={analytics.summary.unlocked_students} />
            </div>

            <div className="analytics-columns">
              <StudentGroup title="Etudiants qui ont passe le quiz" students={groupedStudents.completed} />
              <StudentGroup title="Etudiants en cours" students={groupedStudents.inProgress} />
              <StudentGroup title="Etudiants bloques" students={groupedStudents.locked} />
            </div>
          </>
        )}
      </section>
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

function MiniStat({ label, value }) {
  return (
    <article className="mini-stat">
      <span>{label}</span>
      <strong>{value}</strong>
    </article>
  );
}

function StudentGroup({ title, students }) {
  return (
    <article className="student-group">
      <h3>{title}</h3>
      {students.length === 0 ? (
        <p>Aucun etudiant.</p>
      ) : (
        <div className="student-list">
          {students.map((student) => (
            <div className="student-row" key={student.user_id}>
              <div>
                <strong>{student.name}</strong>
                <span>{student.email}</span>
              </div>
              <div className="student-meta">
                <span>{student.is_premium ? 'Premium' : 'Standard'}</span>
                <span>{student.best_score}%</span>
                <span>{student.attempts} tentative(s)</span>
              </div>
            </div>
          ))}
        </div>
      )}
    </article>
  );
}
