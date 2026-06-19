import bcrypt from 'bcryptjs';
import dotenv from 'dotenv';
import { pool } from '../db.js';

dotenv.config();

const name = process.env.ADMIN_NAME || process.env.ADMIN_USERNAME || 'Administrateur';
const email = process.env.ADMIN_EMAIL || 'admin@bioquiz.local';
const password = process.env.ADMIN_PASSWORD || 'admin123';

const passwordHash = await bcrypt.hash(password, 10);

await pool.query(
  `insert into users (name, email, password_hash, role, is_premium)
   values ($1, $2, $3, 'admin', true)
   on conflict (email)
   do update set name = excluded.name, password_hash = excluded.password_hash, role = 'admin', is_premium = true`,
  [name, email, passwordHash],
);

console.log(`Admin pret: ${email} / ${password}`);
await pool.end();
