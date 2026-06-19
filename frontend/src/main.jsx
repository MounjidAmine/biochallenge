import React from 'react';
import { createRoot } from 'react-dom/client';
import { Navigate, Route, BrowserRouter as Router, Routes } from 'react-router-dom';
import { AuthProvider } from './auth/AuthContext.jsx';
import AdminRoute from './components/AdminRoute.jsx';
import ProtectedRoute from './components/ProtectedRoute.jsx';
import Dashboard from './pages/admin/Dashboard.jsx';
import LevelsAdmin from './pages/admin/LevelsAdmin.jsx';
import ModulesAdmin from './pages/admin/ModulesAdmin.jsx';
import QuestionsAdmin from './pages/admin/QuestionsAdmin.jsx';
import ResultsAdmin from './pages/admin/ResultsAdmin.jsx';
import Login from './pages/Login.jsx';
import Register from './pages/Register.jsx';
import Competition from './pages/student/Competition.jsx';
import Levels from './pages/student/Levels.jsx';
import Modules from './pages/student/Modules.jsx';
import Profile from './pages/student/Profile.jsx';
import Quiz from './pages/student/Quiz.jsx';
import Result from './pages/student/Result.jsx';
import Scores from './pages/student/Scores.jsx';
import './styles.css';

createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/" element={<Navigate to="/student/modules" replace />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />

          <Route element={<ProtectedRoute role="student" />}>
            <Route path="/student/profile" element={<Profile />} />
            <Route path="/student/modules" element={<Modules />} />
            <Route path="/student/modules/:moduleSlug" element={<Modules />} />
            <Route path="/student/modules/:moduleSlug/:partSlug" element={<Modules />} />
            <Route path="/student/scores" element={<Scores />} />
            <Route path="/student/competition" element={<Competition />} />
            <Route path="/student/premium" element={<Levels />} />
            <Route path="/student/levels" element={<Navigate to="/student/premium" replace />} />
            <Route path="/student/quiz/:levelId" element={<Quiz />} />
            <Route path="/student/result/:attemptId" element={<Result />} />
          </Route>

          <Route element={<AdminRoute />}>
            <Route path="/admin/dashboard" element={<Dashboard />} />
            <Route path="/admin/modules" element={<ModulesAdmin />} />
            <Route path="/admin/levels" element={<LevelsAdmin />} />
            <Route path="/admin/questions" element={<QuestionsAdmin />} />
            <Route path="/admin/results" element={<ResultsAdmin />} />
          </Route>

          <Route path="*" element={<Navigate to="/login" replace />} />
        </Routes>
      </Router>
    </AuthProvider>
  </React.StrictMode>,
);
