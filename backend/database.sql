create extension if not exists "uuid-ossp";
create extension if not exists "pgcrypto";

do $$
begin
  if not exists (select 1 from pg_type where typname = 'user_role') then
    create type user_role as enum ('admin', 'student');
  end if;

  if not exists (select 1 from pg_type where typname = 'question_type') then
    create type question_type as enum (
      'qcm_single',
      'qcm_multiple',
      'true_false',
      'text_answer',
      'fill_blank',
      'diagram_choice',
      'diagram_labeling',
      'matching',
      'ordering'
    );
  end if;

  if not exists (select 1 from pg_type where typname = 'payment_status') then
    create type payment_status as enum ('pending', 'paid', 'failed', 'refunded');
  end if;
end $$;

create table if not exists users (
  id uuid primary key default uuid_generate_v4(),
  name varchar(120) not null,
  email varchar(255) not null unique,
  password_hash text not null,
  role user_role not null default 'student',
  is_premium boolean not null default false,
  created_at timestamptz not null default now()
);

do $$
begin
  if not exists (
    select 1
    from information_schema.columns
    where table_name = 'users' and column_name = 'name'
  ) then
    alter table users add column name varchar(120);
  end if;

  if exists (
    select 1
    from information_schema.columns
    where table_name = 'users' and column_name = 'username'
  ) then
    alter table users alter column username drop not null;

    update users
    set name = username
    where name is null;
  end if;

  update users
  set name = split_part(email, '@', 1)
  where name is null;

  alter table users alter column name set not null;
end $$;

create table if not exists levels (
  id uuid primary key default uuid_generate_v4(),
  title varchar(160) not null,
  description text,
  level_order integer not null unique,
  is_paid boolean not null default false,
  passing_score integer not null default 70,
  created_at timestamptz not null default now()
);

create table if not exists modules (
  id uuid primary key default uuid_generate_v4(),
  title varchar(160) not null,
  description text,
  slug varchar(180) not null unique,
  module_order integer not null default 1,
  created_at timestamptz not null default now()
);

create table if not exists module_parts (
  id uuid primary key default uuid_generate_v4(),
  module_id uuid not null references modules(id) on delete cascade,
  title varchar(160) not null,
  description text,
  slug varchar(180) not null unique,
  part_order integer not null default 1,
  source_files text[] not null default '{}',
  keywords text[] not null default '{}',
  created_at timestamptz not null default now()
);

do $$
begin
  if not exists (
    select 1 from information_schema.columns
    where table_name = 'levels' and column_name = 'level_order'
  ) then
    alter table levels add column level_order integer;
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_name = 'levels' and column_name = 'position'
  ) then
    update levels set level_order = position where level_order is null;
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_name = 'levels' and column_name = 'difficulty_order'
  ) then
    update levels set level_order = difficulty_order where level_order is null;
  end if;

  update levels
  set level_order = ordered.row_number
  from (
    select id, row_number() over (order by created_at, id)::integer as row_number
    from levels
    where level_order is null
  ) ordered
  where levels.id = ordered.id;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'levels' and column_name = 'is_paid'
  ) then
    alter table levels add column is_paid boolean;
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_name = 'levels' and column_name = 'is_free'
  ) then
    update levels set is_paid = not is_free where is_paid is null;
  end if;

  update levels set is_paid = false where is_paid is null;
  alter table levels alter column is_paid set default false;
  alter table levels alter column is_paid set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'levels' and column_name = 'passing_score'
  ) then
    alter table levels add column passing_score integer;
  end if;

  update levels set passing_score = 70 where passing_score is null;
  alter table levels alter column passing_score set default 70;
  alter table levels alter column passing_score set not null;

  alter table levels alter column level_order set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'levels' and column_name = 'part_id'
  ) then
    alter table levels add column part_id uuid references module_parts(id) on delete set null;
  end if;
end $$;

create table if not exists questions (
  id uuid primary key default uuid_generate_v4(),
  level_id uuid not null references levels(id) on delete cascade,
  type question_type not null,
  question_text text not null,
  image_url text,
  explanation text,
  points integer not null default 1,
  created_at timestamptz not null default now()
);

do $$
begin
  if not exists (
    select 1 from information_schema.columns
    where table_name = 'questions' and column_name = 'type'
  ) then
    alter table questions add column type question_type;
  end if;

  update questions set type = 'qcm_single' where type is null;
  alter table questions alter column type set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'questions' and column_name = 'question_text'
  ) then
    alter table questions add column question_text text;
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_name = 'questions' and column_name = 'prompt'
  ) then
    update questions set question_text = prompt where question_text is null;
  end if;

  update questions set question_text = 'Question sans texte' where question_text is null;
  alter table questions alter column question_text set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'questions' and column_name = 'image_url'
  ) then
    alter table questions add column image_url text;
  end if;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'questions' and column_name = 'points'
  ) then
    alter table questions add column points integer;
  end if;

  update questions set points = 1 where points is null;
  alter table questions alter column points set default 1;
  alter table questions alter column points set not null;
