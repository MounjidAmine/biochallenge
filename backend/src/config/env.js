import dotenv from 'dotenv';

dotenv.config();

const corsOrigins = (process.env.CORS_ORIGIN || 'http://localhost:5173,http://127.0.0.1:5173')
  .split(',')
  .map((origin) => origin.trim())
  .filter(Boolean);

export const env = {
  port: process.env.PORT || 4000,
  databaseUrl: process.env.DATABASE_URL,
  corsOrigins,
  jwtSecret: process.env.JWT_SECRET || 'local_dev_secret',
  uploadDir: process.env.UPLOAD_DIR || 'uploads',
};
