# Deploiement gratuit simple + QR code

Objectif: obtenir une URL publique pour BioChallenge, generer un QR code, puis tester les fonctionnalites en ligne.

Solution recommandee:

- Base de donnees: Supabase Postgres, gratuit pour commencer.
- Backend API: Render Web Service, gratuit pour commencer.
- Frontend: Vercel, gratuit pour usage personnel/non commercial.

Notes importantes:

- Render Free peut mettre le backend en veille apres une periode sans visite. La premiere requete peut donc prendre environ une minute.
- Les fichiers uploades dans `backend/uploads` ne sont pas un stockage durable sur Render Free. Les donnees PostgreSQL restent dans la base, mais les nouveaux fichiers locaux peuvent disparaitre apres redemarrage/redeploiement. Pour une vraie production, utiliser Supabase Storage, S3, Cloudinary, etc.
- Ne mets jamais `backend/.env` sur GitHub. Utilise uniquement les variables d'environnement dans les dashboards.

## Resume rapide

1. Envoyer le projet sur GitHub.
2. Creer la base Supabase et executer `database.sql`.
3. Deployer le backend sur Render.
4. Deployer le frontend sur Vercel.
5. Mettre l'URL Vercel dans `CORS_ORIGIN` sur Render.
6. Mettre l'URL Render dans `VITE_API_URL` sur Vercel.
7. Tester login, quiz, abonnement, competition, amis.
8. Generer le QR code avec l'URL Vercel.

## 1. Mettre le projet sur GitHub

Depuis le dossier du projet:

```bash
git init
git add .
git commit -m "Initial deploy"
git branch -M main
git remote add origin https://github.com/TON_USER/biology-quiz.git
git push -u origin main
```

Verifie que `node_modules`, `.env` et `frontend/dist` ne sont pas envoyes si tu ne veux pas les versionner.

## 2. Creer la base PostgreSQL sur Supabase

1. Va sur https://supabase.com.
2. Cree un nouveau projet gratuit.
3. Ouvre `SQL Editor`.
4. Copie le contenu de `database.sql`.
5. Lance le script SQL.
6. Recupere l'URL de connexion Postgres dans `Project Settings` > `Database`.

Format attendu par le backend:

```env
DATABASE_URL=postgresql://USER:PASSWORD@HOST:PORT/DB_NAME
```

## 3. Deployer le backend sur Render

1. Va sur https://render.com.
2. Clique `New` > `Web Service`.
3. Connecte le repo GitHub.
4. Configure:

```text
Name: biology-quiz-api
Root Directory: backend
Runtime: Node
Build Command: npm install
Start Command: npm start
Plan: Free
```

5. Ajoute les variables d'environnement:

```env
DATABASE_URL=postgresql://...
CORS_ORIGIN=https://TON-FRONTEND.vercel.app
JWT_SECRET=une_valeur_longue_et_secrete
UPLOAD_DIR=uploads
ADMIN_EMAIL=admin@test.com
ADMIN_PASSWORD=change_ce_mot_de_passe
ADMIN_NAME=Administrateur
```

6. Deploie.
7. Teste l'API:

```text
https://TON-BACKEND.onrender.com/health
```

Tu dois obtenir une reponse JSON avec `status: "ok"`.

## 4. Deployer le frontend sur Vercel

1. Va sur https://vercel.com.
2. Clique `Add New` > `Project`.
3. Importe le repo GitHub.
4. Configure:

```text
Framework Preset: Vite
Root Directory: frontend
Build Command: npm run build
Output Directory: dist
Install Command: npm install
```

5. Ajoute la variable d'environnement:

```env
VITE_API_URL=https://TON-BACKEND.onrender.com
```

6. Deploie.

## 5. Mettre a jour CORS et redeployer

Apres le deploiement Vercel, copie l'URL finale du frontend, par exemple:

```text
https://biology-quiz.vercel.app
```

Puis retourne sur Render et remplace:

```env
CORS_ORIGIN=https://biology-quiz.vercel.app
```

Redeploie le backend.

Si tu testes aussi depuis un domaine preview Vercel, tu peux mettre plusieurs origines separees par virgule:

```env
CORS_ORIGIN=https://biology-quiz.vercel.app,https://biology-quiz-git-main-ton-user.vercel.app
```

## 6. Creer ou recreer l'admin

Sur Render, si tu as acces a une commande de job/shell dans ton plan, lance:

```bash
npm run create-admin
```

Sinon, assure-toi que le script SQL contient deja un admin de test, puis change le mot de passe rapidement apres deploiement.

## 7. Generer le QR code

Le QR code doit pointer vers l'URL frontend Vercel, pas vers l'URL backend Render.

Exemple:

```text
https://biology-quiz.vercel.app
```

Options simples:

- Depuis Chrome ou Edge: ouvrir l'URL Vercel, cliquer dans la barre d'adresse, puis utiliser l'option QR code si disponible.
- Depuis un generateur QR fiable: coller l'URL Vercel et telecharger l'image PNG.
- Depuis ce projet: donne-moi l'URL Vercel finale et je peux te generer une image QR code prete pour presentation ou impression.

## 8. Checklist de test en ligne

Teste sur ordinateur et telephone avec le QR code:

- Page d'accueil/login charge correctement.
- Connexion etudiant: `student@test.com`.
- Connexion admin: `admin@test.com`.
- Modules et parties affiches.
- Quiz gratuit accessible.
- Quiz verrouille par progression bloque correctement.
- Quiz payant bloque sans abonnement.
- Paiement/abonnement active l'acces premium.
- Questions avec schemas/images s'affichent sans debordement.
- Score enregistre apres soumission.
- Page competition lance un vrai quiz.
- Ajout/suppression d'amis dans competition fonctionne.
- Classement competition affiche les vrais scores.
- Admin peut creer/modifier module, partie, quiz et question.
- Test mobile: boutons lisibles, cartes non coupees, navigation OK.

## Commandes locales utiles

Tester le build frontend:

```bash
cd frontend
npm run build
```

Lancer en local:

```bash
npm run dev
```
