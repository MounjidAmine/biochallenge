import axios from 'axios';

const defaultApiUrl = import.meta.env.DEV ? 'http://localhost:4000' : 'https://biochallenge-api.vercel.app';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL || defaultApiUrl,
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
