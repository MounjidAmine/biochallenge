import { createContext, useContext, useMemo, useState } from 'react';
import api from '../api/api.js';

const AuthContext = createContext(null);

export function AuthProvider({ children }) {
  const [user, setUser] = useState(() => JSON.parse(localStorage.getItem('user') || 'null'));
  const [token, setToken] = useState(() => localStorage.getItem('token'));

  function saveSession(session) {
    setUser(session.user);
    setToken(session.token);
    localStorage.setItem('user', JSON.stringify(session.user));
    localStorage.setItem('token', session.token);
  }

  async function login(payload) {
    const { data } = await api.post('/api/auth/login', payload);
    saveSession(data);
    return data.user;
  }

  async function register(payload) {
    const { data } = await api.post('/api/auth/register', payload);
    saveSession(data);
    return data.user;
  }

  function logout() {
    setUser(null);
    setToken(null);
    localStorage.removeItem('user');
    localStorage.removeItem('token');
  }

  function updateUser(nextUser) {
    setUser(nextUser);
    localStorage.setItem('user', JSON.stringify(nextUser));
  }

  const value = useMemo(
    () => ({ user, token, isAuthenticated: Boolean(token && user), login, register, logout, updateUser }),
    [user, token],
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth() {
  return useContext(AuthContext);
}
