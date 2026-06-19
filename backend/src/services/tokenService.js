import jwt from 'jsonwebtoken';
import { env } from '../config/env.js';

export function signToken(user) {
  return jwt.sign(
    {
      id: user.id,
      email: user.email,
      role: user.role,
      isPremium: user.is_premium,
    },
    env.jwtSecret,
    { expiresIn: '7d' },
  );
}
