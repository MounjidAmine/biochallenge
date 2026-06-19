
-- Quiz Biochimie - Les Proteines, importe depuis proteines_exercices_source.html
update levels
set level_order = case id
  when 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3' then -6
  when 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4' then -7
  when 'dddddddd-dddd-dddd-dddd-dddddddddd01' then -3
  when 'dddddddd-dddd-dddd-dddd-dddddddddd02' then -4
  when 'dddddddd-dddd-dddd-dddd-dddddddddd03' then -5
  else level_order
end
where id in (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4',
  'dddddddd-dddd-dddd-dddd-dddddddddd01',
  'dddddddd-dddd-dddd-dddd-dddddddddd02',
  'dddddddd-dddd-dddd-dddd-dddddddddd03'
);

insert into levels (id, title, description, level_order, is_paid, passing_score)
values
  ('dddddddd-dddd-dddd-dddd-dddddddddd01', 'Biochimie - Proteines : QCM cours', 'Fonctions, structures, liaisons et proprietes des proteines.', 3, false, 70),
  ('dddddddd-dddd-dddd-dddd-dddddddddd02', 'Biochimie - Proteines : structures des acides amines', 'Identifier les structures chimiques des 20 acides amines.', 4, false, 70),
  ('dddddddd-dddd-dddd-dddd-dddddddddd03', 'Biochimie - Proteines : classification', 'Classer les acides amines par familles et proprietes.', 5, false, 70)
on conflict (id) do update set
  title = excluded.title,
  description = excluded.description,
  level_order = excluded.level_order,
  is_paid = excluded.is_paid,
  passing_score = excluded.passing_score;

update levels
set level_order = case id
  when 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3' then 6
  when 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4' then 7
  else level_order
end
where id in (
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa4'
);

