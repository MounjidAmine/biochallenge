import { Link, useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { useAuth } from '../auth/AuthContext.jsx';

export default function Login() {
  const { login } = useAuth();
  const navigate = useNavigate();
  const [form, setForm] = useState({ email: '', password: '' });
  const [error, setError] = useState('');

  async function submit(event) {
    event.preventDefault();
    setError('');

    try {
      const user = await login(form);
      navigate(user.role === 'admin' ? '/admin/dashboard' : '/student/modules');
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <main className="auth-page">
      <section className="auth-visual">
        <img className="auth-logo" src="/logo.png" alt="Biology Quiz" />
        <h1>Biology Quiz</h1>
        <p>Une plateforme academique pour apprendre la biologie par modules, quiz et statistiques.</p>
      </section>
      <form className="auth-card" onSubmit={submit}>
        <img className="auth-card-logo" src="/logo.png" alt="Biology Quiz" />
        <h2>Connexion</h2>
        <label>Email<input type="email" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} /></label>
        <label>Mot de passe<input type="password" value={form.password} onChange={(e) => setForm({ ...form, password: e.target.value })} /></label>
        {error && <p className="error">{error}</p>}
        <button type="submit">Se connecter</button>
        <Link to="/register">Creer un compte etudiant</Link>
      </form>
    </main>
  );
}
