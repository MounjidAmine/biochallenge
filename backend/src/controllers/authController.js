import bcrypt from 'bcryptjs';
import { pool } from '../config/db.js';
import { signToken } from '../services/tokenService.js';

function publicUser(user) {
  return {
    id: user.id,
    name: user.name,
    email: user.email,
    role: user.role,
    isPremium: user.is_premium,
  };
}

export async function register(req, res, next) {
  const { email, password } = req.body;
  const name = req.body.name || req.body.username;

  if (!name || !email || !password) {
    res.status(400).json({ message: 'name, email et password sont requis' });
    return;
  }

  try {
    const passwordHash = await bcrypt.hash(password, 10);
    const { rows } = await pool.query(
      `insert into users (name, email, password_hash, role, is_premium)
       values ($1, $2, $3, 'student', false)
       returning id, name, email, role, is_premium`,
      [name, email, passwordHash],
    );

    const user = rows[0];
    res.status(201).json({ token: signToken(user), user: publicUser(user) });
  } catch (error) {
    if (error.code === '23505') {
      res.status(409).json({ message: 'Email deja utilise' });
      return;
    }

    next(error);
  }
}

export async function login(req, res, next) {
  const { email, password } = req.body;

  if (!email || !password) {
    res.status(400).json({ message: 'email et password sont requis' });
    return;
  }

  try {
    const { rows } = await pool.query(
      `select id, name, email, password_hash, role, is_premium
       from users
       where email = $1`,
      [email],
    );

    const user = rows[0];
    if (!user || !(await bcrypt.compare(password, user.password_hash))) {
      res.status(401).json({ message: 'Identifiants invalides' });
      return;
    }

    res.json({ token: signToken(user), user: publicUser(user) });
  } catch (error) {
    next(error);
  }
}