insert into questions (id, level_id, type, question_text, image_url, explanation, points)
values
  ('cccccccc-cccc-cccc-cccc-000000000001', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'Quelle protéine transporte l''oxygène dans les globules rouges ?', null, 'L''hémoglobine transporte O₂ du poumon vers les tissus (4 sous-unités + 4 hèmes Fe²⁺). La myoglobine fait de même dans le muscle. L''albumine transporte les lipides.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000002', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'Combien d''acides aminés naturels différents composent les protéines ?', null, 'Les protéines naturelles sont construites à partir de 20 acides aminés différents. Leur combinaison en séquences variées donne l''immense diversité des protéines.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000003', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'Quelle partie est commune à tous les acides aminés ?', null, 'Le squelette commun (–NH₂, –Cα–H, –COOH) est partagé par les 20 AA. Seul le radical R diffère et détermine l''identité de chaque acide aminé.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000004', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'La liaison peptidique (–CO–NH–) se forme entre :', null, 'La liaison peptidique résulte de la condensation entre le –COOH d''un AA et le –NH₂ du suivant, avec élimination d''une molécule d''eau (réaction de déshydratation).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000005', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'Combien d''acides aminés sont indispensables pour l''Homme adulte ?', null, '8 AA indispensables : Val, Leu, Ile, Thr, Met, Lys, Phe, Trp. L''organisme ne peut pas les synthétiser → apport alimentaire obligatoire.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000006', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'La structure primaire d''une protéine désigne :', null, 'La structure primaire = séquence linéaire des AA reliés par des liaisons peptidiques. Elle conditionne toutes les structures supérieures (II, III, IV).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000007', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'Combien de résidus compte une hélice α par tour complet ?', null, 'L''hélice α comporte 3,6 résidus/tour (pas = 0,54 nm). Les liaisons H s''établissent entre C=O du résidu i et N–H du résidu i+4, parallèlement à l''axe de l''hélice.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000008', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'Quel acide aminé forme des ponts disulfure –S–S– par oxydation ?', null, 'La cystéine (–CH₂–SH) forme des ponts disulfure (–S–S–) avec une autre cystéine par oxydation. Ces ponts covalents stabilisent la structure tertiaire. La méthionine a aussi du soufre (–S–CH₃) mais ne forme pas de pont disulfure.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000009', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'La méthode du biuret dose les protéines par un complexe violet avec des ions :', null, 'Méthode du biuret (Gornall 1949) : ions Cu²⁺ en milieu alcalin + 2 liaisons peptidiques → complexe violet absorbant à 540–550 nm. C''est la méthode classique de dosage des protéines.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000010', 'dddddddd-dddd-dddd-dddd-dddddddddd01', 'qcm_single', 'La trypsine coupe les liaisons peptidiques après les résidus :', null, 'La trypsine coupe après les résidus Lys (K) et Arg (R) (basiques). La chymotrypsine coupe après Phe/Tyr/Trp. Le BrCN coupe après Met.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000011', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Glycine — l''acide aminé le plus simple (R = H, pas de carbone asymétrique) :', null, 'La glycine (G) est la plus simple : son radical R est simplement un atome d''hydrogène (–H). C''est le seul AA non chiral (pas de carbone asymétrique). Elle est très flexible et se trouve souvent dans les coudes des protéines.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000012', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez l''Alanine — R = –CH₃ (le méthyle le plus court après la glycine) :', null, 'L''alanine (A) a un radical R = –CH₃ (méthyle). C''est l''AA aliphatique le plus court après la glycine. Apolaire, hydrophobe, très abondante dans les hélices α.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000013', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Valine — R = –CH(CH₃)₂ (isopropyle, 2 méthyles sur le même carbone) :', null, 'La valine (V) a un radical isopropyle : –CH(CH₃)₂ — deux méthyles sur le même carbone β. AA indispensable, hydrophobe, souvent enfoui dans le cœur des protéines globulaires.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000014', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Leucine — R = –CH₂–CH(CH₃)₂ (chaîne plus longue que la valine) :', null, 'La leucine (L) a un radical R = –CH₂–CH(CH₃)₂ : une chaîne de 2 carbones terminée par un groupe isopropyle. AA indispensable, le plus abondant dans les protéines humaines. Différence vs valine : un –CH₂– supplémentaire entre le Cα et le carbone branché.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000015', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez l''Isoleucine — R doublement ramifié avec deux carbones méthyle sur des carbones différents :', null, 'L''isoleucine (I) a deux méthyles sur des carbones différents (Cβ et Cγ). Contrairement à la valine (deux méthyles sur le même Cβ). AA indispensable avec 2 carbones asymétriques → 4 stéréoisomères possibles.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000016', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Sérine — R = –CH₂–OH (le plus court des hydroxylés) :', null, 'La sérine (S) a R = –CH₂–OH. AA hydroxylé, polaire. Phosphorylable par les sérine-kinases (régulation enzymatique majeure). Non indispensable (synthétisable à partir du glucose).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000017', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Thréonine — R = –CH(OH)–CH₃ (hydroxylé avec un méthyle) :', null, 'La thréonine (T) a R = –CH(OH)–CH₃. Hydroxylée + méthyle → 2 carbones asymétriques. AA indispensable, phosphorylable. Différence vs sérine : présence d''un méthyle supplémentaire.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000018', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Cystéine — R = –CH₂–SH (thiol, forme des ponts disulfure) :', null, 'La cystéine (C) a R = –CH₂–SH (thiol). Par oxydation : 2 cystéines → pont disulfure –S–S– (stabilisation tertiaire covalente). La méthionine a aussi du soufre (–S–CH₃) mais ne peut pas former de pont disulfure.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000019', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Méthionine — R = –CH₂–CH₂–S–CH₃ (thioéther, donneur de méthyle) :', null, 'La méthionine (M) a R = –CH₂–CH₂–S–CH₃ (thioéther). Donneur de méthyle universel via la S-adénosylméthionine (SAM). AA indispensable. La méthionine est aussi l''AA d''initiation de toute traduction protéique (codon AUG).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000020', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez l''Acide Aspartique — R = –CH₂–COOH (le plus court des acides, 1 carbone) :', null, 'L''acide aspartique (D) a R = –CH₂–COOH (1 seul carbone entre Cα et –COOH). Chargé négativement (–COO⁻) à pH 7 (pKa ≈ 3,9). Différence vs acide glutamique : 1 CH₂ de moins dans la chaîne latérale.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000021', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez l''Asparagine — R = –CH₂–CO–NH₂ (dérivé amide de l''acide aspartique) :', null, 'L''asparagine (N) est le dérivé amide de l''acide aspartique : R = –CH₂–CO–NH₂. Neutre (vs Asp chargé–). Détoxifiante pour l''ammoniac cellulaire. La glutamine est l''homologue avec une chaîne plus longue (2 CH₂ au lieu de 1).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000022', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez l''Acide Glutamique — R = –CH₂–CH₂–COOH (2 carbones avant le –COOH) :', null, 'L''acide glutamique (E) a R = –CH₂–CH₂–COOH (2 carbones entre Cα et –COOH). Chargé négativement à pH 7 (pKa ≈ 4,1). Un CH₂ de plus que l''acide aspartique. La glutamine synthétase transforme Glu + NH₃ + ATP → Gln.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000023', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Glutamine — R = –CH₂–CH₂–CO–NH₂ (dérivé amide de l''acide glutamique) :', null, 'La glutamine (Q) est le dérivé amide de l''acide glutamique : R = –(CH₂)₂–CO–NH₂. Neutre. Rôle majeur dans le transport de l''azote et la détoxification de NH₃. La plus abondante dans le plasma humain.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000024', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Lysine — R = –(CH₂)₄–NH₂ (longue chaîne avec amine terminale) :', null, 'La lysine (K) a R = –(CH₂)₄–NH₂ (4 carbones + amine ε). Chargée positivement à pH 7 (pKa ≈ 10,5). AA indispensable. Souvent limitante dans les protéines végétales (céréales). Impliquée dans la formation des ponts du collagène.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000025', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez l''Arginine — R avec groupement guanidyle (–C(=NH)–NH₂) très basique :', null, 'L''arginine (R) a un groupement guanidyle (–NH–C(=NH)–NH₂) → pKa ≈ 12,5 → toujours chargée positivement au pH physiologique (l''AA le plus basique). Précurseur du monoxyde d''azote (NO) via la NO-synthase.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000026', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez l''Histidine — R avec noyau imidazole à 5 chaînons :', null, 'L''histidine (H) a un noyau imidazole (cycle à 5 chaînons avec 2 N). pKa ≈ 6,0 → partiellement ionisée à pH 7 → excellent tampon physiologique. Résidu catalytique essentiel dans de nombreuses enzymes (chymotrypsine, ribonucléase…).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000027', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Phénylalanine — R avec noyau benzénique pur (sans substituant) :', null, 'La phénylalanine (F) a un groupement phényl (benzène pur, sans substituant). AA indispensable, apolaire. Absorbe à 257 nm. Précurseur de la tyrosine (phénylalaninhydroxylase). Déficit en phénylalaninhydroxylase → phénylcétonurie (PCU).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000028', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Tyrosine — R avec noyau phénol (benzène + –OH) :', null, 'La tyrosine (Y) a un groupement phénol (benzène + –OH). Polaire. Phosphorylable par les tyrosine-kinases (signalisation cellulaire). Absorbe à 274 nm. Précurseur des catécholamines (dopamine, adrénaline) et de la mélanine.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000029', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez le Tryptophane — R avec noyau indole bicyclique (benzène fusionné à un pyrrole) :', null, 'Le tryptophane (W) a un noyau indole bicyclique (benzène fusionné à un pyrrole avec –NH). AA indispensable le plus volumineux. Fortement fluorescent (émission ≈ 350 nm). Principal responsable de l''absorption des protéines à 280 nm. Précurseur de la sérotonine et de la mélatonine.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000030', 'dddddddd-dddd-dddd-dddd-dddddddddd02', 'qcm_single', 'Identifiez la Proline — R forme un cycle pyrrolidine avec l''azote (acide iminé) :', null, 'La proline (P) est unique : son azote N est intégré dans un cycle pyrrolidine à 5 chaînons → amine secondaire (acide iminé). Elle brise les hélices α et les feuillets β. Avec la ninhydrine → couleur jaune (tous les autres AA donnent violet). Abondante dans le collagène sous forme d''hydroxyproline.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000031', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'Glycine, Alanine, Valine, Leucine, Isoleucine → groupe :', null, 'Groupe a) Aliphatiques : R ne contient que C et H → apolaires, hydrophobes. On les retrouve enfouis dans le cœur hydrophobe des protéines. La glycine (R=H) est le plus simple, l''isoleucine le plus ramifié.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000032', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'Sérine (–CH₂–OH) et Thréonine (–CH(OH)–CH₃) → groupe :', null, 'Groupe b) Hydroxylés : R porte un –OH → polaires, phosphorylables par les kinases. La sérine et la thréonine sont des cibles importantes de la signalisation cellulaire (phosphorylation/déphosphorylation).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000033', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'Cystéine (–SH) et Méthionine (–S–CH₃) → groupe :', null, 'Groupe c) Soufrés. Cystéine : pont disulfure par oxydation (–S–S–). Méthionine : donneur de méthyle universel via SAM. La méthionine est l''AA d''initiation de toute traduction (codon AUG).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000034', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'Acide Aspartique, Asparagine, Acide Glutamique, Glutamine → groupe :', null, 'Groupe d) Acides et dérivés amides. Asp et Glu : –COOH → chargés – à pH 7. Asn et Gln : –CO–NH₂ → neutres (dérivés amides). La glutamine est le transporteur principal de l''azote dans le sang.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000035', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'Lysine (–(CH₂)₄–NH₂), Arginine (guanidyle), Histidine (imidazole) → groupe :', null, 'Groupe e) Basiques : R chargé positivement à pH 7. Lys (pKa≈10,5), Arg (pKa≈12,5 — toujours +), His (pKa≈6,0 — tampon physiologique et résidu catalytique des enzymes).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000036', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'Phénylalanine (phényl), Tyrosine (phénol), Tryptophane (indole) → groupe :', null, 'Groupe f) Aromatiques : R contient un noyau aromatique. Phe (phényl), Tyr (phénol), Trp (indole). Ces 3 AA absorbent les UV → dosage des protéines à 280 nm.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000037', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'La Proline se distingue de tous les autres AA car son azote est :', null, 'La proline est un acide iminé : son N est dans un cycle pyrrolidine (amine secondaire). Elle brise les hélices α. Avec la ninhydrine → couleur jaune (tous les autres AA = violet).', 1),
  ('cccccccc-cccc-cccc-cccc-000000000038', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'Parmi ces 4 AA, lequel N''EST PAS indispensable pour l''Homme adulte ?', null, 'La sérine n''est pas indispensable : synthétisable à partir du glucose via la 3-phosphoglycérate. Les 8 indispensables : Val, Leu, Ile, Thr, Met, Lys, Phe, Trp.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000039', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'Quel groupe d''AA permet de doser les protéines par absorbance à 280 nm ?', null, 'Les AA aromatiques absorbent les UV. Le tryptophane absorbe le plus fortement à 280 nm → méthode rapide de dosage des protéines (A₂₈₀). La fluorescence du Trp (émission 350 nm) est utilisée pour étudier le repliement protéique.', 1),
  ('cccccccc-cccc-cccc-cccc-000000000040', 'dddddddd-dddd-dddd-dddd-dddddddddd03', 'qcm_single', 'La chymotrypsine coupe après les résidus appartenant au groupe :', null, 'La chymotrypsine reconnaît les résidus aromatiques volumineux (Phe, Tyr, Trp) qui s''insèrent dans sa poche hydrophobe. Elle coupe après leur –CO–. La trypsine coupe après les basiques (Lys, Arg). Le BrCN coupe après Met.', 1)
