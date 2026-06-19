import { Router } from 'express';
import { login, register } from '../controllers/authController.js';
import { validateBody } from '../middlewares/validateMiddleware.js';

const router = Router();

router.post(
  '/register',
  validateBody({
    email: { required: true, email: true },
    password: { required: true, minLength: 6 },
  }),
  register,
);
router.post(
  '/login',
  validateBody({
    email: { required: true, email: true },
    password: { required: true },
  }),
  login,
);

export default router;
