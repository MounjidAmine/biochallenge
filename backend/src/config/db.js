import pg from 'pg';
import { env } from './env.js';

const { Pool } = pg;
const requiresSsl = env.databaseUrl?.includes('supabase.com') || env.databaseUrl?.includes('pooler.supabase.com');

export const pool = new Pool({
  connectionString: env.databaseUrl,
  ssl: requiresSsl ? { rejectUnauthorized: false } : undefined,
});

export async function query(text, params) {
  return pool.query(text, params);
}
