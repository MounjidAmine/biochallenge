import { Navigate, Outlet } from 'react-router-dom';
import Navbar from './Navbar.jsx';
import { useAuth } from '../auth/AuthContext.jsx';

export default function AdminRoute() {
  const { isAuthenticated, user } = useAuth();

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  if (user?.role !== 'admin') {
    return <Navigate to="/student/modules" replace />;
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
