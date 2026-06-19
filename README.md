# Biology Quiz

Plateforme locale de quiz biologie avec React + Vite, Node.js + Express, PostgreSQL, JWT et roles `admin` / `student`.

## 1. Prerequis

- Node.js
- PostgreSQL
- Codex CLI

## 2. Installation backend

Depuis la racine du projet :

```bash
cd backend
npm install
```

Creer le fichier `.env` :

```bash
cp .env.example .env
```

Exemple `.env` :

```env
PORT=4000
DATABASE_URL=postgresql://postgres:Admin@localhost:5432/biology_quiz
CORS_ORIGIN=http://localhost:5173
JWT_SECRET=change_this_secret_for_local_dev
UPLOAD_DIR=uploads
ADMIN_EMAIL=admin@test.com
ADMIN_PASSWORD=admin123
ADMIN_NAME=Administrateur
```

Lancer le backend :

```bash
npm run dev
```

API disponible sur :

```text
http://localhost:4000
```

## 3. Installation frontend

Depuis la racine du projet :

```bash
cd frontend
npm install
npm run dev
```

Frontend disponible sur :

```text
http://localhost:5173
```

## 4. Creation base PostgreSQL

Creer la base :

```bash
createdb biology_quiz
```

Importer le schema et les donnees seed :

```bash
psql -U postgres -d biology_quiz -f backend/database.sql
```

## 5. Comptes test

Admin :

```text
admin@test.com
admin123
```

Etudiant :

```text
student@test.com
student123
```

Si besoin, recreer l'admin avec :

```bash
cd backend
npm run create-admin
```

## 6. Roles admin/student

### Admin

Le role `admin` permet de gerer la plateforme :

- creer, modifier et supprimer les niveaux
- definir les niveaux gratuits ou payants
- creer, modifier et supprimer les questions
- uploader des images ou schemas biologiques
- consulter les resultats des etudiants

Les routes admin sont protegees par JWT et exigent le role `admin`.

### Student

Le role `student` permet de jouer les quiz :

- consulter les niveaux disponibles
- acceder au niveau 1 automatiquement
- debloquer le niveau suivant apres reussite du precedent
- jouer un quiz
- soumettre ses reponses
- consulter le score et la correction

Un etudiant non premium ne peut pas acceder aux niveaux payants.

## Paiement local de demonstration

Le projet contient un paiement simule pour tester les niveaux payants sans service externe.

Routes etudiant :

```text
POST /api/student/payments
GET  /api/student/payments
```

Quand l'etudiant clique sur `Payer et debloquer`, le backend :

- cree une ligne dans `payments`
- met le statut a `paid`
- passe `users.is_premium` a `true`
- permet ensuite de continuer les quiz payants

Ce paiement est volontairement local/demo. Pour une vraie production, remplacer `local_demo` par un provider comme Stripe ou PayPal.