end $$;

create table if not exists question_options (
  id uuid primary key default uuid_generate_v4(),
  question_id uuid not null references questions(id) on delete cascade,
  option_text text not null,
  is_correct boolean not null default false,
  option_order integer not null default 1,
  unique (question_id, option_order)
);

create table if not exists question_items (
  id uuid primary key default uuid_generate_v4(),
  question_id uuid not null references questions(id) on delete cascade,
  label varchar(160) not null,
  correct_answer text not null,
  position_x numeric(6, 2),
  position_y numeric(6, 2),
  item_order integer not null default 1,
  unique (question_id, item_order)
);

create table if not exists quiz_attempts (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references users(id) on delete cascade,
  level_id uuid not null references levels(id) on delete cascade,
  score integer not null default 0,
  total_points integer not null default 0,
  passed boolean not null default false,
  started_at timestamptz not null default now(),
  finished_at timestamptz
);

do $$
begin
  if not exists (
    select 1 from information_schema.columns
    where table_name = 'quiz_attempts' and column_name = 'total_points'
  ) then
    alter table quiz_attempts add column total_points integer;
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_name = 'quiz_attempts' and column_name = 'total_questions'
  ) then
    update quiz_attempts set total_points = total_questions where total_points is null;
  end if;

  update quiz_attempts set total_points = 0 where total_points is null;
  alter table quiz_attempts alter column total_points set default 0;
  alter table quiz_attempts alter column total_points set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'quiz_attempts' and column_name = 'passed'
  ) then
    alter table quiz_attempts add column passed boolean;
  end if;

  update quiz_attempts set passed = false where passed is null;
  alter table quiz_attempts alter column passed set default false;
  alter table quiz_attempts alter column passed set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'quiz_attempts' and column_name = 'started_at'
  ) then
    alter table quiz_attempts add column started_at timestamptz;
  end if;

  update quiz_attempts set started_at = now() where started_at is null;
  alter table quiz_attempts alter column started_at set default now();
  alter table quiz_attempts alter column started_at set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'quiz_attempts' and column_name = 'finished_at'
  ) then
    alter table quiz_attempts add column finished_at timestamptz;
  end if;
end $$;

create table if not exists student_answers (
  id uuid primary key default uuid_generate_v4(),
  attempt_id uuid not null references quiz_attempts(id) on delete cascade,
  question_id uuid not null references questions(id) on delete cascade,
  answer_data jsonb not null default '{}'::jsonb,
  is_correct boolean not null default false,
  points_earned integer not null default 0
);

create table if not exists user_progress (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references users(id) on delete cascade,
  level_id uuid not null references levels(id) on delete cascade,
  completed boolean not null default false,
  unlocked boolean not null default false,
  best_score integer not null default 0,
  updated_at timestamptz not null default now(),
  unique (user_id, level_id)
);

do $$
begin
  if not exists (
    select 1 from information_schema.columns
    where table_name = 'user_progress' and column_name = 'unlocked'
  ) then
    alter table user_progress add column unlocked boolean;
  end if;

  update user_progress set unlocked = completed where unlocked is null;
  alter table user_progress alter column unlocked set default false;
  alter table user_progress alter column unlocked set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'user_progress' and column_name = 'best_score'
  ) then
    alter table user_progress add column best_score integer;
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_name = 'user_progress' and column_name = 'score'
  ) then
    update user_progress set best_score = score where best_score is null;
  end if;

  update user_progress set best_score = 0 where best_score is null;
  alter table user_progress alter column best_score set default 0;
  alter table user_progress alter column best_score set not null;

  if not exists (
    select 1 from information_schema.columns
    where table_name = 'user_progress' and column_name = 'updated_at'
  ) then
    alter table user_progress add column updated_at timestamptz;
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_name = 'user_progress' and column_name = 'last_activity_at'
  ) then
    update user_progress set updated_at = last_activity_at where updated_at is null;
  end if;

  update user_progress set updated_at = now() where updated_at is null;
  alter table user_progress alter column updated_at set default now();
  alter table user_progress alter column updated_at set not null;
end $$;

create table if not exists payments (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references users(id) on delete cascade,
  amount numeric(10, 2) not null,
  status payment_status not null default 'pending',
  provider varchar(80) not null,
  created_at timestamptz not null default now()
);

create table if not exists competition_friends (
  id uuid primary key default uuid_generate_v4(),
  owner_id uuid not null references users(id) on delete cascade,
  friend_name varchar(160) not null,
  friend_email varchar(255),
  created_at timestamptz not null default now()
);

