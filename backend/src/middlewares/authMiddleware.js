import jwt from 'jsonwebtoken';
import { env } from '../config/env.js';

export function authMiddleware(req, res, next) {
  const authHeader = req.headers.authorization;

  if (!authHeader?.startsWith('Bearer ')) {
    res.status(401).json({ message: 'Token manquant' });
    return;
  }

  try {
    req.user = jwt.verify(authHeader.slice(7), env.jwtSecret);
    next();
  } catch (_error) {
    res.status(401).json({ message: 'Token invalide ou expire' });
  }
}
