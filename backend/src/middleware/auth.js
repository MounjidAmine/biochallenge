import { authMiddleware } from '../middlewares/authMiddleware.js';
import { roleMiddleware } from '../middlewares/roleMiddleware.js';

export const authenticate = authMiddleware;
export const requireRole = roleMiddleware;
