import { Router } from 'express';
import {
  getLevels,
  getModules,
  getProgress,
  getQuestions,
  getAttempt,
  getCompetition,
  createCompetitionFriend,
  removeCompetitionFriend,
  createPayment,
  getPayments,
  getProfile,
  getScores,
  submitLevel,
} from '../controllers/studentController.js';
import { authMiddleware } from '../middlewares/authMiddleware.js';
import { roleMiddleware } from '../middlewares/roleMiddleware.js';
import { validateBody, validateSubmitAnswers } from '../middlewares/validateMiddleware.js';

const router = Router();

router.use(authMiddleware, roleMiddleware('student'));

router.get('/profile', getProfile);
router.get('/modules', getModules);
router.get('/scores', getScores);
router.get('/competition', getCompetition);
router.post(
  '/competition/friends',
  validateBody({
    friendName: { required: true },
    friendEmail: { type: 'string' },
  }),
  createCompetitionFriend,
);
router.delete('/competition/friends/:friendId', removeCompetitionFriend);
router.get('/levels', getLevels);
router.get('/levels/:id/questions', getQuestions);
router.post('/levels/:id/submit', validateSubmitAnswers, submitLevel);
router.get('/progress', getProgress);
router.get('/attempts/:attemptId', getAttempt);
router.get('/payments', getPayments);
router.post(
  '/payments',
  validateBody({
    amount: { type: 'number', min: 1 },
    provider: { type: 'string' },
  }),
  createPayment,
);

export default router;
