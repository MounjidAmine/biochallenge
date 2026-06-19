import { Navigate, Outlet } from 'react-router-dom';
import Navbar from './Navbar.jsx';
import { useAuth } from '../auth/AuthContext.jsx';

export default function ProtectedRoute({ role }) {
  const { isAuthenticated, user } = useAuth();

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  if (role && user?.role !== role) {
    return <Navigate to={user?.role === 'admin' ? '/admin/dashboard' : '/login'} replace />;
  }

  return (
    <div className="app-shell">
      <Navbar />
      <main className="page-wrap">
        <Outlet />
      </main>
    </div>
  );
}
