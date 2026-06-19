import { env } from './config/env.js';
import app from './app.js';

app.listen(env.port, () => {
  console.log(`BioChallenge API running on http://localhost:${env.port}`);
});
