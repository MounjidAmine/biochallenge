import {
  BookOpen,
  LayoutDashboard,
  ListChecks,
  LogOut,
  Gem,
  Trophy,
  UserRound,
  UsersRound,
} from 'lucide-react';
import { NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from '../auth/AuthContext.jsx';

export default function Navbar() {
  const { user, logout } = useAuth();
  const navigate = useNavigate();
  const isAdmin = user?.role === 'admin';

  function handleLogout() {
    logout();
    navigate('/login');
  }

  return (
    <header className="navbar">
      <div className="brand">
        <img src="/logo.png" alt="Biology Quiz" />
        <div>
          <strong>Biology Quiz</strong>
          <span>{user?.name || user?.email}</span>
        </div>
      </div>

      <nav>
        {isAdmin ? (
          <>
            <NavLink to="/admin/dashboard"><LayoutDashboard size={17} /> Dashboard</NavLink>
            <NavLink to="/admin/modules"><BookOpen size={17} /> Modules</NavLink>
            <NavLink to="/admin/levels"><BookOpen size={17} /> Quiz</NavLink>
            <NavLink to="/admin/questions"><ListChecks size={17} /> Questions</NavLink>
            <NavLink to="/admin/results"><LayoutDashboard size={17} /> Resultats</NavLink>
          </>
        ) : (
          <>
            <NavLink to="/student/profile"><UserRound size={17} /> Profil</NavLink>
            <NavLink to="/student/modules"><BookOpen size={17} /> Modules</NavLink>
            <NavLink to="/student/premium"><Gem size={17} /> Premium</NavLink>
            <NavLink to="/student/scores"><Trophy size={17} /> Scores</NavLink>
            <NavLink to="/student/competition"><UsersRound size={17} /> Competition</NavLink>
          </>
        )}
      </nav>

      <button className="ghost-btn" type="button" onClick={handleLogout}>
        <LogOut size={17} />
        Sortir
      </button>
    </header>
  );
}
