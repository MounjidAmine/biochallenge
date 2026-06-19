import { pool } from '../config/db.js';

export async function createStudentPayment(userId, amount = 50, provider = 'local_demo') {
  const client = await pool.connect();

  try {
    await client.query('begin');

    const { rows: payments } = await client.query(
      `insert into payments (user_id, amount, status, provider)
       values ($1, $2, 'paid', $3)
       returning *`,
      [userId, amount, provider],
    );

    const { rows: users } = await client.query(
      `update users
       set is_premium = true
       where id = $1
       returning id, name, email, role, is_premium`,
      [userId],
    );

    await client.query('commit');

    return {
      payment: payments[0],
      user: {
        id: users[0].id,
        name: users[0].name,
        email: users[0].email,
        role: users[0].role,
        isPremium: users[0].is_premium,
      },
    };
  } catch (error) {
    await client.query('rollback');
    throw error;
  } finally {
    client.release();
  }
}

export async function getStudentPayments(userId) {
  const { rows } = await pool.query(
    `select id, amount, status, provider, created_at
     from payments
     where user_id = $1
     order by created_at desc`,
    [userId],
  );

  return rows;
}
