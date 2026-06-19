export function notFoundHandler(_req, res) {
  res.status(404).json({ message: 'Route introuvable' });
}

export function errorHandler(error, _req, res, _next) {
  console.error(error);

  if (error instanceof SyntaxError && error.status === 400 && 'body' in error) {
    res.status(400).json({ message: 'JSON invalide' });
    return;
  }

  if (error.name === 'MulterError') {
    res.status(400).json({ message: 'Erreur upload', details: error.message });
    return;
  }

  if (error.code === '23505') {
    res.status(409).json({ message: 'Donnee deja existante' });
    return;
  }

  if (error.code === '23503') {
    res.status(400).json({ message: 'Reference invalide' });
    return;
  }

  if (error.code === '22P02') {
    res.status(400).json({ message: 'Identifiant invalide' });
    return;
  }

  res.status(error.status || 500).json({
    message: error.status ? error.message : 'Erreur serveur',
  });
}