create unique index if not exists levels_level_order_unique_idx on levels(level_order);
create index if not exists module_parts_module_id_idx on module_parts(module_id);
create index if not exists levels_part_id_idx on levels(part_id);
create index if not exists levels_level_order_idx on levels(level_order);
create index if not exists questions_level_id_idx on questions(level_id);
create index if not exists question_options_question_id_idx on question_options(question_id);
create index if not exists question_items_question_id_idx on question_items(question_id);
create index if not exists quiz_attempts_user_id_idx on quiz_attempts(user_id);
create index if not exists quiz_attempts_level_id_idx on quiz_attempts(level_id);
create index if not exists student_answers_attempt_id_idx on student_answers(attempt_id);
create index if not exists user_progress_user_id_idx on user_progress(user_id);
create index if not exists payments_user_id_idx on payments(user_id);
create index if not exists competition_friends_owner_id_idx on competition_friends(owner_id);

insert into users (id, name, email, password_hash, role, is_premium)
values
  (
    '11111111-1111-1111-1111-111111111111',
    'Administrateur',
    'admin@test.com',
    crypt('admin123', gen_salt('bf')),
    'admin',
    true
  ),
  (
    '22222222-2222-2222-2222-222222222222',
    'Etudiant Demo',
    'student@test.com',
    crypt('student123', gen_salt('bf')),
    'student',
    false
  )
on conflict (id) do update set
  name = excluded.name,
  email = excluded.email,
  password_hash = excluded.password_hash,
  role = excluded.role,
  is_premium = excluded.is_premium;

insert into modules (id, title, description, slug, module_order)
values
  (
    'eeeeeeee-eeee-eeee-eeee-eeeeeeeeee01',
    'Biochimie structurale',
    'Proteines, glucides et lipides avec les quiz importes depuis le dossier module.',
    'biochimie-structurale',
    1
  ),
  (
    'eeeeeeee-eeee-eeee-eeee-eeeeeeeeee02',
    'Anatomie et physiologie humaine',
    'Cardio, digestion et respiration selon les documents presents dans le dossier module.',
    'anatomie-physiologie-humaine',
    2
  )
on conflict (slug) do update set
  title = excluded.title,
  description = excluded.description,
  module_order = excluded.module_order;

insert into module_parts (id, module_id, title, slug, part_order, source_files, keywords)
values
  ('ffffffff-ffff-ffff-ffff-ffffffffff01', (select id from modules where slug = 'biochimie-structurale'), 'Proteines', 'proteines', 1, array['proteines.html'], array['proteine', 'proteines', 'protein']),
  ('ffffffff-ffff-ffff-ffff-ffffffffff02', (select id from modules where slug = 'biochimie-structurale'), 'Glucides', 'glucides', 2, array['glucides.html'], array['glucide', 'glucides']),
  ('ffffffff-ffff-ffff-ffff-ffffffffff03', (select id from modules where slug = 'biochimie-structurale'), 'Lipides', 'lipides', 3, array['lipides.html'], array['lipide', 'lipides']),
  ('ffffffff-ffff-ffff-ffff-ffffffffff04', (select id from modules where slug = 'anatomie-physiologie-humaine'), 'Cardio', 'cardio', 1, array['cardio.doc', 'cardio2.doc'], array['cardio', 'coeur', 'circulation']),
  ('ffffffff-ffff-ffff-ffff-ffffffffff05', (select id from modules where slug = 'anatomie-physiologie-humaine'), 'Digestion', 'digestion', 2, array['digestion.pdf'], array['digestion', 'digestif', 'estomac']),
  ('ffffffff-ffff-ffff-ffff-ffffffffff06', (select id from modules where slug = 'anatomie-physiologie-humaine'), 'Respiration', 'respiration', 3, array['respiration.doc'], array['respiration', 'poumon', 'respiratoire'])
on conflict (slug) do update set
  module_id = excluded.module_id,
  title = excluded.title,
  part_order = excluded.part_order,
  source_files = excluded.source_files,
  keywords = excluded.keywords;

insert into levels (id, title, description, level_order, is_paid, passing_score)
values
  (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
    'Cellule',
    'Structure cellulaire, organites et membrane plasmique.',
    1,
    false,
    70
  ),
  (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
    'Genetique',
    'ADN, chromosomes, genes et transmission hereditaire.',
    2,
    false,
    70
  ),
  (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
    'Physiologie',
    'Fonctions des organes, respiration, digestion et circulation.',
    3,
    true,
    75
  ),
  (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4',
    'Ecologie avancee',
    'Ecosystemes, biodiversite, cycles biogeochimiques et impacts humains.',
    4,
    true,
    75
  )
on conflict (level_order) do nothing;

