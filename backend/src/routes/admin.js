import { Router } from 'express';
import {
  createLevel,
  createModule,
  createPart,
  createQuestion,
  deleteLevel,
  deleteModule,
  deletePart,
  deleteQuestion,
  getLevels,
  getLevelAnalytics,
  getModules,
  getQuestions,
  getResults,
  uploadQuestionImage,
  updateLevel,
  updateModule,
  updatePart,
  updateQuestion,
} from '../controllers/adminController.js';
import { authMiddleware } from '../middlewares/authMiddleware.js';
import { roleMiddleware } from '../middlewares/roleMiddleware.js';
import { uploadImage } from '../middlewares/uploadMiddleware.js';
import { validateBody, validateQuestion } from '../middlewares/validateMiddleware.js';

const router = Router();

router.use(authMiddleware, roleMiddleware('admin'));

router.get('/modules', getModules);
router.post(
  '/modules',
  validateBody({
    title: { required: true },
    module_order: { type: 'number', min: 1 },
  }),
  createModule,
);
router.put(
  '/modules/:id',
  validateBody({
    title: { required: true },
    module_order: { type: 'number', min: 1 },
  }),
  updateModule,
);
router.delete('/modules/:id', deleteModule);

router.post(
  '/parts',
  validateBody({
    module_id: { required: true },
    title: { required: true },
    part_order: { type: 'number', min: 1 },
  }),
  createPart,
);
router.put(
  '/parts/:id',
  validateBody({
    module_id: { required: true },
    title: { required: true },
    part_order: { type: 'number', min: 1 },
  }),
  updatePart,
);
router.delete('/parts/:id', deletePart);
router.get('/levels', getLevels);
router.get('/levels/:levelId/analytics', getLevelAnalytics);
router.post(
  '/levels',
  validateBody({
    title: { required: true },
    level_order: { required: true, type: 'number', min: 1 },
    part_id: { required: true },
    is_paid: { type: 'boolean' },
    passing_score: { required: true, type: 'number', min: 0, max: 100 },
  }),
  createLevel,
);
router.put(
  '/levels/:id',
  validateBody({
    title: { required: true },
    level_order: { required: true, type: 'number', min: 1 },
    part_id: { required: true },
    is_paid: { type: 'boolean' },
    passing_score: { required: true, type: 'number', min: 0, max: 100 },
  }),
  updateLevel,
);
router.delete('/levels/:id', deleteLevel);

router.get('/questions', getQuestions);
router.post('/questions', uploadImage.single('image'), validateQuestion, createQuestion);
router.put('/questions/:id', uploadImage.single('image'), validateQuestion, updateQuestion);
router.delete('/questions/:id', deleteQuestion);

router.post('/upload', uploadImage.single('image'), uploadQuestionImage);
router.get('/results', getResults);

export default router;
