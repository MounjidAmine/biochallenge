import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || 'http://localhost:4000',
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');

  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }

  return config;
});

api.interceptors.response.use(
  (response) => response,
  (error) => {
    const details = error.response?.data?.errors;
    const message = details?.length
      ? `${error.response.data.message}: ${details.join(', ')}`
      : error.response?.data?.message || 'Erreur API';
    return Promise.reject(new Error(message));
  },
);

export default api;
