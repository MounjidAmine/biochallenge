import { CreditCard, Lock, PlayCircle } from 'lucide-react';
import { Link } from 'react-router-dom';

export default function LevelCard({ level, paying = false, onPay }) {
  const canPay = level.locked && level.is_paid && level.lockedReason === 'Niveau payant';

  return (
    <article className={level.locked ? 'level-card locked' : 'level-card'}>
      <div>
        <span className="eyebrow">Niveau {level.level_order}</span>
        <h2>{level.title}</h2>
        <p>{level.description}</p>
      </div>
      <div className="card-footer">
        <span>{level.is_paid ? 'Payant' : 'Gratuit'} · meilleur score {level.best_score || 0}%</span>
        {canPay ? (
          <button type="button" disabled={paying} onClick={() => onPay(level)}>
            <CreditCard size={18} />
            {paying ? 'Paiement...' : 'Payer et debloquer'}
          </button>
        ) : level.locked ? (
          <button disabled type="button">
            <Lock size={18} />
            {level.lockedReason || 'Verrouille'}
          </button>
        ) : (
          <Link className="button-link" to={`/student/quiz/${level.id}`}>
            <PlayCircle size={18} />
            Jouer
          </Link>
        )}
      </div>
    </article>
  );
}