update levels
set part_id = (select id from module_parts where slug = 'digestion')
where id in (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2'
);

insert into questions (id, level_id, type, question_text, image_url, explanation, points)
values
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb001',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
    'qcm_single',
    'Quel organite produit principalement l''energie sous forme d''ATP ?',
    null,
    'La mitochondrie realise la respiration cellulaire et produit beaucoup d''ATP.',
    2
  ),
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb002',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
    'true_false',
    'La membrane plasmique est composee en grande partie d''une bicouche de phospholipides.',
    null,
    'La bicouche phospholipidique forme la base structurale de la membrane.',
    1
  ),
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb003',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
    'qcm_multiple',
    'Quels elements font partie de la molecule d''ADN ?',
    null,
    'L''ADN contient un sucre desoxyribose, des phosphates et des bases azotees.',
    3
  ),
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb004',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
    'fill_blank',
    'Completez : l''unite de base de l''heredite est le ____.',
    null,
    'Un gene est une sequence d''ADN portant une information hereditaire.',
    2
  ),
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb005',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
    'matching',
    'Associez chaque organe a sa fonction principale.',
    null,
    'Chaque organe assure une fonction physiologique dominante.',
    4
  ),
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb006',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4',
    'ordering',
    'Classez les niveaux d''organisation ecologique du plus petit au plus grand.',
    null,
    'Individu, population, communaute puis ecosysteme forment une progression d''echelle.',
    4
  ),
  (
    'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb007',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
    'diagram_labeling',
    'Completez les numeros du schema du systeme digestif.',
    '/uploads/schema-digestif.svg',
    'Le trajet digestif commence par la bouche, continue dans l''oesophage, passe par l''estomac puis l''intestin.',
    4
  )
on conflict (id) do nothing;

insert into question_options (question_id, option_text, is_correct, option_order)
values
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb001', 'Mitochondrie', true, 1),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb001', 'Ribosome', false, 2),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb001', 'Appareil de Golgi', false, 3),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb001', 'Lysosome', false, 4),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb002', 'Vrai', true, 1),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb002', 'Faux', false, 2),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb003', 'Desoxyribose', true, 1),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb003', 'Groupement phosphate', true, 2),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb003', 'Bases azotees', true, 3),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb003', 'Acides amines', false, 4)
on conflict do nothing;

insert into question_items (question_id, label, correct_answer, position_x, position_y, item_order)
values
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb004', 'Mot manquant', 'gene', null, null, 1),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb005', 'Poumon', 'Echanges gazeux', null, null, 1),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb005', 'Estomac', 'Digestion', null, null, 2),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb005', 'Coeur', 'Circulation sanguine', null, null, 3),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb006', 'Individu', '1', null, null, 1),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb006', 'Population', '2', null, null, 2),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb006', 'Communaute', '3', null, null, 3),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb006', 'Ecosysteme', '4', null, null, 4),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb007', '1', 'bouche', 50, 25, 1),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb007', '2', 'oesophage', 50, 43, 2),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb007', '3', 'estomac', 50, 61, 3),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbb007', '4', 'intestin', 61, 81, 4)
on conflict do nothing;

insert into user_progress (user_id, level_id, completed, unlocked, best_score)
values
  ('22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', false, true, 0),
  ('22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2', false, false, 0),
  ('22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3', false, false, 0),
  ('22222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4', false, false, 0)
on conflict (user_id, level_id) do nothing;

-- Supabase SQL Editor does not support psql include commands such as \ir.
-- After this file succeeds, run these seed files separately:
-- 1. backend/db/proteines_seed.sql
-- 2. backend/db/module_quiz_seed.sql

update levels
set part_id = (select id from module_parts where slug = 'proteines')
where part_id is null and (
  lower(title) like '%proteine%' or lower(title) like '%proteines%' or lower(description) like '%proteine%'
);

update levels
set part_id = (select id from module_parts where slug = 'glucides')
where part_id is null and (
  lower(title) like '%glucide%' or lower(description) like '%glucide%'
);

update levels
set part_id = (select id from module_parts where slug = 'lipides')
where part_id is null and (
  lower(title) like '%lipide%' or lower(description) like '%lipide%'
);

update levels
set part_id = (select id from module_parts where slug = 'cardio')
where part_id is null and (
  lower(title) like '%cardio%' or lower(description) like '%coeur%' or lower(description) like '%circulation%'
);

update levels
set part_id = (select id from module_parts where slug = 'digestion')
where part_id is null and (
  lower(title) like '%digestion%' or lower(description) like '%digestif%' or lower(description) like '%estomac%'
);

update levels
set part_id = (select id from module_parts where slug = 'respiration')
where part_id is null and (
  lower(title) like '%respiration%' or lower(description) like '%poumon%'
);
