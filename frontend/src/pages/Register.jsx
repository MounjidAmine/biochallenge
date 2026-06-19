import { Link, useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { useAuth } from '../auth/AuthContext.jsx';

export default function Register() {
  const { register } = useAuth();
  const navigate = useNavigate();
  const [form, setForm] = useState({ name: '', email: '', password: '' });
  const [error, setError] = useState('');

  async function submit(event) {
    event.preventDefault();
    setError('');

    try {
      await register(form);
      navigate('/student/modules');
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <main className="auth-page compact-auth">
      <form className="auth-card" onSubmit={submit}>
        <h2>Inscription</h2>
        <label>Nom<input value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} /></label>
        <label>Email<input type="email" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} /></label>
        <label>Mot de passe<input type="password" value={form.password} onChange={(e) => setForm({ ...form, password: e.target.value })} /></label>
        {error && <p className="error">{error}</p>}
        <button type="submit">Creer le compte</button>
        <Link to="/login">J’ai deja un compte</Link>
      </form>
    </main>
  );
}
