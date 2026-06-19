import { Award, CalendarDays, Mail, ShieldCheck, UserRound } from 'lucide-react';
import { useEffect, useState } from 'react';
import api from '../../api/api.js';

export default function Profile() {
  const [profile, setProfile] = useState(null);
  const [error, setError] = useState('');

  useEffect(() => {
    api
      .get('/api/student/profile')
      .then(({ data }) => setProfile(data))
      .catch((err) => setError(err.message));
  }, []);

  if (error) {
    return <p className="error">{error}</p>;
  }

  if (!profile) {
    return (
      <section className="panel">
        <h1>Chargement du profil</h1>
        <p>Recuperation de vos coordonnees.</p>
      </section>
    );
  }

  return (
    <section className="stack">
      <div className="page-title">
        <h1>Profil</h1>
        <p>Vos coordonnees et votre statut dans la plateforme.</p>
      </div>

      <div className="profile-grid">
        <article className="panel profile-card-main">
          <div className="avatar-mark">
            <UserRound size={34} />
          </div>
          <div>
            <span className="eyebrow">Etudiant</span>
            <h2>{profile.name}</h2>
            <p>{profile.email}</p>
          </div>
        </article>

        <article className="panel info-list">
          <InfoLine icon={<Mail size={18} />} label="Email" value={profile.email} />
          <InfoLine icon={<ShieldCheck size={18} />} label="Compte" value={profile.isPremium ? 'Premium' : 'Standard'} />
          <InfoLine
            icon={<CalendarDays size={18} />}
            label="Inscription"
            value={new Date(profile.createdAt).toLocaleDateString('fr-FR')}
          />
          <InfoLine icon={<Award size={18} />} label="Score moyen" value={`${profile.averageScore}%`} />
        </article>
      </div>

      <div className="stats-grid">
        <article className="stat-card">
          <span>Tentatives</span>
          <strong>{profile.attemptCount}</strong>
        </article>
        <article className="stat-card">
          <span>Quiz completes</span>
          <strong>{profile.completedLevels}</strong>
        </article>
        <article className="stat-card">
          <span>Moyenne</span>
          <strong>{profile.averageScore}%</strong>
        </article>
      </div>
    </section>
  );
}

function InfoLine({ icon, label, value }) {
  return (
    <div className="info-line">
      {icon}
      <span>{label}</span>
      <strong>{value}</strong>
    </div>
  );
}