on conflict (id) do update set
  level_id = excluded.level_id,
  type = excluded.type,
  question_text = excluded.question_text,
  image_url = excluded.image_url,
  explanation = excluded.explanation,
  points = excluded.points;

insert into question_options (question_id, option_text, is_correct, option_order)
values
  ('cccccccc-cccc-cccc-cccc-000000000001', 'Insuline', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000001', 'Hémoglobine', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000001', 'Collagène', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000001', 'Albumine', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000002', '10', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000002', '20', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000002', '64', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000002', '100', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000003', 'Le radical R', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000003', 'Le noyau benzénique', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000003', 'Le squelette NH₂–Cα–COOH', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000003', 'La chaîne aliphatique', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000004', '–COOH d''un AA et –NH₂ du suivant', true, 1),
  ('cccccccc-cccc-cccc-cccc-000000000004', '–OH et –SH de deux AA', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000004', 'Deux –COOH avec perte de CO₂', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000004', '–NH₂ et –NH₂ de deux AA', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000005', '4', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000005', '6', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000005', '8', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000005', '12', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000006', 'La forme globale en 3D', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000006', 'L''assemblage de plusieurs sous-unités', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000006', 'La séquence linéaire des AA', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000006', 'Les hélices et feuillets', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000007', '2,0 résidus/tour', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000007', '3,6 résidus/tour', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000007', '5,0 résidus/tour', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000007', '7,2 résidus/tour', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000008', 'Méthionine', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000008', 'Sérine', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000008', 'Cystéine', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000008', 'Thréonine', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000009', 'Fe³⁺ en milieu acide', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000009', 'Cu²⁺ en milieu alcalin', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000009', 'Zn²⁺ en milieu neutre', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000009', 'Mn²⁺ en milieu alcalin', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000010', 'Phe, Tyr, Trp (aromatiques)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000010', 'Met uniquement', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000010', 'Lys, Arg (basiques)', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000010', 'Glu, Asp (acides)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000011', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="20" y="55" font-size="11" fill="#9ca3af" font-family="monospace">H</text>
  <text x="20" y="70" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="52" y1="65" x2="76" y2="65" stroke="#9ca3af" stroke-width="2"/>
  <text x="50" y="57" font-size="11" fill="#9ca3af" font-family="monospace">C</text>
  <text x="78" y="68" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="58" y1="57" x2="58" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="42" y="80" font-size="11" fill="#9ca3af" font-family="monospace">H</text>
  <text x="30" y="105" font-size="10" fill="#6b7a99" font-family="monospace">R = H  (aucun substituant)</text>
</svg>
Glycine (G)', true, 1),
  ('cccccccc-cccc-cccc-cccc-000000000011', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="72" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="72" y="56" font-size="11" fill="#9ca3af" font-family="monospace">C</text>
  <text x="76" y="50" font-size="10" fill="#9ca3af" font-family="monospace">H</text>
  <line x1="84" y1="60" x2="112" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="65" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <text x="72" y="80" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <line x1="80" y1="65" x2="80" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
</svg>
Alanine (A)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000011', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace">HO</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–OH</text>
</svg>
Sérine (S)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000011', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace" font-weight="bold">HS</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–SH (thiol)</text>
</svg>
Cystéine (C)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000012', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="40" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="36" x2="56" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <text x="8" y="76" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="72" x2="56" y2="56" stroke="#9ca3af" stroke-width="2"/>
  <line x1="56" y1="54" x2="82" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="82" y1="54" x2="98" y2="42" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="40" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="82" y1="54" x2="82" y2="72" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="68" y="86" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Valine (V)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000012', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="20" y="55" font-size="11" fill="#9ca3af" font-family="monospace">H</text>
  <text x="20" y="70" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="52" y1="65" x2="76" y2="65" stroke="#9ca3af" stroke-width="2"/>
  <text x="50" y="57" font-size="11" fill="#9ca3af" font-family="monospace">C</text>
  <text x="78" y="68" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="58" y1="57" x2="58" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="42" y="80" font-size="11" fill="#9ca3af" font-family="monospace">H</text>
  <text x="30" y="105" font-size="10" fill="#6b7a99" font-family="monospace">R = H  (aucun substituant)</text>
</svg>
Glycine (G)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000012', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="72" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="72" y="56" font-size="11" fill="#9ca3af" font-family="monospace">C</text>
  <text x="76" y="50" font-size="10" fill="#9ca3af" font-family="monospace">H</text>
  <line x1="84" y1="60" x2="112" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="65" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <text x="72" y="80" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <line x1="80" y1="65" x2="80" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
</svg>
Alanine (A)', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000012', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="38" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="34" x2="48" y2="48" stroke="#9ca3af" stroke-width="2"/>
  <text x="5" y="70" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="66" x2="48" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <line x1="48" y1="50" x2="70" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="50" x2="86" y2="37" stroke="#9ca3af" stroke-width="2"/>
  <line x1="86" y1="37" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="37" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="86" y1="37" x2="86" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="82" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Leucine (L)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000013', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="38" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="34" x2="48" y2="48" stroke="#9ca3af" stroke-width="2"/>
  <text x="5" y="70" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="66" x2="48" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <line x1="48" y1="50" x2="70" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="50" x2="86" y2="37" stroke="#9ca3af" stroke-width="2"/>
  <line x1="86" y1="37" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="37" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="86" y1="37" x2="86" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="82" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Leucine (L)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000013', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="40" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="36" x2="50" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="5" y="70" font-size="10" fill="#4f9cf9" font-family="monospace">CH₃</text>
  <line x1="32" y1="65" x2="50" y2="53" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="52" x2="70" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="52" x2="88" y2="39" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="39" x2="106" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="39" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="39" x2="88" y2="70" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="84" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Isoleucine (I)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000013', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="72" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="72" y="56" font-size="11" fill="#9ca3af" font-family="monospace">C</text>
  <text x="76" y="50" font-size="10" fill="#9ca3af" font-family="monospace">H</text>
  <line x1="84" y1="60" x2="112" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="65" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <text x="72" y="80" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <line x1="80" y1="65" x2="80" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
</svg>
Alanine (A)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000013', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="40" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="36" x2="56" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <text x="8" y="76" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="72" x2="56" y2="56" stroke="#9ca3af" stroke-width="2"/>
  <line x1="56" y1="54" x2="82" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="82" y1="54" x2="98" y2="42" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="40" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="82" y1="54" x2="82" y2="72" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="68" y="86" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Valine (V)', true, 4),
  ('cccccccc-cccc-cccc-cccc-000000000014', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="38" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="34" x2="48" y2="48" stroke="#9ca3af" stroke-width="2"/>
  <text x="5" y="70" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="66" x2="48" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <line x1="48" y1="50" x2="70" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="50" x2="86" y2="37" stroke="#9ca3af" stroke-width="2"/>
  <line x1="86" y1="37" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="37" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="86" y1="37" x2="86" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="82" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Leucine (L)', true, 1),
  ('cccccccc-cccc-cccc-cccc-000000000014', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="40" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="36" x2="56" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <text x="8" y="76" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="72" x2="56" y2="56" stroke="#9ca3af" stroke-width="2"/>
  <line x1="56" y1="54" x2="82" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="82" y1="54" x2="98" y2="42" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="40" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="82" y1="54" x2="82" y2="72" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="68" y="86" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Valine (V)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000014', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="40" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="36" x2="50" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="5" y="70" font-size="10" fill="#4f9cf9" font-family="monospace">CH₃</text>
  <line x1="32" y1="65" x2="50" y2="53" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="52" x2="70" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="52" x2="88" y2="39" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="39" x2="106" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="39" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="39" x2="88" y2="70" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="84" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Isoleucine (I)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000014', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="62" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="63" y="66" font-size="14" fill="#f0a500" font-family="monospace" font-weight="bold">S</text>
  <line x1="76" y1="60" x2="96" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="96" y1="60" x2="112" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="112" y1="47" x2="128" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="128" y1="60" x2="144" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="146" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="128" y1="60" x2="128" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="114" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Méthionine (M)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000015', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="40" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="36" x2="56" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <text x="8" y="76" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="72" x2="56" y2="56" stroke="#9ca3af" stroke-width="2"/>
  <line x1="56" y1="54" x2="82" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="82" y1="54" x2="98" y2="42" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="40" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="82" y1="54" x2="82" y2="72" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="68" y="86" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Valine (V)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000015', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="38" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="34" x2="48" y2="48" stroke="#9ca3af" stroke-width="2"/>
  <text x="5" y="70" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="66" x2="48" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <line x1="48" y1="50" x2="70" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="50" x2="86" y2="37" stroke="#9ca3af" stroke-width="2"/>
  <line x1="86" y1="37" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="37" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="86" y1="37" x2="86" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="82" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Leucine (L)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000015', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="40" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="36" x2="50" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="5" y="70" font-size="10" fill="#4f9cf9" font-family="monospace">CH₃</text>
  <line x1="32" y1="65" x2="50" y2="53" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="52" x2="70" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="52" x2="88" y2="39" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="39" x2="106" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="39" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="39" x2="88" y2="70" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="84" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Isoleucine (I)', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000015', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="72" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="72" y="56" font-size="11" fill="#9ca3af" font-family="monospace">C</text>
  <text x="76" y="50" font-size="10" fill="#9ca3af" font-family="monospace">H</text>
  <line x1="84" y1="60" x2="112" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="65" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <text x="72" y="80" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <line x1="80" y1="65" x2="80" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
</svg>
Alanine (A)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000016', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="62" font-size="12" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="38" y1="57" x2="58" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <text x="59" y="52" font-size="11" fill="#f0a500" font-family="monospace">OH</text>
  <line x1="58" y1="57" x2="76" y2="44" stroke="#9ca3af" stroke-width="2"/>
  <line x1="76" y1="44" x2="94" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <text x="96" y="43" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="76" y1="44" x2="76" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="62" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Thréonine (T)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000016', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace">HO</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–OH</text>
</svg>
Sérine (S)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000016', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace" font-weight="bold">HS</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–SH (thiol)</text>
</svg>
Cystéine (C)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000016', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="72" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="72" y="56" font-size="11" fill="#9ca3af" font-family="monospace">C</text>
  <text x="76" y="50" font-size="10" fill="#9ca3af" font-family="monospace">H</text>
  <line x1="84" y1="60" x2="112" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="65" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <text x="72" y="80" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <line x1="80" y1="65" x2="80" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
</svg>
Alanine (A)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000017', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace">HO</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–OH</text>
</svg>
Sérine (S)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000017', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="62" font-size="12" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="38" y1="57" x2="58" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <text x="59" y="52" font-size="11" fill="#f0a500" font-family="monospace">OH</text>
  <line x1="58" y1="57" x2="76" y2="44" stroke="#9ca3af" stroke-width="2"/>
  <line x1="76" y1="44" x2="94" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <text x="96" y="43" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="76" y1="44" x2="76" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="62" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Thréonine (T)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000017', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="40" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="36" x2="56" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <text x="8" y="76" font-size="11" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="36" y1="72" x2="56" y2="56" stroke="#9ca3af" stroke-width="2"/>
  <line x1="56" y1="54" x2="82" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="82" y1="54" x2="98" y2="42" stroke="#9ca3af" stroke-width="2"/>
  <text x="100" y="40" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="82" y1="54" x2="82" y2="72" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="68" y="86" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Valine (V)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000017', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="52" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="52" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="74" y1="60" x2="90" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="90" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="60" x2="122" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="124" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="60" x2="106" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₂–CO–NH₂</text>
</svg>
Glutamine (Q)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000018', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="62" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="63" y="66" font-size="14" fill="#f0a500" font-family="monospace" font-weight="bold">S</text>
  <line x1="76" y1="60" x2="96" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="96" y1="60" x2="112" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="112" y1="47" x2="128" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="128" y1="60" x2="144" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="146" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="128" y1="60" x2="128" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="114" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Méthionine (M)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000018', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace">HO</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–OH</text>
</svg>
Sérine (S)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000018', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="62" font-size="12" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="38" y1="57" x2="58" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <text x="59" y="52" font-size="11" fill="#f0a500" font-family="monospace">OH</text>
  <line x1="58" y1="57" x2="76" y2="44" stroke="#9ca3af" stroke-width="2"/>
  <line x1="76" y1="44" x2="94" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <text x="96" y="43" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="76" y1="44" x2="76" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="62" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Thréonine (T)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000018', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace" font-weight="bold">HS</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–SH (thiol)</text>
</svg>
Cystéine (C)', true, 4),
  ('cccccccc-cccc-cccc-cccc-000000000019', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace" font-weight="bold">HS</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–SH (thiol)</text>
</svg>
Cystéine (C)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000019', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="62" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="63" y="66" font-size="14" fill="#f0a500" font-family="monospace" font-weight="bold">S</text>
  <line x1="76" y1="60" x2="96" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="96" y1="60" x2="112" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="112" y1="47" x2="128" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="128" y1="60" x2="144" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="146" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="128" y1="60" x2="128" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="114" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Méthionine (M)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000019', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#9ca3af" font-family="monospace">HOOC</text>
  <line x1="46" y1="60" x2="64" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="60" x2="80" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="80" y1="47" x2="96" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="96" y1="60" x2="112" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="96" y1="60" x2="96" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="82" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–CH₂–COOH</text>
</svg>
Ac. Glutamique (E)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000019', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="38" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="34" x2="48" y2="48" stroke="#9ca3af" stroke-width="2"/>
  <text x="5" y="70" font-size="10" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="30" y1="66" x2="48" y2="52" stroke="#9ca3af" stroke-width="2"/>
  <line x1="48" y1="50" x2="70" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="50" x2="86" y2="37" stroke="#9ca3af" stroke-width="2"/>
  <line x1="86" y1="37" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="37" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="86" y1="37" x2="86" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="82" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Leucine (L)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000020', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#9ca3af" font-family="monospace">HOOC</text>
  <line x1="46" y1="60" x2="64" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="60" x2="80" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="80" y1="47" x2="96" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="96" y1="60" x2="112" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="96" y1="60" x2="96" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="82" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–CH₂–COOH</text>
</svg>
Ac. Glutamique (E)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000020', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#9ca3af" font-family="monospace">HOOC</text>
  <line x1="46" y1="60" x2="68" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="68" y1="60" x2="84" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="84" y1="46" x2="100" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="102" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="84" y1="46" x2="84" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="70" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="10" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–COOH</text>
</svg>
Ac. Aspartique (D)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000020', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="54" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="54" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="76" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="108" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="110" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–CO–NH₂</text>
</svg>
Asparagine (N)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000020', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="52" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="52" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="74" y1="60" x2="90" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="90" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="60" x2="122" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="124" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="60" x2="106" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₂–CO–NH₂</text>
</svg>
Glutamine (Q)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000021', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="54" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="54" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="76" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="108" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="110" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–CO–NH₂</text>
</svg>
Asparagine (N)', true, 1),
  ('cccccccc-cccc-cccc-cccc-000000000021', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="52" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="52" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="74" y1="60" x2="90" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="90" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="60" x2="122" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="124" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="60" x2="106" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₂–CO–NH₂</text>
</svg>
Glutamine (Q)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000021', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#9ca3af" font-family="monospace">HOOC</text>
  <line x1="46" y1="60" x2="68" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="68" y1="60" x2="84" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="84" y1="46" x2="100" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="102" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="84" y1="46" x2="84" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="70" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="10" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–COOH</text>
</svg>
Ac. Aspartique (D)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000021', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#9ca3af" font-family="monospace">HOOC</text>
  <line x1="46" y1="60" x2="64" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="60" x2="80" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="80" y1="47" x2="96" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="96" y1="60" x2="112" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="96" y1="60" x2="96" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="82" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–CH₂–COOH</text>
</svg>
Ac. Glutamique (E)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000022', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#9ca3af" font-family="monospace">HOOC</text>
  <line x1="46" y1="60" x2="68" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="68" y1="60" x2="84" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="84" y1="46" x2="100" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="102" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="84" y1="46" x2="84" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="70" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="10" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–COOH</text>
</svg>
Ac. Aspartique (D)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000022', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="52" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="52" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="74" y1="60" x2="90" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="90" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="60" x2="122" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="124" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="60" x2="106" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₂–CO–NH₂</text>
</svg>
Glutamine (Q)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000022', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#9ca3af" font-family="monospace">HOOC</text>
  <line x1="46" y1="60" x2="64" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="60" x2="80" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="80" y1="47" x2="96" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="96" y1="60" x2="112" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="96" y1="60" x2="96" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="82" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–CH₂–COOH</text>
</svg>
Ac. Glutamique (E)', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000022', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="65" font-size="11" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="34" y1="60" x2="50" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="60" x2="64" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="47" x2="78" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="47" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₄–NH₂</text>
</svg>
Lysine (K)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000023', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="54" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="54" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="76" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="108" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="110" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–CO–NH₂</text>
</svg>
Asparagine (N)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000023', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="52" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="52" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="74" y1="60" x2="90" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="90" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="60" x2="122" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="124" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="60" x2="106" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₂–CO–NH₂</text>
</svg>
Glutamine (Q)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000023', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#9ca3af" font-family="monospace">HOOC</text>
  <line x1="46" y1="60" x2="64" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="60" x2="80" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="80" y1="47" x2="96" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="96" y1="60" x2="112" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="96" y1="60" x2="96" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="82" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–CH₂–COOH</text>
</svg>
Ac. Glutamique (E)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000023', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="65" font-size="11" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="34" y1="60" x2="50" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="60" x2="64" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="47" x2="78" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="47" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₄–NH₂</text>
</svg>
Lysine (K)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000024', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="44" font-size="10" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="33" y1="40" x2="52" y2="53" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="5" y="72" font-size="10" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="33" y1="68" x2="52" y2="55" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="48" y="62" font-size="11" fill="#f0a500" font-family="monospace" font-weight="bold">C</text>
  <text x="56" y="40" font-size="9" fill="#f0a500" font-family="monospace">=NH</text>
  <line x1="58" y1="42" x2="58" y2="52" stroke="#f0a500" stroke-width="1.5"/>
  <line x1="64" y1="55" x2="84" y2="55" stroke="#9ca3af" stroke-width="1.8"/>
  <line x1="84" y1="55" x2="100" y2="42" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="102" y="40" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="84" y1="55" x2="84" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="70" y="87" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">Guanidyle</text>
</svg>
Arginine (R)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000024', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="22,65 36,42 58,42 66,65 48,78" fill="none" stroke="#a78bfa" stroke-width="2"/>
  <text x="24" y="60" font-size="9" fill="#9ca3af" font-family="monospace">N</text>
  <text x="50" y="45" font-size="9" fill="#a78bfa" font-family="monospace">NH</text>
  <line x1="66" y1="63" x2="88" y2="63" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="63" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="48" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="63" x2="88" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Imidazole</text>
</svg>
Histidine (H)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000024', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="52" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="52" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="74" y1="60" x2="90" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="90" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="60" x2="122" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="124" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="60" x2="106" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₂–CO–NH₂</text>
</svg>
Glutamine (Q)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000024', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="65" font-size="11" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="34" y1="60" x2="50" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="60" x2="64" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="47" x2="78" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="47" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₄–NH₂</text>
</svg>
Lysine (K)', true, 4),
  ('cccccccc-cccc-cccc-cccc-000000000025', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="65" font-size="11" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="34" y1="60" x2="50" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="60" x2="64" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="47" x2="78" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="47" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₄–NH₂</text>
</svg>
Lysine (K)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000025', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="44" font-size="10" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="33" y1="40" x2="52" y2="53" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="5" y="72" font-size="10" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="33" y1="68" x2="52" y2="55" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="48" y="62" font-size="11" fill="#f0a500" font-family="monospace" font-weight="bold">C</text>
  <text x="56" y="40" font-size="9" fill="#f0a500" font-family="monospace">=NH</text>
  <line x1="58" y1="42" x2="58" y2="52" stroke="#f0a500" stroke-width="1.5"/>
  <line x1="64" y1="55" x2="84" y2="55" stroke="#9ca3af" stroke-width="1.8"/>
  <line x1="84" y1="55" x2="100" y2="42" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="102" y="40" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="84" y1="55" x2="84" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="70" y="87" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">Guanidyle</text>
</svg>
Arginine (R)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000025', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="22,65 36,42 58,42 66,65 48,78" fill="none" stroke="#a78bfa" stroke-width="2"/>
  <text x="24" y="60" font-size="9" fill="#9ca3af" font-family="monospace">N</text>
  <text x="50" y="45" font-size="9" fill="#a78bfa" font-family="monospace">NH</text>
  <line x1="66" y1="63" x2="88" y2="63" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="63" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="48" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="63" x2="88" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Imidazole</text>
</svg>
Histidine (H)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000025', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="8" y="65" font-size="11" fill="#4f9cf9" font-family="monospace">H₂N</text>
  <line x1="36" y1="60" x2="52" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="52" y="55" font-size="11" fill="#9ca3af" font-family="monospace">C=O</text>
  <line x1="74" y1="60" x2="90" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="90" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="60" x2="122" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="124" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="60" x2="106" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₂–CO–NH₂</text>
</svg>
Glutamine (Q)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000026', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="44" font-size="10" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="33" y1="40" x2="52" y2="53" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="5" y="72" font-size="10" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="33" y1="68" x2="52" y2="55" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="48" y="62" font-size="11" fill="#f0a500" font-family="monospace" font-weight="bold">C</text>
  <text x="56" y="40" font-size="9" fill="#f0a500" font-family="monospace">=NH</text>
  <line x1="58" y1="42" x2="58" y2="52" stroke="#f0a500" stroke-width="1.5"/>
  <line x1="64" y1="55" x2="84" y2="55" stroke="#9ca3af" stroke-width="1.8"/>
  <line x1="84" y1="55" x2="100" y2="42" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="102" y="40" font-size="10" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="84" y1="55" x2="84" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="70" y="87" font-size="10" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">Guanidyle</text>
</svg>
Arginine (R)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000026', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="65" font-size="11" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="34" y1="60" x2="50" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="60" x2="64" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="47" x2="78" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="47" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₄–NH₂</text>
</svg>
Lysine (K)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000026', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="22,65 36,42 58,42 66,65 48,78" fill="none" stroke="#a78bfa" stroke-width="2"/>
  <text x="24" y="60" font-size="9" fill="#9ca3af" font-family="monospace">N</text>
  <text x="50" y="45" font-size="9" fill="#a78bfa" font-family="monospace">NH</text>
  <line x1="66" y1="63" x2="88" y2="63" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="63" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="48" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="63" x2="88" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Imidazole</text>
</svg>
Histidine (H)', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000026', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="12,65 28,43 50,43 58,65 50,80 28,80" fill="none" stroke="#4f9cf9" stroke-width="1.8"/>
  <polygon points="50,43 70,31 84,43 84,65 70,77 58,65" fill="none" stroke="#4f9cf9" stroke-width="1.6"/>
  <text x="32" y="62" font-size="9" fill="#9ca3af" font-family="monospace">NH</text>
  <line x1="84" y1="54" x2="106" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="54" x2="123" y2="64" stroke="#9ca3af" stroke-width="2"/>
  <text x="125" y="63" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="54" x2="106" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="89" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Indole (bicyclique)</text>
</svg>
Tryptophane (W)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000027', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="28" font-size="11" fill="#f0a500" font-family="monospace">HO</text>
  <line x1="27" y1="24" x2="37" y2="24" stroke="#9ca3af" stroke-width="1.5"/>
  <polygon points="37,16 53,8 69,16 69,32 53,40 37,32" fill="none" stroke="#4f9cf9" stroke-width="2"/>
  <line x1="53" y1="40" x2="53" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <line x1="53" y1="57" x2="75" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <line x1="75" y1="57" x2="91" y2="44" stroke="#9ca3af" stroke-width="2"/>
  <text x="93" y="42" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="75" y1="57" x2="75" y2="74" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="59" y="88" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="110" font-size="10" fill="#6b7a99" font-family="monospace">Phénol (benzène + OH)</text>
</svg>
Tyrosine (Y)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000027', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="12,65 28,43 50,43 58,65 50,80 28,80" fill="none" stroke="#4f9cf9" stroke-width="1.8"/>
  <polygon points="50,43 70,31 84,43 84,65 70,77 58,65" fill="none" stroke="#4f9cf9" stroke-width="1.6"/>
  <text x="32" y="62" font-size="9" fill="#9ca3af" font-family="monospace">NH</text>
  <line x1="84" y1="54" x2="106" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="54" x2="123" y2="64" stroke="#9ca3af" stroke-width="2"/>
  <text x="125" y="63" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="54" x2="106" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="89" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Indole (bicyclique)</text>
</svg>
Tryptophane (W)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000027', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="36,32 56,20 76,32 76,56 56,68 36,56" fill="none" stroke="#4f9cf9" stroke-width="2"/>
  <line x1="56" y1="68" x2="56" y2="84" stroke="#9ca3af" stroke-width="2"/>
  <line x1="56" y1="84" x2="78" y2="84" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="84" x2="96" y2="71" stroke="#9ca3af" stroke-width="2"/>
  <text x="98" y="69" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="78" y1="84" x2="78" y2="99" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="62" y="110" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Phénylalanine (F)', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000027', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="22,65 36,42 58,42 66,65 48,78" fill="none" stroke="#a78bfa" stroke-width="2"/>
  <text x="24" y="60" font-size="9" fill="#9ca3af" font-family="monospace">N</text>
  <text x="50" y="45" font-size="9" fill="#a78bfa" font-family="monospace">NH</text>
  <line x1="66" y1="63" x2="88" y2="63" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="63" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="48" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="63" x2="88" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Imidazole</text>
</svg>
Histidine (H)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000028', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="36,32 56,20 76,32 76,56 56,68 36,56" fill="none" stroke="#4f9cf9" stroke-width="2"/>
  <line x1="56" y1="68" x2="56" y2="84" stroke="#9ca3af" stroke-width="2"/>
  <line x1="56" y1="84" x2="78" y2="84" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="84" x2="96" y2="71" stroke="#9ca3af" stroke-width="2"/>
  <text x="98" y="69" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="78" y1="84" x2="78" y2="99" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="62" y="110" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Phénylalanine (F)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000028', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="28" font-size="11" fill="#f0a500" font-family="monospace">HO</text>
  <line x1="27" y1="24" x2="37" y2="24" stroke="#9ca3af" stroke-width="1.5"/>
  <polygon points="37,16 53,8 69,16 69,32 53,40 37,32" fill="none" stroke="#4f9cf9" stroke-width="2"/>
  <line x1="53" y1="40" x2="53" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <line x1="53" y1="57" x2="75" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <line x1="75" y1="57" x2="91" y2="44" stroke="#9ca3af" stroke-width="2"/>
  <text x="93" y="42" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="75" y1="57" x2="75" y2="74" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="59" y="88" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="110" font-size="10" fill="#6b7a99" font-family="monospace">Phénol (benzène + OH)</text>
</svg>
Tyrosine (Y)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000028', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="12,65 28,43 50,43 58,65 50,80 28,80" fill="none" stroke="#4f9cf9" stroke-width="1.8"/>
  <polygon points="50,43 70,31 84,43 84,65 70,77 58,65" fill="none" stroke="#4f9cf9" stroke-width="1.6"/>
  <text x="32" y="62" font-size="9" fill="#9ca3af" font-family="monospace">NH</text>
  <line x1="84" y1="54" x2="106" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="54" x2="123" y2="64" stroke="#9ca3af" stroke-width="2"/>
  <text x="125" y="63" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="54" x2="106" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="89" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Indole (bicyclique)</text>
</svg>
Tryptophane (W)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000028', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#f0a500" font-family="monospace">HO</text>
  <line x1="34" y1="60" x2="58" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="58" y1="60" x2="74" y2="46" stroke="#9ca3af" stroke-width="2"/>
  <line x1="74" y1="46" x2="90" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="92" y="44" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="74" y1="46" x2="74" y2="73" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="60" y="87" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="20" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –CH₂–OH</text>
</svg>
Sérine (S)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000029', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="36,32 56,20 76,32 76,56 56,68 36,56" fill="none" stroke="#4f9cf9" stroke-width="2"/>
  <line x1="56" y1="68" x2="56" y2="84" stroke="#9ca3af" stroke-width="2"/>
  <line x1="56" y1="84" x2="78" y2="84" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="84" x2="96" y2="71" stroke="#9ca3af" stroke-width="2"/>
  <text x="98" y="69" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="78" y1="84" x2="78" y2="99" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="62" y="110" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
</svg>
Phénylalanine (F)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000029', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="22,65 36,42 58,42 66,65 48,78" fill="none" stroke="#a78bfa" stroke-width="2"/>
  <text x="24" y="60" font-size="9" fill="#9ca3af" font-family="monospace">N</text>
  <text x="50" y="45" font-size="9" fill="#a78bfa" font-family="monospace">NH</text>
  <line x1="66" y1="63" x2="88" y2="63" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="63" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="48" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="63" x2="88" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Imidazole</text>
</svg>
Histidine (H)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000029', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="28" font-size="11" fill="#f0a500" font-family="monospace">HO</text>
  <line x1="27" y1="24" x2="37" y2="24" stroke="#9ca3af" stroke-width="1.5"/>
  <polygon points="37,16 53,8 69,16 69,32 53,40 37,32" fill="none" stroke="#4f9cf9" stroke-width="2"/>
  <line x1="53" y1="40" x2="53" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <line x1="53" y1="57" x2="75" y2="57" stroke="#9ca3af" stroke-width="2"/>
  <line x1="75" y1="57" x2="91" y2="44" stroke="#9ca3af" stroke-width="2"/>
  <text x="93" y="42" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="75" y1="57" x2="75" y2="74" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="59" y="88" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="110" font-size="10" fill="#6b7a99" font-family="monospace">Phénol (benzène + OH)</text>
</svg>
Tyrosine (Y)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000029', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="12,65 28,43 50,43 58,65 50,80 28,80" fill="none" stroke="#4f9cf9" stroke-width="1.8"/>
  <polygon points="50,43 70,31 84,43 84,65 70,77 58,65" fill="none" stroke="#4f9cf9" stroke-width="1.6"/>
  <text x="32" y="62" font-size="9" fill="#9ca3af" font-family="monospace">NH</text>
  <line x1="84" y1="54" x2="106" y2="54" stroke="#9ca3af" stroke-width="2"/>
  <line x1="106" y1="54" x2="123" y2="64" stroke="#9ca3af" stroke-width="2"/>
  <text x="125" y="63" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="106" y1="54" x2="106" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="89" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Indole (bicyclique)</text>
</svg>
Tryptophane (W)', true, 4),
  ('cccccccc-cccc-cccc-cccc-000000000030', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="22,65 36,42 58,42 66,65 48,78" fill="none" stroke="#a78bfa" stroke-width="2"/>
  <text x="24" y="60" font-size="9" fill="#9ca3af" font-family="monospace">N</text>
  <text x="50" y="45" font-size="9" fill="#a78bfa" font-family="monospace">NH</text>
  <line x1="66" y1="63" x2="88" y2="63" stroke="#9ca3af" stroke-width="2"/>
  <line x1="88" y1="63" x2="104" y2="50" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="48" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="88" y1="63" x2="88" y2="80" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="74" y="94" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="112" font-size="10" fill="#6b7a99" font-family="monospace">Imidazole</text>
</svg>
Histidine (H)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000030', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <polygon points="44,78 32,54 54,38 76,54 70,78" fill="none" stroke="#a78bfa" stroke-width="2.2"/>
  <text x="46" y="54" font-size="10" fill="#a78bfa" font-family="monospace" font-weight="bold">N</text>
  <line x1="70" y1="78" x2="70" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="70" y1="60" x2="98" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="98" y1="60" x2="116" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <text x="118" y="45" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <text x="10" y="108" font-size="10" fill="#6b7a99" font-family="monospace">Cycle pyrrolidine (iminé)</text>
</svg>
Proline (P)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000030', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="10" y="65" font-size="13" fill="#4f9cf9" font-family="monospace">H₃C</text>
  <line x1="44" y1="60" x2="72" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="72" y="56" font-size="11" fill="#9ca3af" font-family="monospace">C</text>
  <text x="76" y="50" font-size="10" fill="#9ca3af" font-family="monospace">H</text>
  <line x1="84" y1="60" x2="112" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="114" y="65" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <text x="72" y="80" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <line x1="80" y1="65" x2="80" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
</svg>
Alanine (A)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000030', '<svg viewBox="0 0 200 120" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="120" fill="#181d2e" rx="8"/>
  <text x="5" y="65" font-size="11" fill="#f0a500" font-family="monospace">H₂N</text>
  <line x1="34" y1="60" x2="50" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="50" y1="60" x2="64" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="64" y1="47" x2="78" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <line x1="78" y1="60" x2="92" y2="47" stroke="#9ca3af" stroke-width="2"/>
  <line x1="92" y1="47" x2="106" y2="60" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="47" font-size="11" fill="#9ca3af" font-family="monospace">COOH</text>
  <line x1="92" y1="47" x2="92" y2="75" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="78" y="89" font-size="11" fill="#4f9cf9" font-family="monospace">NH₂</text>
  <text x="5" y="108" font-size="10" fill="#6b7a99" font-family="monospace">R = –(CH₂)₄–NH₂</text>
</svg>
Lysine (K)', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000031', 'a) Aliphatiques (R = C,H)', true, 1),
  ('cccccccc-cccc-cccc-cccc-000000000031', 'b) Hydroxylés (–OH)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000031', 'c) Soufrés (S)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000031', 'd) Aromatiques', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000032', 'a) Aliphatiques', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000032', 'b) Hydroxylés (R = –OH)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000032', 'c) Soufrés', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000032', 'f) Aromatiques', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000033', 'a) Aliphatiques', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000033', 'b) Hydroxylés', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000033', 'c) Soufrés (R = S)', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000033', 'e) Basiques', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000034', 'e) Basiques (+)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000034', 'f) Aromatiques', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000034', 'd) Acides / dérivés amides', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000034', 'a) Aliphatiques', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000035', 'a) Aliphatiques', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000035', 'e) Basiques (R = dérivé –NH₂)', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000035', 'd) Acides', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000035', 'c) Soufrés', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000036', 'a) Aliphatiques', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000036', 'b) Hydroxylés', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000036', 'e) Basiques', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000036', 'f) Aromatiques (noyau aromatique)', true, 4),
  ('cccccccc-cccc-cccc-cccc-000000000037', 'Un amine primaire libre –NH₂', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000037', 'Intégré dans un cycle (pyrrolidine) — acide iminé', true, 2),
  ('cccccccc-cccc-cccc-cccc-000000000037', 'Lié à un noyau aromatique', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000037', 'Porteur d''un groupement guanidyle', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000038', 'Valine', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000038', 'Lysine', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000038', 'Sérine', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000038', 'Tryptophane', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000039', 'Aliphatiques', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000039', 'Soufrés', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000039', 'Aromatiques', true, 3),
  ('cccccccc-cccc-cccc-cccc-000000000039', 'Basiques', false, 4),
  ('cccccccc-cccc-cccc-cccc-000000000040', 'Aliphatiques (Val, Leu)', false, 1),
  ('cccccccc-cccc-cccc-cccc-000000000040', 'Basiques (Lys, Arg)', false, 2),
  ('cccccccc-cccc-cccc-cccc-000000000040', 'Soufrés (Cys, Met)', false, 3),
  ('cccccccc-cccc-cccc-cccc-000000000040', 'Aromatiques (Phe, Tyr, Trp)', true, 4)
on conflict (question_id, option_order) do update set
  option_text = excluded.option_text,
  is_correct = excluded.is_correct;
