import { Award, BadgeCheck, BookOpenCheck, CheckCircle2, CreditCard, GraduationCap, PackageCheck } from 'lucide-react';
import { useState } from 'react';
import api from '../../api/api.js';
import { useAuth } from '../../auth/AuthContext.jsx';

const offers = [
  {
    id: 'premium_monthly',
    title: 'Abonnement premium',
    price: 50,
    suffix: 'DH / mois',
    icon: <BadgeCheck size={24} />,
    featured: true,
    description:
      'Quiz illimites, examens blancs, certificats et acces aux fonctionnalites avancees de la plateforme.',
    benefits: ['Quiz illimites', 'Examens blancs', 'Certificats', 'Statistiques avancees'],
  },
  {
    id: 'pack_biochimie',
    title: 'Pack Biochimie',
    price: 50,
    suffix: 'DH',
    icon: <PackageCheck size={24} />,
    description: 'Pack dedie aux proteines, glucides, lipides et notions essentielles de biochimie.',
    benefits: ['Quiz biochimie', 'Corrections detaillees', 'Progression du pack'],
  },
  {
    id: 'pack_anatomie',
    title: 'Pack Anatomie',
    price: 50,
    suffix: 'DH',
    icon: <BookOpenCheck size={24} />,
    description: 'Pack dedie aux modules cardio, digestion, respiration et physiologie humaine.',
    benefits: ['Quiz anatomie', 'Revision rapide', 'Suivi du score'],
  },
  {
    id: 'pack_exam',
    title: 'Preparation examen complet',
    price: 100,
    suffix: 'DH',
    icon: <GraduationCap size={24} />,
    description: 'Parcours complet pour simuler une preparation examen avec plusieurs series de quiz.',
    benefits: ['Examens blancs', 'Classement', 'Certificat de preparation'],
  },
];

export default function Levels() {
  const { user, updateUser } = useAuth();
  const [selectedOffer, setSelectedOffer] = useState(null);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  async function buyOffer(offer) {
    setError('');
    setSuccess('');
    setSelectedOffer(offer.id);

    try {
      const { data } = await api.post('/api/student/payments', {
        amount: offer.price,
        provider: offer.id,
      });
      updateUser(data.user);
      setSuccess(`Paiement accepte : ${offer.title}. Votre acces premium est active.`);
    } catch (err) {
      setError(err.message);
    } finally {
      setSelectedOffer(null);
    }
  }

  return (
    <section className="stack">
      <div className="premium-hero">
        <div>
          <span className="eyebrow">Offres premium</span>
          <h1>Abonnement et packs educatifs</h1>
          <p>
            La plateforme peut proposer un abonnement premium a 50 DH par mois, donnant acces a des
            fonctionnalites avancees telles que les quiz illimites, les examens blancs et les certificats.
          </p>
        </div>
        <div className="premium-status">
          <Award size={28} />
          <span>Statut actuel</span>
          <strong>{user?.isPremium ? 'Premium actif' : 'Compte standard'}</strong>
        </div>
      </div>

      {error && <p className="error">{error}</p>}
      {success && <p className="success">{success}</p>}

      <div className="pricing-grid">
        {offers.map((offer) => (
          <article className={offer.featured ? 'pricing-card featured' : 'pricing-card'} key={offer.id}>
            <div className="pricing-icon">{offer.icon}</div>
            <div>
              <span className="eyebrow">{offer.featured ? 'Recommande' : 'Pack specialise'}</span>
              <h2>{offer.title}</h2>
              <p>{offer.description}</p>
            </div>
            <div className="price-line">
              <strong>{offer.price}</strong>
              <span>{offer.suffix}</span>
            </div>
            <ul className="benefit-list">
              {offer.benefits.map((benefit) => (
                <li key={benefit}>
                  <CheckCircle2 size={17} />
                  {benefit}
                </li>
              ))}
            </ul>
            <button type="button" disabled={selectedOffer === offer.id} onClick={() => buyOffer(offer)}>
              <CreditCard size={18} />
              {selectedOffer === offer.id ? 'Paiement...' : 'Choisir cette offre'}
            </button>
          </article>
        ))}
      </div>
    </section>
  );
}
