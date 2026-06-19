import { ArrowLeft, ArrowRight, CheckCircle2, Crown, PlayCircle, Plus, Trash2, UsersRound } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import api from '../../api/api.js';
import { useAuth } from '../../auth/AuthContext.jsx';
import QuestionRenderer from '../../components/questions/QuestionRenderer.jsx';

export default function Competition() {
  const { user } = useAuth();
  const [modules, setModules] = useState([]);
  const [competition, setCompetition] = useState({ leaderboard: [], recentAttempts: [], friends: [] });
  const [selectedQuizId, setSelectedQuizId] = useState('');
  const [friendName, setFriendName] = useState('');
  const [friendEmail, setFriendEmail] = useState('');
  const [questions, setQuestions] = useState([]);
  const [answers, setAnswers] = useState({});
  const [currentIndex, setCurrentIndex] = useState(0);
  const [result, setResult] = useState(null);
  const [started, setStarted] = useState(false);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    loadCompetitionHome();
  }, []);

  const availableQuizzes = useMemo(() => {
    return modules.flatMap((module) =>
      module.parts.flatMap((part) =>
        part.quizzes.map((quiz) => ({
          ...quiz,
          moduleTitle: module.title,
          partTitle: part.title,
        })),
      ),
    );
  }, [modules]);

  const selectedQuiz = availableQuizzes.find((quiz) => quiz.id === selectedQuizId);
  const playableQuizzes = availableQuizzes.filter((quiz) => !quiz.locked);
  const currentQuestion = questions[currentIndex];
  const answeredCount = Object.keys(answers).length;
  const friendsLeaderboard = useMemo(() => {
    const currentStudent = competition.leaderboard.find((item) => item.email === user?.email);
    const friendRows = competition.friends.map((friend) => ({
      id: friend.id,
      name: friend.studentName || friend.friendName,
      email: friend.studentEmail || friend.friendEmail,
      bestPercent: friend.bestPercent,
      averagePercent: friend.averagePercent,
      attempts: friend.attempts,
      waiting: !friend.studentId,
    }));

    return [
      ...(currentStudent ? [{ ...currentStudent, name: 'Vous' }] : []),
      ...friendRows,
    ].sort((a, b) => b.bestPercent - a.bestPercent || b.averagePercent - a.averagePercent);
  }, [competition.friends, competition.leaderboard, user?.email]);

  async function loadCompetitionHome() {
    setLoading(true);
    setError('');

    try {
      const [modulesRes, competitionRes] = await Promise.all([
        api.get('/api/student/modules'),
        api.get('/api/student/competition'),
      ]);
      setModules(modulesRes.data);
      setCompetition(competitionRes.data);

      const firstPlayable = modulesRes.data
        .flatMap((module) => module.parts.flatMap((part) => part.quizzes))
        .find((quiz) => !quiz.locked);
      setSelectedQuizId((current) => current || firstPlayable?.id || '');
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  async function startCompetition() {
    if (!selectedQuizId) return;

    setError('');
    setResult(null);
    setAnswers({});
    setCurrentIndex(0);

    try {
      const { data } = await api.get(`/api/student/levels/${selectedQuizId}/questions`);
      setQuestions(data);
      setStarted(true);
    } catch (err) {
      setError(err.message);
    }
  }

  async function addFriend(event) {
    event.preventDefault();
    const nextName = friendName.trim();
    const nextEmail = friendEmail.trim();
    if (!nextName) return;

    setError('');

    try {
      await api.post('/api/student/competition/friends', {
        friendName: nextName,
        friendEmail: nextEmail,
      });
      setFriendName('');
      setFriendEmail('');
      await loadCompetitionHome();
    } catch (err) {
      setError(err.message);
    }
  }

  async function removeFriend(friendId) {
    setError('');

    try {
      await api.delete(`/api/student/competition/friends/${friendId}`);
      await loadCompetitionHome();
    } catch (err) {
      setError(err.message);
    }
  }

  function saveAnswer(questionId, value) {
    setAnswers((current) => ({ ...current, [questionId]: value }));
  }

  function goNext() {
    setCurrentIndex((index) => Math.min(index + 1, questions.length - 1));
  }

  function goPrevious() {
    setCurrentIndex((index) => Math.max(index - 1, 0));
  }

  async function submitCompetition() {
    setError('');
    setSubmitting(true);

    try {
      const payload = Object.entries(answers).map(([questionId, answer_data]) => ({
        questionId,
        answer_data,
      }));
      const { data } = await api.post(`/api/student/levels/${selectedQuizId}/submit`, { answers: payload });
      setResult(data);
      setStarted(false);
      setQuestions([]);
      await loadCompetitionHome();
    } catch (err) {
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  }

  if (loading) {
    return (
      <section className="panel">
        <h1>Chargement de la competition</h1>
        <p>Preparation des quiz et du classement.</p>
      </section>
    );
  }

  if (started && currentQuestion) {
    return (
      <section className="stack">
        <div className="page-title quiz-title">
          <h1>Competition</h1>
          <p>
            {selectedQuiz?.title} - Question {currentIndex + 1}/{questions.length} - {answeredCount} reponse(s)
          </p>
        </div>

        {error && <p className="error">{error}</p>}

        <QuizProgress current={currentIndex + 1} total={questions.length} />
        <article className="question-card quiz-game-card">
          <span className="eyebrow">
            {currentQuestion.type} - {currentQuestion.points} point(s)
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
            <button type="button" disabled={submitting} onClick={submitCompetition}>
              <CheckCircle2 size={18} />
              {submitting ? 'Calcul...' : 'Terminer la competition'}
            </button>
          )}
        </div>
      </section>
    );
  }

  return (
    <section className="stack">
      <div className="page-title">
        <h1>Competition</h1>
        <p>Lancez un vrai quiz, enregistrez votre tentative et comparez votre score au classement.</p>
      </div>

      {error && <p className="error">{error}</p>}
      {result && <CompetitionResult result={result} quizTitle={selectedQuiz?.title} />}

      <div className="competition-grid">
        <article className="panel">
          <div className="challenge-hero">
            <UsersRound size={34} />
            <div>
              <span className="eyebrow">Defi reel</span>
              <h2>Bio Challenge</h2>
              <p>Choisissez un quiz accessible. Le resultat sera enregistre dans vos scores et dans le classement.</p>
            </div>
          </div>

          <label>
            Quiz de competition
            <select value={selectedQuizId} onChange={(event) => setSelectedQuizId(event.target.value)}>
              {availableQuizzes.map((quiz) => (
                <option key={quiz.id} value={quiz.id} disabled={quiz.locked}>
                  {quiz.moduleTitle} / {quiz.partTitle} - {quiz.title}
                  {quiz.locked ? ` (${quiz.lockedReason || 'verrouille'})` : ''}
                </option>
              ))}
            </select>
          </label>

          <button type="button" disabled={!selectedQuizId || !playableQuizzes.length} onClick={startCompetition}>
            <PlayCircle size={18} />
            Lancer la competition
          </button>

          <div className="friend-manager">
            <h3>Mes amis</h3>
            <form className="friend-form competition-friend-form" onSubmit={addFriend}>
              <input
                value={friendName}
                onChange={(event) => setFriendName(event.target.value)}
                placeholder="Nom de l'ami"
              />
              <input
                value={friendEmail}
                onChange={(event) => setFriendEmail(event.target.value)}
                placeholder="Email si inscrit"
                type="email"
              />
              <button type="submit" aria-label="Ajouter un ami">
                <Plus size={18} />
                Ajouter
              </button>
            </form>
            <div className="friend-list">
              {competition.friends.length ? (
                competition.friends.map((friend) => (
                  <span className="friend-chip" key={friend.id}>
                    {friend.friendName}
                    <button type="button" aria-label={`Supprimer ${friend.friendName}`} onClick={() => removeFriend(friend.id)}>
                      <Trash2 size={14} />
                    </button>
                  </span>
                ))
              ) : (
                <small>Ajoutez vos amis pour comparer vos scores.</small>
              )}
            </div>
          </div>
        </article>

        <article className="panel">
          <h2>Derniers resultats</h2>
          {competition.recentAttempts.length ? (
            <div className="attempt-list">
              {competition.recentAttempts.slice(0, 5).map((attempt) => (
                <div className="attempt-row competition-attempt-row" key={attempt.id}>
                  <div>
                    <strong>{attempt.studentName}</strong>
                    <span>{attempt.quizTitle}</span>
                  </div>
                  <span>{attempt.percent}%</span>
                  <span className={attempt.passed ? 'good-text' : 'bad-text'}>
                    {attempt.passed ? 'Valide' : 'A refaire'}
                  </span>
                </div>
              ))}
            </div>
          ) : (
            <p>Aucune tentative pour le moment.</p>
          )}
        </article>
      </div>

      <article className="panel">
        <div className="section-head">
          <div>
            <h2>Classement avec mes amis</h2>
            <p>Classement base sur vous et les amis que vous ajoutez.</p>
          </div>
        </div>
        <div className="leaderboard">
          {friendsLeaderboard.map((item, index) => (
            <div className="leader-row" key={item.id}>
              <span>{index === 0 ? <Crown size={18} /> : index + 1}</span>
              <strong>{item.name || item.email}</strong>
              <em>{item.waiting ? 'En attente' : `${item.bestPercent}%`}</em>
            </div>
          ))}
        </div>
      </article>
    </section>
  );
}

function CompetitionResult({ result, quizTitle }) {
  return (
    <article className="result-hero">
      <span>{result.passed ? 'Competition validee' : 'Score insuffisant'}</span>
      <h1>
        {result.score}/{result.totalPoints} points
      </h1>
      <p>
        {quizTitle} - {result.percent}% - {result.passed ? 'resultat enregistre' : 'essayez encore'}
      </p>
    </article>
  );
}

function QuizProgress({ current, total }) {
  const percent = total === 0 ? 0 : Math.round((current / total) * 100);

  return (
    <div className="quiz-progress" aria-label={`Progression ${percent}%`}>
      <div style={{ width: `${percent}%` }} />
    </div>
  );
}
