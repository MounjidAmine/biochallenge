import cors from 'cors';
import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';
import { env } from './config/env.js';
import { pool } from './config/db.js';
import { errorHandler, notFoundHandler } from './middlewares/errorMiddleware.js';
import adminRoutes from './routes/admin.js';
import authRoutes from './routes/auth.js';
import studentRoutes from './routes/student.js';

const app = express();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const bundledUploadDir = path.resolve(__dirname, '..', env.uploadDir);
const runtimeUploadDir = process.env.VERCEL ? path.join('/tmp', env.uploadDir) : bundledUploadDir;

app.use(
  cors({
    origin(origin, callback) {
      if (!origin || env.corsOrigins.includes(origin)) {
        callback(null, true);
        return;
      }

      callback(new Error('Origine CORS non autorisee'));
    },
  }),
);
app.use(express.json({ limit: '2mb' }));
app.use('/uploads', express.static(runtimeUploadDir));
if (runtimeUploadDir !== bundledUploadDir) {
  app.use('/uploads', express.static(bundledUploadDir));
}

app.get('/health', async (_req, res, next) => {
  try {
    await pool.query('select 1');
    res.json({ status: 'ok', database: 'connected' });
  } catch (error) {
    next(error);
  }
});

app.use('/api/auth', authRoutes);
app.use('/api/admin', adminRoutes);
app.use('/api/student', studentRoutes);

app.use(notFoundHandler);
app.use(errorHandler);

export default app;
