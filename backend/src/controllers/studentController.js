import {
  getAttemptResult,
  getQuestionsForStudent,
  getStudentLevels,
  getStudentProgress,
  submitQuiz,
} from '../services/progressService.js';
import { createStudentPayment, getStudentPayments } from '../services/paymentService.js';
import {
  addCompetitionFriend,
  deleteCompetitionFriend,
  getStudentCompetition,
  getStudentModules,
  getStudentProfile,
  getStudentScores,
} from '../services/studentDashboardService.js';

export async function getLevels(req, res, next) {
  try {
    res.json(await getStudentLevels(req.user.id));
  } catch (error) {
    next(error);
  }
}

export async function getQuestions(req, res, next) {
  try {
    res.json(await getQuestionsForStudent(req.user.id, req.params.id, false));
  } catch (error) {
    next(error);
  }
}

export async function submitLevel(req, res, next) {
  try {
    const submittedAnswers = req.body.answers || [];
    res.json(await submitQuiz(req.user.id, req.params.id, submittedAnswers));
  } catch (error) {
    next(error);
  }
}

export async function getProgress(req, res, next) {
  try {
    res.json(await getStudentProgress(req.user.id));
  } catch (error) {
    next(error);
  }
}

export async function getAttempt(req, res, next) {
  try {
    res.json(await getAttemptResult(req.user.id, req.params.attemptId));
  } catch (error) {
    next(error);
  }
}

export async function createPayment(req, res, next) {
  try {
    const amount = req.body.amount ?? 50;
    const provider = req.body.provider || 'local_demo';
    res.status(201).json(await createStudentPayment(req.user.id, amount, provider));
  } catch (error) {
    next(error);
  }
}

export async function getPayments(req, res, next) {
  try {
    res.json(await getStudentPayments(req.user.id));
  } catch (error) {
    next(error);
  }
}

export async function getProfile(req, res, next) {
  try {
    res.json(await getStudentProfile(req.user.id));
  } catch (error) {
    next(error);
  }
}

export async function getModules(req, res, next) {
  try {
    res.json(await getStudentModules(req.user.id));
  } catch (error) {
    next(error);
  }
}

export async function getScores(req, res, next) {
  try {
    res.json(await getStudentScores(req.user.id));
  } catch (error) {
    next(error);
  }
}

export async function getCompetition(req, res, next) {
  try {
    res.json(await getStudentCompetition(req.user.id));
  } catch (error) {
    next(error);
  }
}

export async function createCompetitionFriend(req, res, next) {
  try {
    const friendName = String(req.body.friendName || req.body.friend_name || '').trim();
    const friendEmail = String(req.body.friendEmail || req.body.friend_email || '').trim();
    res.status(201).json(await addCompetitionFriend(req.user.id, friendName, friendEmail || null));
  } catch (error) {
    next(error);
  }
}

export async function removeCompetitionFriend(req, res, next) {
  try {
    await deleteCompetitionFriend(req.user.id, req.params.friendId);
    res.status(204).send();
  } catch (error) {
    next(error);
  }
}
