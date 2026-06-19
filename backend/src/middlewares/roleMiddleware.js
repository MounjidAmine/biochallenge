export function roleMiddleware(...roles) {
  return (req, res, next) => {
    if (!roles.includes(req.user?.role)) {
      res.status(403).json({ message: 'Acces refuse' });
      return;
    }

    next();
  };
}
