-- Quiz importes depuis le dossier module (hors proteines deja seed).

insert into levels (id, title, description, level_order, is_paid, passing_score, part_id)
values
  ('11111111-2222-3333-4444-000000000001', 'Biochimie - Glucides : QCM cours', 'Definitions, classification, proprietes et reactions des glucides.', 8, false, 70, (select id from module_parts where slug = 'glucides')),
  ('11111111-2222-3333-4444-000000000002', 'Biochimie - Glucides : structures', 'Identifier les structures des oses et osides.', 9, false, 70, (select id from module_parts where slug = 'glucides')),
  ('11111111-2222-3333-4444-000000000003', 'Biochimie - Glucides : classification', 'Classer les glucides et reconnaitre leurs proprietes.', 10, true, 70, (select id from module_parts where slug = 'glucides')),
  ('22222222-3333-4444-5555-000000000001', 'Biochimie - Lipides : QCM cours', 'Definitions, acides gras, phospholipides et proprietes des lipides.', 11, false, 70, (select id from module_parts where slug = 'lipides')),
  ('22222222-3333-4444-5555-000000000002', 'Biochimie - Lipides : structures', 'Identifier les structures des lipides et acides gras.', 12, false, 70, (select id from module_parts where slug = 'lipides')),
  ('22222222-3333-4444-5555-000000000003', 'Biochimie - Lipides : classification', 'Classer les lipides et reconnaitre leurs proprietes.', 13, true, 70, (select id from module_parts where slug = 'lipides')),
  ('33333333-4444-5555-6666-000000000001', 'Anatomie - Cardio : questions courtes', 'Questions et reponses de base extraites de cardio.doc.', 14, false, 70, (select id from module_parts where slug = 'cardio')),
  ('33333333-4444-5555-6666-000000000002', 'Anatomie - Cardio : physiologie cardiovasculaire', 'Questions et reponses extraites de cardio2.doc.', 15, true, 70, (select id from module_parts where slug = 'cardio')),
  ('44444444-5555-6666-7777-000000000001', 'Anatomie - Respiration : QCM', 'QCM respiration extraits de respiration.doc.', 16, false, 70, (select id from module_parts where slug = 'respiration'))
on conflict (id) do update set
  title = excluded.title,
  description = excluded.description,
  level_order = excluded.level_order,
  is_paid = excluded.is_paid,
  passing_score = excluded.passing_score,
  part_id = excluded.part_id;

insert into questions (id, level_id, type, question_text, image_url, explanation, points)
values
  ('10000000-0000-0000-0000-000000000001', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'Les glucides sont des molÃ©cules organiques dÃ©finies comme :', null, 'Les glucides sont des molÃ©cules organiques possÃ©dant des fonctions alcools (â€“OH) et une fonction carbonylique rÃ©ductrice (aldÃ©hyde ou cÃ©tone). Formule gÃ©nÃ©rale : (CHâ‚‚O)n.', 1),
  ('10000000-0000-0000-0000-000000000002', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'L''oxydation complÃ¨te d''une molÃ©cule de glucose produit :', null, 'L''oxydation complÃ¨te du glucose par la glycolyse + cycle de Krebs + phosphorylation oxydative produit environ 38 ATP, soit â‰ˆ 380 kcal/mol. Le glucose est le carburant principal des cellules.', 1),
  ('10000000-0000-0000-0000-000000000003', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'Un ose possÃ©dant 5 atomes de carbone est appelÃ© :', null, 'La nomenclature est basÃ©e sur le nombre de carbones : 3C = triose, 4C = tÃ©trose, 5C = pentose, 6C = hexose. Le D-ribose et le D-dÃ©soxyribose sont les pentoses les plus importants biologiquement (ARN, ADN).', 1),
  ('10000000-0000-0000-0000-000000000004', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'Quelle est la diffÃ©rence entre un aldose et un cÃ©tose ?', null, 'Les aldoses possÃ¨dent une fonction aldÃ©hyde (CHO) en C1 (ex. glucose), tandis que les cÃ©toses possÃ¨dent une fonction cÃ©tone (C=O) en C2 (ex. fructose).', 1),
  ('10000000-0000-0000-0000-000000000005', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'Le D-glucose et le D-galactose sont des :', null, 'Le D-glucose et le D-galactose ne diffÃ¨rent que par la configuration du carbone 4 â†’ ce sont des Ã©pimÃ¨res en C4. Les Ã©pimÃ¨res ne diffÃ¨rent que par la configuration d''un seul carbone asymÃ©trique.', 1),
  ('10000000-0000-0000-0000-000000000006', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'Dans la convention de Fischer, la sÃ©rie D ou L est dÃ©finie par :', null, 'La sÃ©rie D ou L est dÃ©terminÃ©e par la configuration du C* le plus proche du CHâ‚‚OH (le dernier C asymÃ©trique dans la chaÃ®ne de Fischer). D = OH Ã  droite, L = OH Ã  gauche. La plupart des glucides biologiques sont de sÃ©rie D.', 1),
  ('10000000-0000-0000-0000-000000000007', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'Le phÃ©nomÃ¨ne de mutarotation du glucose aboutit Ã  une valeur stable de :', null, 'La mutarotation correspond Ã  l''Ã©quilibre entre les anomÃ¨res Î± (PR = +112,2Â°) et Î² (PR = +18,7Â°) du D-glucose en solution. La valeur stable Ã  l''Ã©quilibre est +52,7Â°, caractÃ©ristique du mÃ©lange des deux anomÃ¨res.', 1),
  ('10000000-0000-0000-0000-000000000008', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'La cyclisation du D-glucose selon Tollens forme un pont oxydique entre :', null, 'Le D-glucose cyclise prÃ©fÃ©rentiellement entre C1 et C5, formant un cycle Ã  6 chaÃ®nons (1O + 5C) analogue au pyrane â†’ glucopyranose. La cyclisation C1-C4 formerait un furanose (cycle Ã  5 chaÃ®nons).', 1),
  ('10000000-0000-0000-0000-000000000009', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'En reprÃ©sentation de Haworth, l''anomÃ¨re Î±-D-glucose se caractÃ©rise par :', null, 'En reprÃ©sentation de Haworth : anomÃ¨re Î± = OH du C1 en position trans par rapport au CHâ‚‚OH (vers le bas). AnomÃ¨re Î² = OH du C1 en position cis (vers le haut). En Fischer : Î± = OH du C1 du mÃªme cÃ´tÃ© que le dernier OH.', 1),
  ('10000000-0000-0000-0000-000000000010', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'La liqueur de Fehling permet de dÃ©tecter les oses rÃ©ducteurs car elle :', null, 'Les oses rÃ©ducteurs (OH anomÃ©rique libre) rÃ©duisent les ions CuÂ²âº de la liqueur de Fehling en Cuâº, formant un prÃ©cipitÃ© rouge brique de Cuâ‚‚O. Les osides non rÃ©ducteurs (ex. saccharose) ne rÃ©agissent pas.', 1),
  ('10000000-0000-0000-0000-000000000011', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'Les dÃ©soxyoses sont des oses qui ont :', null, 'Les dÃ©soxyoses ont perdu un atome d''oxygÃ¨ne : un â€“OH est remplacÃ© par â€“H. Exemples : le 2-dÃ©soxyribose (OH en C2 â†’ H, constituant de l''ADN) et le L-fucose (dÃ©soxyose en C6 du galactose).', 1),
  ('10000000-0000-0000-0000-000000000012', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'L''acide D-glucuronique est obtenu Ã  partir du D-glucose par :', null, 'Les acides uroniques sont produits par l''oxydation sÃ©lective de la fonction alcool primaire (C6) en â€“COOH par KMnOâ‚„, aprÃ¨s blocage de la fonction carbonyle. L''acide glucuronique est un constituant des glycosaminoglycanes.', 1),
  ('10000000-0000-0000-0000-000000000013', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'La liaison osidique est rompue par :', null, 'La liaison osidique peut Ãªtre rompue par : (1) voie chimique : HCl diluÃ© Ã  chaud, ou (2) voie enzymatique : glycosidases (osidases) spÃ©cifiques Ã  l''ose et Ã  l''anomÃ©rie (ex. Î±-glucosidase, Î²-galactosidase).', 1),
  ('10000000-0000-0000-0000-000000000014', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'La cellulose, constituant structural des vÃ©gÃ©taux, est composÃ©e de :', null, 'La cellulose est un polymÃ¨re linÃ©aire de D-glucose en liaisons Î²(1â†’4). Ces liaisons Î² permettent des interactions entre chaÃ®nes par liaisons hydrogÃ¨ne, confÃ©rant rigiditÃ© et rÃ©sistance Ã  la paroi vÃ©gÃ©tale. L''humain ne peut pas la digÃ©rer (pas de Î²-glucosidase intestinale).', 1),
  ('10000000-0000-0000-0000-000000000015', '11111111-2222-3333-4444-000000000001', 'qcm_single', 'La synthÃ¨se de Kiliani permet d''obtenir :', null, 'La synthÃ¨se de Kiliani allonge la chaÃ®ne carbonÃ©e d''un carbone, partant du D-glycÃ©raldÃ©hyde pour obtenir les aldoses supÃ©rieurs (tÃ©trose â†’ pentose â†’ hexose) en 3 Ã©tapes : addition de HCN, hydratation, rÃ©duction. Elle conserve le C* initial intact.', 1),
  ('10000000-0000-0000-0000-000000000016', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le D-Glucose en reprÃ©sentation de Fischer â€” aldohexose, CHO en C1, OH Ã  droite en C5 (sÃ©rie D) :', null, 'Le D-glucose est un aldohexose : CHO en C1, puis Hâ€“Câ€“OH / HOâ€“Câ€“H / Hâ€“Câ€“OH / Hâ€“Câ€“OH (OH Ã  droite en C5 = sÃ©rie D). C''est l''ose le plus abondant, combustible universel des cellules, PR = +52,7Â°.', 1),
  ('10000000-0000-0000-0000-000000000017', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le D-Fructose â€” cÃ©tohexose avec C=O en C2 et CHâ‚‚OH en C1 :', null, 'Le D-fructose (lÃ©vulose) est un cÃ©tohexose : CHâ‚‚OH en C1, C=O en C2, puis chaÃ®ne d''alcools. PR = âˆ’93Â° (lÃ©vogyre). TrÃ¨s abondant dans les fruits et le miel. IsomÃ¨re de fonction du glucose.', 1),
  ('10000000-0000-0000-0000-000000000018', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le D-Ribose â€” aldopentose Ã  5 carbones, tous les OH Ã  droite :', null, 'Le D-ribose est un aldopentose (5C) : CHO en C1, tous les OH Ã  droite, CHâ‚‚OH en C5 (sÃ©rie D). Il entre dans la structure des acides nuclÃ©iques (ARN) et de nombreuses coenzymes (NAD, FAD, ATP).', 1),
  ('10000000-0000-0000-0000-000000000019', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le D-Galactose â€” Ã©pimÃ¨re du glucose en C4 (OH en C4 Ã  gauche dans Fischer) :', null, 'Le D-galactose est l''Ã©pimÃ¨re du glucose en C4 : OH en C4 est Ã  gauche (HOâ€“Câ€“H) dans la projection de Fischer. PR = +80Â°. Peu rÃ©pandu Ã  l''Ã©tat libre, trÃ¨s abondant dans les osides (lactose) et les lipides complexes.', 1),
  ('10000000-0000-0000-0000-000000000020', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez l''Î±-D-glucopyranose en reprÃ©sentation de Haworth â€” OH en C1 trans par rapport Ã  CHâ‚‚OH :', null, 'L''Î±-D-glucopyranose : le OH du C1 est en position trans (opposÃ©e) par rapport au CHâ‚‚OH dans la reprÃ©sentation de Haworth (vers le bas). PR = +112,2Â°. Le prÃ©fixe ''pyranose'' indique le cycle Ã  6 chaÃ®nons (analogue au pyrane).', 1),
  ('10000000-0000-0000-0000-000000000021', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le Î²-D-glucopyranose â€” OH en C1 cis par rapport Ã  CHâ‚‚OH :', null, 'Le Î²-D-glucopyranose : le OH du C1 est en position cis par rapport au CHâ‚‚OH dans Haworth (vers le haut). PR = +18,7Â°. Forme la plus stable (tous les substituants en position Ã©quatoriale dans la conformation chaise). Constituant de la cellulose.', 1),
  ('10000000-0000-0000-0000-000000000022', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez l''Î±-D-fructofuranose â€” cycle Ã  5 chaÃ®nons (pont oxydique C2â€“C5) :', null, 'Le D-fructofuranose se forme par un pont oxydique entre C2 et C5, donnant un cycle Ã  5 chaÃ®nons (1O + 4C), analogue au furane. Dans le saccharose, le fructose est sous forme Î²-D-fructofuranose.', 1),
  ('10000000-0000-0000-0000-000000000023', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le Maltose â€” diholoside rÃ©ducteur formÃ© de 2 glucoses en Î±(1â†’4) :', null, 'Le maltose est un diholoside rÃ©ducteur (OH anomÃ©rique libre sur le 2e glucose) composÃ© de 2 D-glucose en liaison Î±(1â†’4). Produit intermÃ©diaire de l''hydrolyse de l''amidon et du glycogÃ¨ne. Absent Ã  l''Ã©tat libre.', 1),
  ('10000000-0000-0000-0000-000000000024', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le Saccharose â€” diholoside NON rÃ©ducteur, liaison Î±(1â†’2)Î² entre glucose et fructose :', null, 'Le saccharose (sucre de table) est non rÃ©ducteur car la liaison Î±(1â†’2)Î² engage les deux OH anomÃ©riques (C1 du glucose et C2 du fructose). Il ne rÃ©agit donc pas avec la liqueur de Fehling. HydrolysÃ© par la saccharase/invertase.', 1),
  ('10000000-0000-0000-0000-000000000025', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le Lactose â€” sucre du lait, Î²(1â†’4) entre galactose et glucose :', null, 'Le lactose (sucre du lait) est formÃ© de Î²-D-galactose et D-glucose en liaison Î²(1â†’4). RÃ©ducteur (OH anomÃ©rique du glucose libre). HydrolysÃ© par la Î²-galactosidase (lactase). IntolÃ©rance = dÃ©ficit en lactase.', 1),
  ('10000000-0000-0000-0000-000000000026', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez l''Amylose â€” fraction de l''amidon Ã  chaÃ®ne linÃ©aire Î±(1â†’4) :', null, 'L''amylose est la fraction linÃ©aire de l''amidon : chaÃ®ne de D-glucose en liaisons Î±(1â†’4), prenant une conformation hÃ©licoÃ¯dale. Se colore en bleu-violet avec l''iode. La fraction ramifiÃ©e est l''amylopectine (Î±1â†’4 + Î±1â†’6).', 1),
  ('10000000-0000-0000-0000-000000000027', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez la Cellulose â€” polymÃ¨re structurel vÃ©gÃ©tal Ã  liaisons Î²(1â†’4) rigides :', null, 'La cellulose est un polymÃ¨re linÃ©aire de D-glucose en liaisons Î²(1â†’4). Ces liaisons permettent la formation de liaisons hydrogÃ¨ne inter-chaÃ®nes, donnant une structure fibreuse trÃ¨s rÃ©sistante (paroi vÃ©gÃ©tale). Non digestible par l''humain.', 1),
  ('10000000-0000-0000-0000-000000000028', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez l''Acide D-Glucuronique â€” ose avec COOH en C6 au lieu de CHâ‚‚OH :', null, 'L''acide D-glucuronique est dÃ©rivÃ© du glucose par oxydation sÃ©lective du CHâ‚‚OH (C6) en â€“COOâ» par KMnOâ‚„. Il entre dans la composition des glycosaminoglycanes (acide hyaluronique, hÃ©parane sulfateâ€¦).', 1),
  ('10000000-0000-0000-0000-000000000029', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez la D-Glucosamine â€” ose aminÃ© avec NHâ‚‚ en C2 :', null, 'La D-glucosamine est un ose aminÃ© : le OH en C2 est remplacÃ© par un groupement â€“NHâ‚‚. Souvent acÃ©tylÃ©e (N-acÃ©tyl-glucosamine), c''est un constituant majeur des glycoprotÃ©ines et des glycosaminoglycanes (chitine, hÃ©parane sulfate).', 1),
  ('10000000-0000-0000-0000-000000000030', '11111111-2222-3333-4444-000000000002', 'qcm_single', 'Identifiez le 2-DÃ©soxyribose â€” pentose de l''ADN, OH en C2 remplacÃ© par H :', null, 'Le 2-dÃ©soxyribose est le pentose constitutif de l''ADN : le OH en C2 est remplacÃ© par un atome d''hydrogÃ¨ne (d''oÃ¹ ''dÃ©soxy''). Ceci rend l''ADN plus stable chimiquement que l''ARN (qui utilise le ribose avec un OH en C2).', 1),
  ('10000000-0000-0000-0000-000000000031', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'Le saccharose, le maltose et le lactose appartiennent Ã  la catÃ©gorie des :', null, 'Le saccharose, le maltose et le lactose sont des diholosides, donc des oligosides (2â€“10 unitÃ©s d''oses liÃ©es). Les oligosides sont des holosides (uniquement des oses) hydrolysables. Les polyosides ont >10 unitÃ©s.', 1),
  ('10000000-0000-0000-0000-000000000032', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'Le D-glucose, le D-galactose et le D-mannose sont tous des :', null, 'Le glucose, le galactose et le mannose sont des aldohexoses : 6 carbones (hexose) avec une fonction carbonylique de type aldÃ©hyde (CHO) en C1. Ce sont des stÃ©rÃ©oisomÃ¨res (mÃªme formule brute Câ‚†Hâ‚â‚‚Oâ‚†, mais configurations diffÃ©rentes).', 1),
  ('10000000-0000-0000-0000-000000000033', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'Parmi ces glucides, lequel N''EST PAS rÃ©ducteur ?', null, 'Le saccharose est non rÃ©ducteur car la liaison Î±(1â†’2)Î² engage les deux carbones anomÃ©riques (C1 du glucose et C2 du fructose) â†’ aucun OH anomÃ©rique libre â†’ ne peut pas passer en forme ouverte â†’ ne rÃ©agit pas avec Fehling. Les autres ont un OH anomÃ©rique libre.', 1),
  ('10000000-0000-0000-0000-000000000034', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'L''amidon (chez les vÃ©gÃ©taux) et le glycogÃ¨ne (chez les animaux) sont tous deux des :', null, 'L''amidon et le glycogÃ¨ne sont tous deux des homopolysaccharides de D-glucose avec des liaisons Î±(1â†’4) en chaÃ®ne principale et des branchements Î±(1â†’6). Le glycogÃ¨ne est plus ramifiÃ© que l''amylopectine. Ce sont les formes de rÃ©serve glucidique.', 1),
  ('10000000-0000-0000-0000-000000000035', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'La cellulose (vÃ©gÃ©taux) et la chitine (arthropodes) jouent principalement un rÃ´le :', null, 'La cellulose (paroi vÃ©gÃ©tale) et la chitine (exosquelette des arthropodes, paroi des champignons) jouent un rÃ´le structural. La chitine est composÃ©e de N-acÃ©tyl-glucosamine en liaisons Î²(1â†’4). Ces polysaccharides confÃ¨rent rigiditÃ© et rÃ©sistance.', 1),
  ('10000000-0000-0000-0000-000000000036', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'L''oxydation douce du D-glucose par Brâ‚‚ (ou Iâ‚‚) produit :', null, 'L''oxydation douce par Brâ‚‚ ou Iâ‚‚ oxyde sÃ©lectivement la fonction aldÃ©hyde (C1) en â€“COOH â†’ acide D-gluconique (acide aldonique). L''oxydation forte par HNOâ‚ƒ oxyde en plus l''alcool primaire (C6) â†’ acide aldarique (acide glucarique).', 1),
  ('10000000-0000-0000-0000-000000000037', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'La rÃ©duction du D-glucose par NaBHâ‚„ (ou LiBHâ‚„) donne :', null, 'La rÃ©duction de la fonction aldÃ©hyde du D-glucose par NaBHâ‚„ ou LiBHâ‚„ produit le D-sorbitol (alcool IÂ°, polyalcool). La rÃ©duction du D-fructose donne un mÃ©lange de D-sorbitol et de D-mannitol (car un nouveau C* est crÃ©Ã© en C2).', 1),
  ('10000000-0000-0000-0000-000000000038', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'L''acide hyaluronique et l''hÃ©parine sont des exemples de :', null, 'L''acide hyaluronique et l''hÃ©parine sont des glycosaminoglycanes (GAG) : ce sont des polysaccharides hÃ©tÃ©rogÃ¨nes formÃ©s par polycondensation alternÃ©e d''osamines (N-acÃ©tyl-glucosamineâ€¦) et d''acides uroniques (acide glucuroniqueâ€¦).', 1),
  ('10000000-0000-0000-0000-000000000039', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'L''acide pÃ©riodique (HIOâ‚„) est un oxydant puissant qui :', null, 'L''acide pÃ©riodique (HIOâ‚„) coupe de faÃ§on spÃ©cifique la liaison Câ€“C entre deux carbones adjacents porteurs de â€“OH libres (1,2-diol). Il libÃ¨re des aldÃ©hydes, de l''acide formique (â€“CHâ‚‚OH terminal), et permet de dÃ©terminer la structure des oses cycliques.', 1),
  ('10000000-0000-0000-0000-000000000040', '11111111-2222-3333-4444-000000000003', 'qcm_single', 'Le D-galactose et le L-galactose sont des :', null, 'Le D-galactose et le L-galactose sont des Ã©nantiomÃ¨res : ils sont images l''un de l''autre dans un miroir et non superposables (comme les mains droite et gauche). Tous leurs C* ont des configurations inversÃ©es. Ils ont les mÃªmes propriÃ©tÃ©s physico-chimiques mais des pouvoirs rotatoires de signes opposÃ©s.', 1),
  ('20000000-0000-0000-0000-000000000001', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Quelle propriÃ©tÃ© physique est caractÃ©ristique de TOUS les lipides ?', null, 'Les lipides sont des composÃ©s apolaires, insolubles dans l''eau mais solubles dans les solvants organiques (Ã©ther, chloroforme, benzÃ¨ne, acÃ©tone). C''est la propriÃ©tÃ© physique qui les dÃ©finit tous.', 1),
  ('20000000-0000-0000-0000-000000000002', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Parmi ces lipides, lequel appartient aux lipides SIMPLES (homolipides) ?', null, 'Les glycÃ©rides (monoglycÃ©rides, diglycÃ©rides, triglycÃ©rides) sont des lipides simples ou homolipides, car leur hydrolyse ne libÃ¨re que des acides gras et du glycÃ©rol. Les glycÃ©rophospholipides et sphingolipides sont des lipides composÃ©s ou hÃ©tÃ©rolipides.', 1),
  ('20000000-0000-0000-0000-000000000003', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Quelle est la formule gÃ©nÃ©rale d''un acide gras saturÃ© ?', null, 'Un acide gras saturÃ© rÃ©pond Ã  la formule CHâ‚ƒâ€“(CHâ‚‚)nâ€“COOH. La chaÃ®ne est linÃ©aire, sans double liaison, avec un nombre pair d''atomes de carbone. L''acide gras le plus petit des lipides est l''acide butyrique (C4).', 1),
  ('20000000-0000-0000-0000-000000000004', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'L''acide olÃ©ique est un acide gras en C18 avec une double liaison en position 9. Sa notation correcte est :', null, 'L''acide olÃ©ique est notÃ© C18:1 Î”9 : 18 carbones, 1 double liaison, en position 9. C''est un acide gras monoinsaturÃ©. Le C18:2 Î”9,12 est l''acide linolÃ©ique et le C20:4 est l''acide arachidonique.', 1),
  ('20000000-0000-0000-0000-000000000005', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Pourquoi l''huile est-elle liquide Ã  tempÃ©rature ambiante contrairement au beurre ?', null, 'L''huile est riche en acides gras insaturÃ©s (olÃ©ique, linolÃ©ique). Plus un acide gras est insaturÃ©, plus son point de fusion est bas. Les doubles liaisons crÃ©ent des coudes dans la chaÃ®ne qui empÃªchent le tassement des molÃ©cules, abaissant le point de fusion. Le beurre, riche en AG saturÃ©s, est solide.', 1),
  ('20000000-0000-0000-0000-000000000006', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Qu''est-ce que l''indice de saponification (Is) ?', null, 'L''indice de saponification (Is) est dÃ©fini comme la quantitÃ© en mg de potasse (KOH) qui saponifie 1 g de matiÃ¨re grasse. Il permet de dÃ©terminer la masse molÃ©culaire moyenne des acides gras d''un corps gras. Plus les AG sont courts, plus l''Is est Ã©levÃ©.', 1),
  ('20000000-0000-0000-0000-000000000007', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'L''indice d''iode (Ii) permet de mesurer :', null, 'L''indice d''iode (Ii) est la quantitÃ© en grammes d''iode fixÃ©e par 100 g de matiÃ¨re grasse. Les halogÃ¨nes (Iâ‚‚, Brâ‚‚) s''additionnent aux doubles liaisons : plus la valeur est Ã©levÃ©e, plus le lipide est insaturÃ©. C''est donc un indicateur du degrÃ© d''insaturation.', 1),
  ('20000000-0000-0000-0000-000000000008', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Dans un triglycÃ©ride, le carbone CÎ² du glycÃ©rol est dit ''asymÃ©trique''. Cela signifie :', null, 'Le CÎ² du glycÃ©rol dans un triglycÃ©ride est substituÃ© asymÃ©triquement, ce qui engendre deux isomÃ¨res possibles (isomÃ¨re I et isomÃ¨re II). Chez les organismes vivants, les triglycÃ©rides sont de type isomÃ¨re II.', 1),
  ('20000000-0000-0000-0000-000000000009', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Dans un glycÃ©rophospholipide, comment sont rÃ©partis les acides gras dans les organismes vivants ?', null, 'Dans les glycÃ©rophospholipides naturels : en CÎ± se trouve un AG saturÃ© (R1), en CÎ² se trouve un AG insaturÃ© (R2), et en CÎ±'' se trouve l''acide phosphorique liÃ© Ã  un groupement X. Cette disposition est caractÃ©ristique des membranes biologiques.', 1),
  ('20000000-0000-0000-0000-000000000010', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Quelle phospholipase coupe la liaison au niveau du CÎ² du glycÃ©rophospholipide ?', null, 'La phospholipase A2 coupe spÃ©cifiquement la liaison ester au niveau du CÎ², libÃ©rant l''acide gras insaturÃ© en position 2. La phospholipase A1 (ou B) coupe en CÎ±, la phospholipase C coupe entre le glycÃ©rol et le phosphate, et la phospholipase D coupe entre le phosphate et le groupement X.', 1),
  ('20000000-0000-0000-0000-000000000011', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Quelle est la diffÃ©rence fondamentale entre les sphingolipides et les glycÃ©rophospholipides ?', null, 'La diffÃ©rence fondamentale : les sphingolipides contiennent de la sphingosine (alcool aminÃ© Ã  longue chaÃ®ne) Ã  la place du glycÃ©rol. La sphingosine est liÃ©e Ã  un AG par une liaison amide (sur la fonction amine) et non par une liaison ester.', 1),
  ('20000000-0000-0000-0000-000000000012', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Les sphingomyÃ©lines sont particuliÃ¨rement abondantes dans :', null, 'Les sphingomyÃ©lines sont abondantes dans les neurones oÃ¹ elles constituent la gaine de myÃ©line. La gaine de myÃ©line isole les axones et permet une transmission rapide de l''influx nerveux.', 1),
  ('20000000-0000-0000-0000-000000000013', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Un galactocÃ©rÃ©broside est composÃ© de :', null, 'Un galactocÃ©rÃ©broside est formÃ© d''un cÃ©ramide liÃ© Ã  une molÃ©cule de D-galactose par une liaison Î²-glycosidique (Î² D-galactosyl(1;1) cÃ©ramide). C''est un lipide non phosphorÃ© (sans acide phosphorique). Il est prÃ©sent dans le tissu nerveux.', 1),
  ('20000000-0000-0000-0000-000000000014', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'Les terpÃ¨nes sont des lipides insaponifiables formÃ©s par polymÃ©risation d''unitÃ©s :', null, 'Les terpÃ¨nes sont des lipides insaponifiables formÃ©s par polymÃ©risation d''unitÃ©s d''isoprÃ¨ne (2-mÃ©thyl-1,3-butadiÃ¨ne, C5H8). Selon le nombre d''unitÃ©s : monoterpÃ¨nes (2 unitÃ©s, 10C), diterpÃ¨nes (4 unitÃ©s, 20C), etc. Exemples : gÃ©raniol (gÃ©ranium), menthol (menthe), carotÃ¨nes.', 1),
  ('20000000-0000-0000-0000-000000000015', '22222222-3333-4444-5555-000000000001', 'qcm_single', 'La rÃ©action de saponification d''un glycÃ©ride en milieu basique (NaOH) produit :', null, 'En milieu basique (NaOH ou KOH), un glycÃ©ride subit une saponification pour donner du glycÃ©rol et des sels d''acides gras (appelÃ©s savons). C''est le principe de la fabrication du savon. En milieu acide (Hâ‚‚SOâ‚„), on obtient du glycÃ©rol et des acides gras libres.', 1),
  ('20000000-0000-0000-0000-000000000016', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Identifiez la structure d''un acide gras SATURÃ‰ :', null, 'L''acide palmitique (C16:0) est un acide gras saturÃ© : chaÃ®ne linÃ©aire sans double liaison, formule CHâ‚ƒâ€“(CHâ‚‚)â‚â‚„â€“COOH. Il est solide Ã  tempÃ©rature ambiante. Les autres structures montrent des doubles liaisons (reprÃ©sentÃ©es par des doubles traits colorÃ©s).', 1),
  ('20000000-0000-0000-0000-000000000017', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Quelle structure correspond Ã  l''acide olÃ©ique (C18:1 Î”9) ?', null, 'L''acide olÃ©ique (C18:1 Î”9) possÃ¨de une seule double liaison en position 9 (reprÃ©sentÃ©e en bleu). Il est liquide Ã  tempÃ©rature ambiante, prÃ©sent en grande quantitÃ© dans l''huile d''olive. Formule : CHâ‚ƒâ€“(CHâ‚‚)â‚‡â€“CH=CHâ€“(CHâ‚‚)â‚‡â€“COOH.', 1),
  ('20000000-0000-0000-0000-000000000018', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Identifiez la structure d''un triglycÃ©ride (triacylglycÃ©rol) :', null, 'Un triglycÃ©ride (Î±Î²Î±'' triacylglycÃ©rol) possÃ¨de les 3 fonctions alcool du glycÃ©rol estÃ©rifiÃ©es par 3 acides gras (R1, R2, R3). Si R1=R2=R3 : triglycÃ©ride homogÃ¨ne ; si diffÃ©rents : triglycÃ©ride hÃ©tÃ©rogÃ¨ne. Ce sont les lipides de rÃ©serve Ã©nergÃ©tique.', 1),
  ('20000000-0000-0000-0000-000000000019', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Quel schÃ©ma reprÃ©sente un monoglycÃ©ride ?', null, 'Un monoglycÃ©ride (Î±-monoacylglycÃ©rol) rÃ©sulte de l''estÃ©rification d''une seule des 3 fonctions alcool du glycÃ©rol par un acide gras. Les 2 autres fonctions â€“OH restent libres. Il existe aussi des Î²-monoglycÃ©rides.', 1),
  ('20000000-0000-0000-0000-000000000020', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Quelle structure correspond Ã  un glycÃ©rophospholipide ?', null, 'Un glycÃ©rophospholipide est formÃ© d''un glycÃ©rol estÃ©rifiÃ© par 2 AG (en CÎ± et CÎ²) et par l''acide phosphorique (en CÎ±'') liÃ© Ã  un groupement X. Il possÃ¨de un pÃ´le hydrophobe (chaÃ®nes AG) et un pÃ´le hydrophile (tÃªte phosphate+X), ce qui lui confÃ¨re son caractÃ¨re amphiphile.', 1),
  ('20000000-0000-0000-0000-000000000021', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Identifiez la structure de la sphingomyÃ©line :', null, 'La sphingomyÃ©line est formÃ©e d''une sphingosine liÃ©e Ã  un AG par une liaison amide (â€“NHâ€“COâ€“R), avec un groupement phosphocholine en tÃªte. Elle est abondante dans les neurones (gaine de myÃ©line). La liaison amide la distingue des glycÃ©rophospholipides (liaison ester).', 1),
  ('20000000-0000-0000-0000-000000000022', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Quelle structure reprÃ©sente une cire comme le palmitate de cÃ©tyle ?', null, 'Une cire est un ester d''un acide gras et d''un alcool aliphatique Ã  longue chaÃ®ne carbonÃ©e. Le palmitate de cÃ©tyle (Câ‚ƒâ‚€Hâ‚†â‚â€“Oâ€“COâ€“Câ‚â‚…Hâ‚ƒâ‚) constitue 92% du blanc de baleine. Les cires sont des lipides de revÃªtement (cires vÃ©gÃ©tales, cires d''abeilles, cires d''insectes).', 1),
  ('20000000-0000-0000-0000-000000000023', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Un cÃ©ramide est formÃ© par :', null, 'Un cÃ©ramide rÃ©sulte de la fixation d''un acide gras sur la fonction amine de la sphingosine par une liaison amide. C''est le prÃ©curseur commun des sphingolipides : sphingomyÃ©lines (+ phosphocholine), cÃ©rÃ©brosides (+ ose), gangliosides (+ oligosaccharides).', 1),
  ('20000000-0000-0000-0000-000000000024', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Identifiez le galactocÃ©rÃ©broside :', null, 'Le galactocÃ©rÃ©broside est formÃ© d''un cÃ©ramide liÃ© Ã  une molÃ©cule de D-galactose par une liaison Î²-glycosidique en position 1 de la sphingosine (Î² D-galactosyl(1;1) cÃ©ramide). C''est un lipide non phosphorÃ©, prÃ©sent dans le tissu nerveux.', 1),
  ('20000000-0000-0000-0000-000000000025', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'L''acide arachidonique (C20:4 Î”5,8,11,14) possÃ¨de :', null, 'L''acide arachidonique (C20:4 Î”5,8,11,14) est un acide gras polyinsaturÃ© avec 4 doubles liaisons en positions 5, 8, 11 et 14. C''est un acide gras essentiel omÃ©ga-6, prÃ©curseur des prostaglandines et des leucotriÃ¨nes.', 1),
  ('20000000-0000-0000-0000-000000000026', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Quelle structure reprÃ©sente la phosphatidylcholine (lÃ©cithine) ?', null, 'La lÃ©cithine (phosphatidylcholine) est un glycÃ©rophospholipide avec X = choline [HOCHâ‚‚CHâ‚‚â€“Nâº(CHâ‚ƒ)â‚ƒ]. Elle est trÃ¨s rÃ©pandue dans les membranes des cellules animales et peu prÃ©sente chez les bactÃ©ries. Son caractÃ¨re amphiphile lui permet de s''organiser en bicouche lipidique.', 1),
  ('20000000-0000-0000-0000-000000000027', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Quel acide gras possÃ¨de seulement 4 atomes de carbone ?', null, 'L''acide butyrique (CHâ‚ƒâ€“CHâ‚‚â€“CHâ‚‚â€“COOH) est le plus petit acide gras constitutif des lipides avec 4 atomes de carbone. Il est prÃ©sent dans le beurre et donne Ã  ce dernier son odeur caractÃ©ristique. Les AG des lipides commencent par l''acide butyrique.', 1),
  ('20000000-0000-0000-0000-000000000028', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Identifiez l''acide stÃ©arique (C18:0) :', null, 'L''acide stÃ©arique (CHâ‚ƒâ€“(CHâ‚‚)â‚â‚†â€“COOH) est un acide gras saturÃ© Ã  18 carbones (C18:0). Avec son point de fusion Ã©levÃ©, il est solide Ã  tempÃ©rature ambiante. Ne pas confondre avec l''acide olÃ©ique C18:1 (qui a une double liaison) ou l''acide linolÃ©ique C18:2.', 1),
  ('20000000-0000-0000-0000-000000000029', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Quelle structure montre un diglycÃ©ride (diacylglycÃ©rol) ?', null, 'Un diglycÃ©ride (Î±Î² ou Î±Î±'' diacylglycÃ©rol) rÃ©sulte de l''estÃ©rification de deux fonctions alcool du glycÃ©rol par 2 acides gras. La troisiÃ¨me fonction â€“OH reste libre. Si R1=R2 : diglycÃ©ride homogÃ¨ne ; si R1â‰ R2 : diglycÃ©ride hÃ©tÃ©rogÃ¨ne.', 1),
  ('20000000-0000-0000-0000-000000000030', '22222222-3333-4444-5555-000000000002', 'qcm_single', 'Identifiez l''acide linolÃ©ique (C18:2 Î”9,12), un acide gras essentiel omÃ©ga-6 :', null, 'L''acide linolÃ©ique (C18:2 Î”9,12) est un acide gras polyinsaturÃ© avec 2 doubles liaisons en positions 9 et 12. C''est un acide gras essentiel (non synthÃ©tisÃ© par l''organisme, doit Ãªtre apportÃ© par l''alimentation). Il appartient Ã  la famille omÃ©ga-6.', 1),
  ('20000000-0000-0000-0000-000000000031', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'Les cires sont classÃ©es parmi les lipides :', null, 'Les cires sont des lipides simples (homolipides) : leur hydrolyse ne libÃ¨re que des acides gras et des alcools aliphatiques Ã  longue chaÃ®ne. Elles constituent les lipides de revÃªtement (cires vÃ©gÃ©tales, cutine, cire d''abeille, blanc de baleine).', 1),
  ('20000000-0000-0000-0000-000000000032', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'Quel type de lipide constitue PRINCIPALEMENT les membranes cellulaires ?', null, 'Les membranes cellulaires sont principalement constituÃ©es de phospholipides (glycÃ©rophospholipides, sphingomyÃ©lines), de galactolipides et de sulfolipides. Leur caractÃ¨re amphiphile permet la formation de la bicouche lipidique. Les triglycÃ©rides sont les lipides de rÃ©serve Ã©nergÃ©tique.', 1),
  ('20000000-0000-0000-0000-000000000033', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'Ã€ partir de combien d''atomes de carbone un acide gras devient-il insoluble dans l''eau ?', null, 'DÃ¨s que la chaÃ®ne carbonÃ©e devient supÃ©rieure Ã  8 atomes de carbone, l''acide gras devient insoluble dans l''eau. Par contre, les acides gras sous forme de sels alcalins (savons) sont solubles dans l''eau, car la tÃªte polaire â€“COOâ» permet la solubilisation.', 1),
  ('20000000-0000-0000-0000-000000000034', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'Le rancissement des corps gras est dÃ» Ã  :', null, 'Le rancissement est causÃ© par l''oxydation spontanÃ©e des acides gras (surtout insaturÃ©s) Ã  l''air libre. Il entraÃ®ne une odeur forte et une saveur Ã¢cre dÃ©sagrÃ©ables. Les doubles liaisons sont particuliÃ¨rement sensibles Ã  l''oxydation. Les antioxydants (vitamine E) protÃ¨gent contre ce phÃ©nomÃ¨ne.', 1),
  ('20000000-0000-0000-0000-000000000035', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'La rÃ©action de transestÃ©rification (alcoolyse) d''un triglycÃ©ride avec du mÃ©thanol produit :', null, 'La transestÃ©rification (alcoolyse) d''un triglycÃ©ride avec du mÃ©thanol produit des esters mÃ©thyliques d''acides gras (EMAG) + du glycÃ©rol. Cette rÃ©action est utilisÃ©e en chromatographie en phase gazeuse pour identifier les AG. Les EMAG sont aussi produits pour le biodiesel.', 1),
  ('20000000-0000-0000-0000-000000000036', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'En chromatographie en phase gazeuse des acides gras, lequel sort le plus LENTEMENT ?', null, 'En chromatographie en phase gazeuse, les AG sortent d''autant plus lentement qu''ils ont une longue chaÃ®ne d''atomes de carbone. Ã€ nombre Ã©gal d''atomes de C, ce sont les AG insaturÃ©s qui sortent le plus lentement. La surface des pics est proportionnelle Ã  la quantitÃ© de l''AG.', 1),
  ('20000000-0000-0000-0000-000000000037', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'Les cardiolipides (diphosphatidyl glycÃ©rol) sont caractÃ©ristiques de :', null, 'Les cardiolipides (diphosphatidylglycÃ©rol, X = glycÃ©rol) sont caractÃ©ristiques des membranes bactÃ©riennes et des membranes des mitochondries cardiaques. Leur structure particuliÃ¨re avec 4 chaÃ®nes d''acides gras est essentielle au fonctionnement de la chaÃ®ne respiratoire.', 1),
  ('20000000-0000-0000-0000-000000000038', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'Les vitamines liposolubles sont des lipides de la classe des :', null, 'Les vitamines liposolubles (A, D, E, K) appartiennent Ã  la classe des terpÃ¨nes (lipides polyisoprÃ©niques). Elles sont solubles dans les graisses et les huiles, et insolubles dans l''eau. Elles se stockent dans les tissus adipeux et hÃ©patiques.', 1),
  ('20000000-0000-0000-0000-000000000039', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'Les plasmalogÃ¨nes se trouvent principalement dans :', null, 'Les plasmalogÃ¨nes sont des glycÃ©rophospholipides particuliers (avec une liaison alcÃ©noxy en CÎ± Ã  la place de la liaison ester). Ils sont prÃ©sents dans le tissu nerveux et musculaire et dans le plasma sanguin. Ils contiennent souvent de l''Ã©thanolamine et de l''acide arachidonique.', 1),
  ('20000000-0000-0000-0000-000000000040', '22222222-3333-4444-5555-000000000003', 'qcm_single', 'Les carotÃ¨nes et lycopÃ¨nes sont des terpÃ¨nes classÃ©s parmi les :', null, 'Les carotÃ¨nes (pigments jaunes-orangÃ©s de la carotte) et les lycopÃ¨nes (pigments rouges de la tomate) sont des pigments carotÃ©noÃ¯des, des terpÃ¨nes trÃ¨s riches en doubles liaisons conjuguÃ©es. Ces doubles liaisons conjuguÃ©es absorbent la lumiÃ¨re visible, leur donnant leurs couleurs caractÃ©ristiques.', 1),
  ('30000000-0000-0000-0000-000000000001', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Quel organe pompe le sang dans le corps ?', null, 'Le cÂœur.', 1),
  ('30000000-0000-0000-0000-000000000002', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Combien de cavitÃ©s possÃ¨de le cÂœur ?', null, '4 cavitÃ©s.', 1),
  ('30000000-0000-0000-0000-000000000003', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Comment sÂ’appellent les deux cavitÃ©s supÃ©rieures ?', null, 'Les oreillettes.', 1),
  ('30000000-0000-0000-0000-000000000004', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Comment sÂ’appellent les deux cavitÃ©s infÃ©rieures ?', null, 'Les ventricules.', 1),
  ('30000000-0000-0000-0000-000000000005', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Quel vaisseau transporte le sang du cÂœur vers les organes ?', null, 'Les artÃ¨res.', 1),
  ('30000000-0000-0000-0000-000000000006', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Quel vaisseau ramÃ¨ne le sang vers le cÂœur ?', null, 'Les veines.', 1),
  ('30000000-0000-0000-0000-000000000007', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Quel est le rÃ´le principal du systÃ¨me cardiovasculaire ?', null, 'Transporter lÂ’oxygÃ¨ne, les nutriments et Ã©liminer les dÃ©chets.', 1),
  ('30000000-0000-0000-0000-000000000008', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Quelle valve sÃ©pare lÂ’oreillette gauche du ventricule gauche ?', null, 'La valve mitrale.', 1),
  ('30000000-0000-0000-0000-000000000009', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Quelle est la plus grande artÃ¨re du corps ?', null, 'LÂ’aorte.', 1),
  ('30000000-0000-0000-0000-000000000010', '33333333-4444-5555-6666-000000000001', 'text_answer', 'Quel cÃ´tÃ© du cÂœur contient du sang riche en oxygÃ¨ne ?', null, 'Le cÃ´tÃ© gauche.', 1),
  ('31000000-0000-0000-0000-000000000001', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le rÃ´le principal du cÂœur ?', null, 'Le cÂœur agit comme une pompe qui propulse le sang dans tout lÂ’organisme.', 1),
  ('31000000-0000-0000-0000-000000000002', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quelles sont les deux circulations sanguines ?', null, 'La circulation pulmonaire La circulation systÃ©mique', 1),
  ('31000000-0000-0000-0000-000000000003', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quelle est la diffÃ©rence entre systole et diastole ?', null, 'Systole : contraction du cÂœur Diastole : relÃ¢chement et remplissage du cÂœur', 1),
  ('31000000-0000-0000-0000-000000000004', '33333333-4444-5555-6666-000000000002', 'text_answer', 'DÃ©finir le dÃ©bit cardiaque.', null, 'Le dÃ©bit cardiaque est le volume de sang Ã©jectÃ© par le cÂœur en une minute.', 1),
  ('31000000-0000-0000-0000-000000000005', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Donner la formule du dÃ©bit cardiaque.', null, 'DC=FCÃ—VESDC = FC \times VESDC=FCÃ—VES', 1),
  ('31000000-0000-0000-0000-000000000006', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que la frÃ©quence cardiaque ?', null, 'CÂ’est le nombre de battements du cÂœur par minute.', 1),
  ('31000000-0000-0000-0000-000000000007', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que le volume dÂ’Ã©jection systolique (VES) ?', null, 'CÂ’est la quantitÃ© de sang Ã©jectÃ©e par un ventricule Ã  chaque contraction.', 1),
  ('31000000-0000-0000-0000-000000000008', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quelle est la valeur normale de la frÃ©quence cardiaque chez lÂ’adulte ?', null, 'Entre 60 et 100 battements par minute.', 1),
  ('31000000-0000-0000-0000-000000000009', '33333333-4444-5555-6666-000000000002', 'text_answer', 'DÃ©finir la pression artÃ©rielle.', null, 'Force exercÃ©e par le sang sur la paroi des artÃ¨res.', 1),
  ('31000000-0000-0000-0000-000000000010', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quelle est la pression artÃ©rielle normale ?', null, 'Environ 120/80 mmHg.', 1),
  ('31000000-0000-0000-0000-000000000011', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que la pression systolique ?', null, 'La pression maximale lors de la contraction ventriculaire.', 1),
  ('31000000-0000-0000-0000-000000000012', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que la pression diastolique ?', null, 'La pression minimale lors du relÃ¢chement du cÂœur.', 1),
  ('31000000-0000-0000-0000-000000000013', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le rÃ´le des valves cardiaques ?', null, 'EmpÃªcher le reflux du sang.', 1),
  ('31000000-0000-0000-0000-000000000014', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Combien de cavitÃ©s possÃ¨de le cÂœur ?', null, 'Le cÂœur possÃ¨de 4 cavitÃ©s : 2 oreillettes 2 ventricules', 1),
  ('31000000-0000-0000-0000-000000000015', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le rÃ´le du ventricule gauche ?', null, 'Il envoie le sang oxygÃ©nÃ© dans tout lÂ’organisme.', 1),
  ('31000000-0000-0000-0000-000000000016', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le rÃ´le du ventricule droit ?', null, 'Il envoie le sang vers les poumons.', 1),
  ('31000000-0000-0000-0000-000000000017', '33333333-4444-5555-6666-000000000002', 'text_answer', 'DÃ©finir le retour veineux.', null, 'QuantitÃ© de sang revenant au cÂœur par les veines.', 1),
  ('31000000-0000-0000-0000-000000000018', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que lÂ’ECG ?', null, 'Enregistrement de lÂ’activitÃ© Ã©lectrique du cÂœur.', 1),
  ('31000000-0000-0000-0000-000000000019', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Que reprÃ©sente lÂ’onde P sur lÂ’ECG ?', null, 'La dÃ©polarisation des oreillettes.', 1),
  ('31000000-0000-0000-0000-000000000020', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Que reprÃ©sente le complexe QRS ?', null, 'La dÃ©polarisation des ventricules.', 1),
  ('31000000-0000-0000-0000-000000000021', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Que reprÃ©sente lÂ’onde T ?', null, 'La repolarisation ventriculaire.', 1),
  ('31000000-0000-0000-0000-000000000022', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le pacemaker naturel du cÂœur ?', null, 'Le nÂœud sinusal.', 1),
  ('31000000-0000-0000-0000-000000000023', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le rÃ´le du nÂœud auriculo-ventriculaire ?', null, 'Ralentir la conduction Ã©lectrique entre oreillettes et ventricules.', 1),
  ('31000000-0000-0000-0000-000000000024', '33333333-4444-5555-6666-000000000002', 'text_answer', 'DÃ©finir la vasodilatation.', null, 'Augmentation du diamÃ¨tre des vaisseaux sanguins.', 1),
  ('31000000-0000-0000-0000-000000000025', '33333333-4444-5555-6666-000000000002', 'text_answer', 'DÃ©finir la vasoconstriction.', null, 'Diminution du diamÃ¨tre des vaisseaux sanguins.', 1),
  ('31000000-0000-0000-0000-000000000026', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que la prÃ©charge ?', null, 'Ã‰tirement des fibres cardiaques avant la contraction.', 1),
  ('31000000-0000-0000-0000-000000000027', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que la postcharge ?', null, 'RÃ©sistance contre laquelle le ventricule Ã©jecte le sang.', 1),
  ('31000000-0000-0000-0000-000000000028', '33333333-4444-5555-6666-000000000002', 'text_answer', 'DÃ©finir la contractilitÃ©.', null, 'CapacitÃ© du muscle cardiaque Ã  se contracter.', 1),
  ('31000000-0000-0000-0000-000000000029', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que la fraction dÂ’Ã©jection ?', null, 'Pourcentage de sang Ã©jectÃ© par le ventricule gauche Ã  chaque systole.', 1),
  ('31000000-0000-0000-0000-000000000030', '33333333-4444-5555-6666-000000000002', 'text_answer', 'DÃ©finir la loi de Frank-Starling.', null, 'Plus le remplissage du cÂœur augmente, plus la force de contraction augmente.', 1),
  ('31000000-0000-0000-0000-000000000031', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que le pouls ?', null, 'Expansion rythmique des artÃ¨res due Ã  lÂ’Ã©jection sanguine.', 1),
  ('31000000-0000-0000-0000-000000000032', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le rÃ´le des artÃ¨res ?', null, 'Transporter le sang du cÂœur vers les organes.', 1),
  ('31000000-0000-0000-0000-000000000033', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le rÃ´le des veines ?', null, 'Ramener le sang vers le cÂœur.', 1),
  ('31000000-0000-0000-0000-000000000034', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel est le rÃ´le des capillaires ?', null, 'Permettre les Ã©changes entre le sang et les tissus.', 1),
  ('31000000-0000-0000-0000-000000000035', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce que lÂ’hÃ©modynamique ?', null, 'Ã‰tude des mouvements du sang dans le systÃ¨me cardiovasculaire.', 1),
  ('31000000-0000-0000-0000-000000000036', '33333333-4444-5555-6666-000000000002', 'text_answer', 'QuÂ’est-ce quÂ’un barorÃ©cepteur ?', null, 'RÃ©cepteur sensible aux variations de pression artÃ©rielle.', 1),
  ('31000000-0000-0000-0000-000000000037', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel systÃ¨me augmente la frÃ©quence cardiaque ?', null, 'Le systÃ¨me nerveux sympathique.', 1),
  ('31000000-0000-0000-0000-000000000038', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Quel systÃ¨me diminue la frÃ©quence cardiaque ?', null, 'Le systÃ¨me parasympathique.', 1),
  ('31000000-0000-0000-0000-000000000039', '33333333-4444-5555-6666-000000000002', 'text_answer', 'OÃ¹ se trouve le sang oxygÃ©nÃ© dans le cÂœur ?', null, 'Dans les cavitÃ©s gauches.', 1),
  ('31000000-0000-0000-0000-000000000040', '33333333-4444-5555-6666-000000000002', 'text_answer', 'Ou se trouve le sang pauvre en oxygene ?', null, 'Dans les cavites droites.', 1)
  ('40000000-0000-0000-0000-000000000001', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Quelle structure pulmonaire est le site principal des echanges gazeux ?', null, 'Bonne reponse : Alveoles.', 1),
  ('40000000-0000-0000-0000-000000000002', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Le surfactant pulmonaire a pour role principal :', null, 'Bonne reponse : Reduire la tension superficielle dans les alveoles.', 1),
  ('40000000-0000-0000-0000-000000000003', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Quelle cellule produit le surfactant dans les poumons ?', null, 'Bonne reponse : Pneumocyte de type II.', 1),
  ('40000000-0000-0000-0000-000000000004', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Les alveoles sont entourees de :', null, 'Bonne reponse : Capillaires pulmonaires.', 1),
  ('40000000-0000-0000-0000-000000000005', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Quel muscle est principalement responsable de l''inspiration normale ?', null, 'Bonne reponse : Diaphragme.', 1),
  ('40000000-0000-0000-0000-000000000006', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'La ventilation pulmonaire est regulee par quel centre ?', null, 'Bonne reponse : Bulbe rachidien.', 1),
  ('40000000-0000-0000-0000-000000000007', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'La plevre viscerale recouvre :', null, 'Bonne reponse : Les poumons.', 1),
  ('40000000-0000-0000-0000-000000000008', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Le dioxyde de carbone est transporte dans le sang principalement sous forme :', null, 'Bonne reponse : Sous forme de bicarbonate.', 1),
  ('40000000-0000-0000-0000-000000000009', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Le transport principal de l''O2 dans le sang se fait via :', null, 'Bonne reponse : Hemoglobine.', 1),
  ('40000000-0000-0000-0000-000000000010', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Lequel de ces gaz joue le role principal dans la stimulation de la respiration ?', null, 'Bonne reponse : Dioxyde de carbone.', 1),
  ('40000000-0000-0000-0000-000000000011', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Les macrophages alveolaires ont pour fonction principale :', null, 'Bonne reponse : Detruire les particules etrangeres.', 1),
  ('40000000-0000-0000-0000-000000000012', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Les bronchioles terminales menent directement a :', null, 'Bonne reponse : Bronchioles respiratoires.', 1),
  ('40000000-0000-0000-0000-000000000013', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Le volume pulmonaire augmente lors de :', null, 'Bonne reponse : Inspiration.', 1),
  ('40000000-0000-0000-0000-000000000014', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'L''expiration au repos est :', null, 'Bonne reponse : Passive.', 1),
  ('40000000-0000-0000-0000-000000000015', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Lequel de ces organes ne fait pas partie des voies respiratoires superieures ?', null, 'Bonne reponse : La trachee.', 1),
  ('40000000-0000-0000-0000-000000000016', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Comment appelle-t-on le volume d''air inhale ou exhale lors d''une respiration normale ?', null, 'Bonne reponse : Volume courant (VC).', 1),
  ('40000000-0000-0000-0000-000000000017', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Laquelle de ces structures contient des anneaux de cartilage en forme de C pour maintenir son ouverture ?', null, 'Bonne reponse : La trachee.', 1),
  ('40000000-0000-0000-0000-000000000018', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Qu''est-ce que l''espace mort anatomique ?', null, 'Bonne reponse : Le volume d''air dans les voies de conduction qui ne participe pas aux echanges gazeux.', 1),
  ('40000000-0000-0000-0000-000000000019', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'La diffusion de l''oxygene a travers la membrane alveolo-capillaire depend de :', null, 'Bonne reponse : La surface disponible et l''epaisseur de la membrane.', 1),
  ('40000000-0000-0000-0000-000000000020', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Quel type d epithelium tapisse la majorite des voies respiratoires superieures ?', null, 'Bonne reponse : Epithelium pseudo-stratifie cilie avec cellules caliciformes.', 1),
  ('40000000-0000-0000-0000-000000000021', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Qu''indique une deviation vers la droite de la courbe de dissociation de l''oxyhemoglobine ?', null, 'Bonne reponse : Une baisse du pH sanguin (acidose).', 1),
  ('40000000-0000-0000-0000-000000000022', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Quelle est la principale difference entre les chemorecepteurs centraux et peripheriques ?', null, 'Bonne reponse : Les peripheriques sont les seuls sensibles a une baisse directe de la PaO2.', 1),
  ('40000000-0000-0000-0000-000000000023', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'La capacite residuelle fonctionnelle (CRF) est la somme de quels volumes ?', null, 'Bonne reponse : Volume de reserve expiratoire + volume residuel.', 1),
  ('40000000-0000-0000-0000-000000000024', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Dans le modele de West, pourquoi le rapport ventilation/perfusion (V/Q) est-il plus eleve a l''apex du poumon ?', null, 'Bonne reponse : La gravite reduit massivement la perfusion a l''apex.', 1),
  ('40000000-0000-0000-0000-000000000025', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Quelle loi physique explique que la vitesse de diffusion d''un gaz est inversement proportionnelle a l''epaisseur de la membrane ?', null, 'Bonne reponse : Loi de Fick.', 1),
  ('40000000-0000-0000-0000-000000000026', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Un patient presente un rapport de Tiffeneau (VEMS/CV) abaisse. Quel est le diagnostic le plus probable ?', null, 'Bonne reponse : Syndrome obstructif (ex : asthme).', 1),
  ('40000000-0000-0000-0000-000000000027', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Au repos, la pression intrapleurale est normalement :', null, 'Bonne reponse : Negative (subatmospherique).', 1),
  ('40000000-0000-0000-0000-000000000028', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Quel effet a une hyperventilation sur l''equilibre acido-basique ?', null, 'Bonne reponse : Provoque une alcalose respiratoire.', 1),
  ('40000000-0000-0000-0000-000000000029', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'L''innervation parasympathique des poumons via le nerf vague (X) provoque :', null, 'Bonne reponse : Une bronchoconstriction.', 1),
  ('40000000-0000-0000-0000-000000000030', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Quelle structure anatomique empeche les aliments de penetrer dans les voies respiratoires lors de la deglutition ?', null, 'Bonne reponse : L''epiglotte.', 1),
  ('40000000-0000-0000-0000-000000000031', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'La pression partielle en oxygene dans l''air alveolaire (PAO2) est d''environ :', null, 'Bonne reponse : 100 mmHg.', 1),
  ('40000000-0000-0000-0000-000000000032', '44444444-5555-6666-7777-000000000001', 'qcm_single', 'Lors d''un exercice intense, comment evolue la pression arterielle pulmonaire ?', null, 'Bonne reponse : Elle augmente legerement grace au recrutement de capillaires.', 1)
on conflict (id) do update set
  level_id = excluded.level_id,
  type = excluded.type,
  question_text = excluded.question_text,
  image_url = excluded.image_url,
  explanation = excluded.explanation,
  points = excluded.points;

insert into question_options (question_id, option_text, is_correct, option_order)
values
  ('10000000-0000-0000-0000-000000000001', 'Des acides aminÃ©s polymÃ©risÃ©s', false, 1),
  ('10000000-0000-0000-0000-000000000001', 'Des polyalcools ou polymÃ¨res de polyalcools Ã  fonction aldÃ©hyde ou cÃ©tone', true, 2),
  ('10000000-0000-0000-0000-000000000001', 'Des lipides Ã  fonction hydroxyle', false, 3),
  ('10000000-0000-0000-0000-000000000001', 'Des molÃ©cules inorganiques stockÃ©es dans les cellules', false, 4),
  ('10000000-0000-0000-0000-000000000002', '10 ATP', false, 1),
  ('10000000-0000-0000-0000-000000000002', '19 ATP', false, 2),
  ('10000000-0000-0000-0000-000000000002', '38 ATP', true, 3),
  ('10000000-0000-0000-0000-000000000002', '100 ATP', false, 4),
  ('10000000-0000-0000-0000-000000000003', 'Triose', false, 1),
  ('10000000-0000-0000-0000-000000000003', 'TÃ©trose', false, 2),
  ('10000000-0000-0000-0000-000000000003', 'Pentose', true, 3),
  ('10000000-0000-0000-0000-000000000003', 'Hexose', false, 4),
  ('10000000-0000-0000-0000-000000000004', 'Le nombre de carbones', false, 1),
  ('10000000-0000-0000-0000-000000000004', 'La nature de la fonction carbonylique (aldÃ©hyde vs cÃ©tone)', true, 2),
  ('10000000-0000-0000-0000-000000000004', 'La sÃ©rie D ou L', false, 3),
  ('10000000-0000-0000-0000-000000000004', 'La configuration anomÃ©rique', false, 4),
  ('10000000-0000-0000-0000-000000000005', 'Ã‰nantiomÃ¨res', false, 1),
  ('10000000-0000-0000-0000-000000000005', 'Ã‰pimÃ¨res en C4', true, 2),
  ('10000000-0000-0000-0000-000000000005', 'IsomÃ¨res de fonction', false, 3),
  ('10000000-0000-0000-0000-000000000005', 'AnomÃ¨res', false, 4),
  ('10000000-0000-0000-0000-000000000006', 'La direction du pouvoir rotatoire (+/-)', false, 1),
  ('10000000-0000-0000-0000-000000000006', 'La configuration du carbone asymÃ©trique adjacent Ã  la fonction alcool primaire', true, 2),
  ('10000000-0000-0000-0000-000000000006', 'Le nombre de carbones asymÃ©triques', false, 3),
  ('10000000-0000-0000-0000-000000000006', 'La position de la fonction rÃ©ductrice', false, 4),
  ('10000000-0000-0000-0000-000000000007', 'âˆ’93Â°', false, 1),
  ('10000000-0000-0000-0000-000000000007', '+18,7Â°', false, 2),
  ('10000000-0000-0000-0000-000000000007', '+ 52,7Â°', true, 3),
  ('10000000-0000-0000-0000-000000000007', '+112,2Â°', false, 4),
  ('10000000-0000-0000-0000-000000000008', 'C1 et C4 (cycle furanose)', false, 1),
  ('10000000-0000-0000-0000-000000000008', 'C1 et C5 (cycle pyranose)', true, 2),
  ('10000000-0000-0000-0000-000000000008', 'C2 et C5 (cycle furanose)', false, 3),
  ('10000000-0000-0000-0000-000000000008', 'C2 et C6 (cycle pyranose)', false, 4),
  ('10000000-0000-0000-0000-000000000009', 'OH en C1 en position cis par rapport Ã  CHâ‚‚OH', false, 1),
  ('10000000-0000-0000-0000-000000000009', 'OH en C1 en position trans par rapport Ã  CHâ‚‚OH', true, 2),
  ('10000000-0000-0000-0000-000000000009', 'OH en C1 Ã  droite dans la projection de Fischer', false, 3),
  ('10000000-0000-0000-0000-000000000009', 'Absence d''OH en C1', false, 4),
  ('10000000-0000-0000-0000-000000000010', 'Forme un prÃ©cipitÃ© bleu avec les fonctions cÃ©tone', false, 1),
  ('10000000-0000-0000-0000-000000000010', 'Est rÃ©duite par la fonction carbonyle libre â†’ prÃ©cipitÃ© rouge brique de Cuâ‚‚O', true, 2),
  ('10000000-0000-0000-0000-000000000010', 'Oxyde les fonctions alcool en acide', false, 3),
  ('10000000-0000-0000-0000-000000000010', 'Colore en jaune en prÃ©sence de furfural', false, 4),
  ('10000000-0000-0000-0000-000000000011', 'Perdu une fonction OH, remplacÃ©e par H', true, 1),
  ('10000000-0000-0000-0000-000000000011', 'Acquis une fonction amine (â€“NHâ‚‚)', false, 2),
  ('10000000-0000-0000-0000-000000000011', 'OxydÃ© leur alcool primaire en acide', false, 3),
  ('10000000-0000-0000-0000-000000000011', 'Ã‰tÃ© phosphorylÃ©s en position 6', false, 4),
  ('10000000-0000-0000-0000-000000000012', 'RÃ©duction de la fonction aldÃ©hyde', false, 1),
  ('10000000-0000-0000-0000-000000000012', 'Oxydation sÃ©lective de l''alcool primaire (C6) en â€“COOH', true, 2),
  ('10000000-0000-0000-0000-000000000012', 'Substitution de OH en C2 par NHâ‚‚', false, 3),
  ('10000000-0000-0000-0000-000000000012', 'Phosphorylation en C1', false, 4),
  ('10000000-0000-0000-0000-000000000013', 'Acide fort diluÃ© (HCl) ou glycosidases spÃ©cifiques', true, 1),
  ('10000000-0000-0000-0000-000000000013', 'Uniquement par des bases fortes', false, 2),
  ('10000000-0000-0000-0000-000000000013', 'Uniquement par des enzymes', false, 3),
  ('10000000-0000-0000-0000-000000000013', 'Par simple chauffage Ã  100Â°C', false, 4),
  ('10000000-0000-0000-0000-000000000014', 'D-glucose en liaisons Î±(1â†’4) avec ramifications Î±(1â†’6)', false, 1),
  ('10000000-0000-0000-0000-000000000014', 'D-glucose en liaisons Î²(1â†’4) linÃ©aires stabilisÃ©es par liaisons hydrogÃ¨ne', true, 2),
  ('10000000-0000-0000-0000-000000000014', 'D-fructose en liaisons Î²(2â†’1)', false, 3),
  ('10000000-0000-0000-0000-000000000014', 'D-galactose et D-glucose alternÃ©s', false, 4),
  ('10000000-0000-0000-0000-000000000015', 'Un ose infÃ©rieur par dÃ©gradation', false, 1),
  ('10000000-0000-0000-0000-000000000015', 'Les oses supÃ©rieurs (allongement de la chaÃ®ne d''un carbone)', true, 2),
  ('10000000-0000-0000-0000-000000000015', 'Un ose par isomÃ©rie de fonction', false, 3),
  ('10000000-0000-0000-0000-000000000015', 'La cyclisation d''un aldose', false, 4),
  ('10000000-0000-0000-0000-000000000016', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="22" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="24" x2="110" y2="40" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="52" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="54" x2="110" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="80" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="82" x2="110" y2="96" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="108" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="110" x2="110" y2="124" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="136" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="85" y="22" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="52" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="80" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="108" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="85" y="136" font-size="9" fill="#f0a500" font-family="monospace">5</text>
  <text x="15" y="20" font-size="9" fill="#6b7a99" font-family="monospace">D-Glucose</text>
  <text x="15" y="34" font-size="9" fill="#6b7a99" font-family="monospace">aldohexose</text>
</svg>
D-Glucose (aldohexose)', true, 1),
  ('10000000-0000-0000-0000-000000000016', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="92" y="22" font-size="11" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="110" y1="24" x2="110" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="98" y="50" font-size="11" fill="#34d399" font-family="monospace">C=O</text>
  <line x1="110" y1="52" x2="110" y2="66" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="78" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="80" x2="110" y2="94" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="106" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="108" x2="110" y2="122" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="134" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="85" y="22" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="50" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="78" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="106" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="85" y="134" font-size="9" fill="#f0a500" font-family="monospace">5</text>
  <text x="15" y="20" font-size="9" fill="#6b7a99" font-family="monospace">D-Fructose</text>
  <text x="15" y="34" font-size="9" fill="#6b7a99" font-family="monospace">cÃ©tohexose</text>
</svg>
D-Fructose (cÃ©tohexose)', false, 2),
  ('10000000-0000-0000-0000-000000000016', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="28" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="30" x2="110" y2="46" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="58" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="60" x2="110" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="88" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="90" x2="110" y2="106" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="118" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="120" x2="110" y2="130" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="140" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="85" y="28" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="58" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="88" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="118" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="15" y="30" font-size="9" fill="#6b7a99" font-family="monospace">D-Ribose</text>
  <text x="15" y="44" font-size="9" fill="#6b7a99" font-family="monospace">aldopentose</text>
</svg>
D-Ribose (aldopentose)', false, 3),
  ('10000000-0000-0000-0000-000000000016', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="22" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="24" x2="110" y2="40" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="52" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="54" x2="110" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="80" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="82" x2="110" y2="96" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="108" font-size="10" fill="#34d399" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="110" x2="110" y2="124" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="136" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="8" y="22" font-size="9" fill="#6b7a99" font-family="monospace">D-Galactose</text>
  <text x="8" y="36" font-size="9" fill="#34d399" font-family="monospace">Ã©pimÃ¨re C4</text>
</svg>
D-Galactose (aldohexose)', false, 4),
  ('10000000-0000-0000-0000-000000000017', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="22" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="24" x2="110" y2="40" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="52" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="54" x2="110" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="80" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="82" x2="110" y2="96" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="108" font-size="10" fill="#34d399" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="110" x2="110" y2="124" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="136" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="8" y="22" font-size="9" fill="#6b7a99" font-family="monospace">D-Galactose</text>
  <text x="8" y="36" font-size="9" fill="#34d399" font-family="monospace">Ã©pimÃ¨re C4</text>
</svg>
D-Galactose (aldohexose)', false, 1),
  ('10000000-0000-0000-0000-000000000017', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="92" y="22" font-size="11" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="110" y1="24" x2="110" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="98" y="50" font-size="11" fill="#34d399" font-family="monospace">C=O</text>
  <line x1="110" y1="52" x2="110" y2="66" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="78" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="80" x2="110" y2="94" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="106" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="108" x2="110" y2="122" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="134" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="85" y="22" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="50" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="78" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="106" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="85" y="134" font-size="9" fill="#f0a500" font-family="monospace">5</text>
  <text x="15" y="20" font-size="9" fill="#6b7a99" font-family="monospace">D-Fructose</text>
  <text x="15" y="34" font-size="9" fill="#6b7a99" font-family="monospace">cÃ©tohexose</text>
</svg>
D-Fructose (cÃ©tohexose)', true, 2),
  ('10000000-0000-0000-0000-000000000017', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="22" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="24" x2="110" y2="40" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="52" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="54" x2="110" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="80" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="82" x2="110" y2="96" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="108" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="110" x2="110" y2="124" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="136" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="85" y="22" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="52" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="80" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="108" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="85" y="136" font-size="9" fill="#f0a500" font-family="monospace">5</text>
  <text x="15" y="20" font-size="9" fill="#6b7a99" font-family="monospace">D-Glucose</text>
  <text x="15" y="34" font-size="9" fill="#6b7a99" font-family="monospace">aldohexose</text>
</svg>
D-Glucose (aldohexose)', false, 3),
  ('10000000-0000-0000-0000-000000000017', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="28" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="30" x2="110" y2="46" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="58" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="60" x2="110" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="88" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="90" x2="110" y2="106" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="118" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="120" x2="110" y2="130" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="140" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="85" y="28" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="58" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="88" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="118" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="15" y="30" font-size="9" fill="#6b7a99" font-family="monospace">D-Ribose</text>
  <text x="15" y="44" font-size="9" fill="#6b7a99" font-family="monospace">aldopentose</text>
</svg>
D-Ribose (aldopentose)', false, 4),
  ('10000000-0000-0000-0000-000000000018', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="22" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="24" x2="110" y2="40" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="52" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="54" x2="110" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="80" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="82" x2="110" y2="96" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="108" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="110" x2="110" y2="124" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="136" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="85" y="22" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="52" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="80" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="108" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="85" y="136" font-size="9" fill="#f0a500" font-family="monospace">5</text>
  <text x="15" y="20" font-size="9" fill="#6b7a99" font-family="monospace">D-Glucose</text>
  <text x="15" y="34" font-size="9" fill="#6b7a99" font-family="monospace">aldohexose</text>
</svg>
D-Glucose (aldohexose)', false, 1),
  ('10000000-0000-0000-0000-000000000018', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="22" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="24" x2="110" y2="40" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="52" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="54" x2="110" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="80" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="82" x2="110" y2="96" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="108" font-size="10" fill="#34d399" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="110" x2="110" y2="124" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="136" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="8" y="22" font-size="9" fill="#6b7a99" font-family="monospace">D-Galactose</text>
  <text x="8" y="36" font-size="9" fill="#34d399" font-family="monospace">Ã©pimÃ¨re C4</text>
</svg>
D-Galactose (aldohexose)', false, 2),
  ('10000000-0000-0000-0000-000000000018', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="28" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="30" x2="110" y2="46" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="58" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="60" x2="110" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="88" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="90" x2="110" y2="106" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="118" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="120" x2="110" y2="130" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="140" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="85" y="28" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="58" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="88" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="118" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="15" y="30" font-size="9" fill="#6b7a99" font-family="monospace">D-Ribose</text>
  <text x="15" y="44" font-size="9" fill="#6b7a99" font-family="monospace">aldopentose</text>
</svg>
D-Ribose (aldopentose)', true, 3),
  ('10000000-0000-0000-0000-000000000018', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="92" y="22" font-size="11" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="110" y1="24" x2="110" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="98" y="50" font-size="11" fill="#34d399" font-family="monospace">C=O</text>
  <line x1="110" y1="52" x2="110" y2="66" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="78" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="80" x2="110" y2="94" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="106" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="108" x2="110" y2="122" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="134" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="85" y="22" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="50" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="78" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="106" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="85" y="134" font-size="9" fill="#f0a500" font-family="monospace">5</text>
  <text x="15" y="20" font-size="9" fill="#6b7a99" font-family="monospace">D-Fructose</text>
  <text x="15" y="34" font-size="9" fill="#6b7a99" font-family="monospace">cÃ©tohexose</text>
</svg>
D-Fructose (cÃ©tohexose)', false, 4),
  ('10000000-0000-0000-0000-000000000019', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="22" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="24" x2="110" y2="40" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="52" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="54" x2="110" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="80" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="82" x2="110" y2="96" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="108" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="110" x2="110" y2="124" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="136" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="85" y="22" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="52" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="80" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="108" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="85" y="136" font-size="9" fill="#f0a500" font-family="monospace">5</text>
  <text x="15" y="20" font-size="9" fill="#6b7a99" font-family="monospace">D-Glucose</text>
  <text x="15" y="34" font-size="9" fill="#6b7a99" font-family="monospace">aldohexose</text>
</svg>
D-Glucose (C4â€“OH Ã  droite)', false, 1),
  ('10000000-0000-0000-0000-000000000019', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="28" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="30" x2="110" y2="46" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="58" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="60" x2="110" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="88" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="90" x2="110" y2="106" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="118" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="120" x2="110" y2="130" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="140" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="85" y="28" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="58" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="88" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="118" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="15" y="30" font-size="9" fill="#6b7a99" font-family="monospace">D-Ribose</text>
  <text x="15" y="44" font-size="9" fill="#6b7a99" font-family="monospace">aldopentose</text>
</svg>
D-Ribose (pentose)', false, 2),
  ('10000000-0000-0000-0000-000000000019', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="22" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="24" x2="110" y2="40" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="52" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="54" x2="110" y2="68" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="80" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="82" x2="110" y2="96" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="108" font-size="10" fill="#34d399" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="110" x2="110" y2="124" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="136" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="8" y="22" font-size="9" fill="#6b7a99" font-family="monospace">D-Galactose</text>
  <text x="8" y="36" font-size="9" fill="#34d399" font-family="monospace">Ã©pimÃ¨re C4</text>
</svg>
D-Galactose (C4â€“OH Ã  gauche)', true, 3),
  ('10000000-0000-0000-0000-000000000019', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="92" y="22" font-size="11" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="110" y1="24" x2="110" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="98" y="50" font-size="11" fill="#34d399" font-family="monospace">C=O</text>
  <line x1="110" y1="52" x2="110" y2="66" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="65" y="78" font-size="10" fill="#9ca3af" font-family="monospace">HO â”€Câ”€ H</text>
  <line x1="110" y1="80" x2="110" y2="94" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="106" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="108" x2="110" y2="122" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="134" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <text x="85" y="22" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="50" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="78" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="106" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="85" y="134" font-size="9" fill="#f0a500" font-family="monospace">5</text>
  <text x="15" y="20" font-size="9" fill="#6b7a99" font-family="monospace">D-Fructose</text>
  <text x="15" y="34" font-size="9" fill="#6b7a99" font-family="monospace">cÃ©tohexose</text>
</svg>
D-Fructose (cÃ©tose)', false, 4),
  ('10000000-0000-0000-0000-000000000020', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#f0a500" font-family="monospace">Î²-D-Glucopyranose</text>
  <polygon points="110,50 170,75 160,115 60,115 50,75" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="48" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="73" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="58" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="148" y="130" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="130" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="35" y="95" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="90" y="35" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="8" y="140" font-size="9" fill="#6b7a99" font-family="monospace">OH en C1 cis CHâ‚‚OH â†’ Î²</text>
</svg>
Î²-D-Glucopyranose', false, 1),
  ('10000000-0000-0000-0000-000000000020', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#34d399" font-family="monospace">Î±-D-Glucopyranose</text>
  <polygon points="110,30 170,55 160,100 60,100 50,55" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="28" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="53" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="75" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="148" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="35" y="73" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="90" y="42" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="8" y="130" font-size="9" fill="#6b7a99" font-family="monospace">OH en C1 trans CHâ‚‚OH â†’ Î±</text>
</svg>
Î±-D-Glucopyranose', true, 2),
  ('10000000-0000-0000-0000-000000000020', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#f0a500" font-family="monospace">Î±-D-Fructofuranose</text>
  <polygon points="110,38 165,70 140,115 80,115 55,70" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="120" y="128" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="76" y="128" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="34" y="72" font-size="10" fill="#9ca3af" font-family="monospace">HO</text>
  <text x="160" y="72" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="60" y="40" font-size="10" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="8" y="135" font-size="9" fill="#6b7a99" font-family="monospace">Cycle furane (C1 Ã  C4 + O)</text>
</svg>
Î±-D-Fructofuranose', false, 3),
  ('10000000-0000-0000-0000-000000000020', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Saccharose â€” Î±(1â†’2)Î²</text>
  <polygon points="55,40 80,58 72,88 38,88 30,58" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="30" y="100" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="36" y="32" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="78" y="62" font-size="8" fill="#f0a500" font-family="monospace">1â†’2</text>
  <polygon points="125,50 148,38 168,55 158,85 125,85" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="140" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="108" y="98" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="145" y="100" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="165" y="65" font-size="8" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,2)Î²-Fru Â· Non rÃ©ducteur</text>
</svg>
Saccharose', false, 4),
  ('10000000-0000-0000-0000-000000000021', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#34d399" font-family="monospace">Î±-D-Glucopyranose</text>
  <polygon points="110,30 170,55 160,100 60,100 50,55" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="28" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="53" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="75" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="148" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="35" y="73" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="90" y="42" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="8" y="130" font-size="9" fill="#6b7a99" font-family="monospace">OH en C1 trans CHâ‚‚OH â†’ Î±</text>
</svg>
Î±-D-Glucopyranose', false, 1),
  ('10000000-0000-0000-0000-000000000021', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#f0a500" font-family="monospace">Î±-D-Fructofuranose</text>
  <polygon points="110,38 165,70 140,115 80,115 55,70" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="120" y="128" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="76" y="128" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="34" y="72" font-size="10" fill="#9ca3af" font-family="monospace">HO</text>
  <text x="160" y="72" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="60" y="40" font-size="10" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="8" y="135" font-size="9" fill="#6b7a99" font-family="monospace">Cycle furane (C1 Ã  C4 + O)</text>
</svg>
Î±-D-Fructofuranose', false, 2),
  ('10000000-0000-0000-0000-000000000021', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#f0a500" font-family="monospace">Î²-D-Glucopyranose</text>
  <polygon points="110,50 170,75 160,115 60,115 50,75" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="48" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="73" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="58" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="148" y="130" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="130" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="35" y="95" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="90" y="35" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="8" y="140" font-size="9" fill="#6b7a99" font-family="monospace">OH en C1 cis CHâ‚‚OH â†’ Î²</text>
</svg>
Î²-D-Glucopyranose', true, 3),
  ('10000000-0000-0000-0000-000000000021', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Lactose â€” Î²(1â†’4)</text>
  <polygon points="55,35 80,50 75,80 35,80 30,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="26" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH OH</text>
  <text x="38" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="77" y1="64" x2="90" y2="64" stroke="#2dd4bf" stroke-width="2"/>
  <text x="82" y="60" font-size="8" fill="#2dd4bf" font-family="monospace">Î²</text>
  <polygon points="145,35 170,50 165,80 125,80 120,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="143" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="166" y="62" font-size="8" fill="#34d399" font-family="monospace">OH</text>
  <text x="120" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="128" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Gal-Î²(1,4)-Glc Â· RÃ©ducteur</text>
</svg>
Lactose', false, 4),
  ('10000000-0000-0000-0000-000000000022', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#34d399" font-family="monospace">Î±-D-Glucopyranose</text>
  <polygon points="110,30 170,55 160,100 60,100 50,55" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="28" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="53" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="75" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="148" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="35" y="73" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="90" y="42" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="8" y="130" font-size="9" fill="#6b7a99" font-family="monospace">OH en C1 trans CHâ‚‚OH â†’ Î±</text>
</svg>
Î±-D-Glucopyranose (6 chaÃ®nons)', false, 1),
  ('10000000-0000-0000-0000-000000000022', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#f0a500" font-family="monospace">Î²-D-Glucopyranose</text>
  <polygon points="110,50 170,75 160,115 60,115 50,75" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="48" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="73" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="58" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="148" y="130" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="130" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="35" y="95" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="90" y="35" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="8" y="140" font-size="9" fill="#6b7a99" font-family="monospace">OH en C1 cis CHâ‚‚OH â†’ Î²</text>
</svg>
Î²-D-Glucopyranose (6 chaÃ®nons)', false, 2),
  ('10000000-0000-0000-0000-000000000022', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Saccharose â€” Î±(1â†’2)Î²</text>
  <polygon points="55,40 80,58 72,88 38,88 30,58" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="30" y="100" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="36" y="32" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="78" y="62" font-size="8" fill="#f0a500" font-family="monospace">1â†’2</text>
  <polygon points="125,50 148,38 168,55 158,85 125,85" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="140" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="108" y="98" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="145" y="100" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="165" y="65" font-size="8" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,2)Î²-Fru Â· Non rÃ©ducteur</text>
</svg>
Saccharose', false, 3),
  ('10000000-0000-0000-0000-000000000022', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#f0a500" font-family="monospace">Î±-D-Fructofuranose</text>
  <polygon points="110,38 165,70 140,115 80,115 55,70" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="120" y="128" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="76" y="128" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="34" y="72" font-size="10" fill="#9ca3af" font-family="monospace">HO</text>
  <text x="160" y="72" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="60" y="40" font-size="10" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="8" y="135" font-size="9" fill="#6b7a99" font-family="monospace">Cycle furane (C1 Ã  C4 + O)</text>
</svg>
Î±-D-Fructofuranose (5 chaÃ®nons)', true, 4),
  ('10000000-0000-0000-0000-000000000023', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Saccharose â€” Î±(1â†’2)Î²</text>
  <polygon points="55,40 80,58 72,88 38,88 30,58" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="30" y="100" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="36" y="32" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="78" y="62" font-size="8" fill="#f0a500" font-family="monospace">1â†’2</text>
  <polygon points="125,50 148,38 168,55 158,85 125,85" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="140" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="108" y="98" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="145" y="100" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="165" y="65" font-size="8" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,2)Î²-Fru Â· Non rÃ©ducteur</text>
</svg>
Saccharose â€” non rÃ©ducteur', false, 1),
  ('10000000-0000-0000-0000-000000000023', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Lactose â€” Î²(1â†’4)</text>
  <polygon points="55,35 80,50 75,80 35,80 30,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="26" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH OH</text>
  <text x="38" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="77" y1="64" x2="90" y2="64" stroke="#2dd4bf" stroke-width="2"/>
  <text x="82" y="60" font-size="8" fill="#2dd4bf" font-family="monospace">Î²</text>
  <polygon points="145,35 170,50 165,80 125,80 120,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="143" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="166" y="62" font-size="8" fill="#34d399" font-family="monospace">OH</text>
  <text x="120" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="128" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Gal-Î²(1,4)-Glc Â· RÃ©ducteur</text>
</svg>
Lactose â€” Î²(1â†’4)', false, 2),
  ('10000000-0000-0000-0000-000000000023', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Maltose â€” Î±(1â†’4)</text>
  <polygon points="55,35 80,50 75,80 35,80 30,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="80" y="50" font-size="8" fill="#34d399" font-family="monospace">OH</text>
  <text x="30" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="38" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="77" y1="60" x2="90" y2="60" stroke="#f0a500" stroke-width="2"/>
  <text x="86" y="57" font-size="8" fill="#f0a500" font-family="monospace">Î±</text>
  <polygon points="145,35 170,50 165,80 125,80 120,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="143" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="62" font-size="8" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="120" y="90" font-size="8" fill="#34d399" font-family="monospace">OH OH</text>
  <text x="128" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,4)-Glc Â· RÃ©ducteur</text>
</svg>
Maltose â€” Î±(1â†’4)', true, 3),
  ('10000000-0000-0000-0000-000000000023', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Amylose â€” liaisons Î±(1â†’4)</text>
  <polygon points="35,45 55,30 75,45 70,75 40,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="33" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="27" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="37" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="46" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="73" y1="56" x2="88" y2="56" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="108,45 128,30 148,45 143,75 113,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="106" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="100" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="110" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="117" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="145" y1="56" x2="160" y2="56" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="178,45 198,30 218,45 213,75 183,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="176" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="180" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="185" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire de D-glucose Â· HÃ©lice</text>
</svg>
Amylose â€” polymÃ¨re', false, 4),
  ('10000000-0000-0000-0000-000000000024', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Maltose â€” Î±(1â†’4)</text>
  <polygon points="55,35 80,50 75,80 35,80 30,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="80" y="50" font-size="8" fill="#34d399" font-family="monospace">OH</text>
  <text x="30" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="38" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="77" y1="60" x2="90" y2="60" stroke="#f0a500" stroke-width="2"/>
  <text x="86" y="57" font-size="8" fill="#f0a500" font-family="monospace">Î±</text>
  <polygon points="145,35 170,50 165,80 125,80 120,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="143" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="62" font-size="8" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="120" y="90" font-size="8" fill="#34d399" font-family="monospace">OH OH</text>
  <text x="128" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,4)-Glc Â· RÃ©ducteur</text>
</svg>
Maltose â€” Î±(1â†’4) rÃ©ducteur', false, 1),
  ('10000000-0000-0000-0000-000000000024', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Saccharose â€” Î±(1â†’2)Î²</text>
  <polygon points="55,40 80,58 72,88 38,88 30,58" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="30" y="100" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="36" y="32" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="78" y="62" font-size="8" fill="#f0a500" font-family="monospace">1â†’2</text>
  <polygon points="125,50 148,38 168,55 158,85 125,85" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="140" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="108" y="98" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="145" y="100" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="165" y="65" font-size="8" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,2)Î²-Fru Â· Non rÃ©ducteur</text>
</svg>
Saccharose â€” Î±(1â†’2)Î² non rÃ©ducteur', true, 2),
  ('10000000-0000-0000-0000-000000000024', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Lactose â€” Î²(1â†’4)</text>
  <polygon points="55,35 80,50 75,80 35,80 30,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="26" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH OH</text>
  <text x="38" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="77" y1="64" x2="90" y2="64" stroke="#2dd4bf" stroke-width="2"/>
  <text x="82" y="60" font-size="8" fill="#2dd4bf" font-family="monospace">Î²</text>
  <polygon points="145,35 170,50 165,80 125,80 120,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="143" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="166" y="62" font-size="8" fill="#34d399" font-family="monospace">OH</text>
  <text x="120" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="128" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Gal-Î²(1,4)-Glc Â· RÃ©ducteur</text>
</svg>
Lactose â€” Î²(1â†’4) rÃ©ducteur', false, 3),
  ('10000000-0000-0000-0000-000000000024', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Acide D-Glucuronique</text>
  <polygon points="110,38 168,65 155,105 65,105 52,65" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="168" y="63" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="80" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="138" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="70" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="30" y="80" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="38" font-size="10" fill="#34d399" font-family="monospace">COOâ»</text>
  <text x="5" y="135" font-size="9" fill="#6b7a99" font-family="monospace">CHâ‚‚OH â†’ COOâ» par KMnOâ‚„</text>
</svg>
Acide glucuronique', false, 4),
  ('10000000-0000-0000-0000-000000000025', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Saccharose â€” Î±(1â†’2)Î²</text>
  <polygon points="55,40 80,58 72,88 38,88 30,58" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="30" y="100" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="36" y="32" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="78" y="62" font-size="8" fill="#f0a500" font-family="monospace">1â†’2</text>
  <polygon points="125,50 148,38 168,55 158,85 125,85" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="140" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="108" y="98" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="145" y="100" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="165" y="65" font-size="8" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,2)Î²-Fru Â· Non rÃ©ducteur</text>
</svg>
Saccharose', false, 1),
  ('10000000-0000-0000-0000-000000000025', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Maltose â€” Î±(1â†’4)</text>
  <polygon points="55,35 80,50 75,80 35,80 30,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="80" y="50" font-size="8" fill="#34d399" font-family="monospace">OH</text>
  <text x="30" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="38" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="77" y1="60" x2="90" y2="60" stroke="#f0a500" stroke-width="2"/>
  <text x="86" y="57" font-size="8" fill="#f0a500" font-family="monospace">Î±</text>
  <polygon points="145,35 170,50 165,80 125,80 120,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="143" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="62" font-size="8" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="120" y="90" font-size="8" fill="#34d399" font-family="monospace">OH OH</text>
  <text x="128" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,4)-Glc Â· RÃ©ducteur</text>
</svg>
Maltose', false, 2),
  ('10000000-0000-0000-0000-000000000025', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Amylose â€” liaisons Î±(1â†’4)</text>
  <polygon points="35,45 55,30 75,45 70,75 40,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="33" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="27" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="37" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="46" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="73" y1="56" x2="88" y2="56" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="108,45 128,30 148,45 143,75 113,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="106" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="100" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="110" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="117" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="145" y1="56" x2="160" y2="56" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="178,45 198,30 218,45 213,75 183,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="176" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="180" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="185" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire de D-glucose Â· HÃ©lice</text>
</svg>
Amylose', false, 3),
  ('10000000-0000-0000-0000-000000000025', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Lactose â€” Î²(1â†’4)</text>
  <polygon points="55,35 80,50 75,80 35,80 30,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="26" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH OH</text>
  <text x="38" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="77" y1="64" x2="90" y2="64" stroke="#2dd4bf" stroke-width="2"/>
  <text x="82" y="60" font-size="8" fill="#2dd4bf" font-family="monospace">Î²</text>
  <polygon points="145,35 170,50 165,80 125,80 120,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="143" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="166" y="62" font-size="8" fill="#34d399" font-family="monospace">OH</text>
  <text x="120" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="128" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Gal-Î²(1,4)-Glc Â· RÃ©ducteur</text>
</svg>
Lactose â€” Î²(1â†’4)', true, 4),
  ('10000000-0000-0000-0000-000000000026', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Cellulose â€” liaisons Î²(1â†’4)</text>
  <polygon points="35,45 55,30 75,45 70,75 40,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="33" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="75" y="60" font-size="7" fill="#34d399" font-family="monospace">OH</text>
  <text x="37" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="46" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="74" y1="56" x2="92" y2="56" stroke="#2dd4bf" stroke-width="1.8"/>
  <polygon points="112,75 132,60 152,75 147,105 117,105" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="110" y="73" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="104" y="90" font-size="7" fill="#34d399" font-family="monospace">OH</text>
  <text x="112" y="115" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="118" y="52" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="148" y1="90" x2="166" y2="74" stroke="#2dd4bf" stroke-width="1.8"/>
  <polygon points="186,45 206,30 218,45 213,75 183,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="184" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="218" y="60" font-size="7" fill="#34d399" font-family="monospace">OH</text>
  <text x="185" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="186" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="130" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire rigide Â· liaisons H</text>
</svg>
Cellulose â€” Î²(1â†’4)', false, 1),
  ('10000000-0000-0000-0000-000000000026', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Amylose â€” liaisons Î±(1â†’4)</text>
  <polygon points="35,45 55,30 75,45 70,75 40,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="33" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="27" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="37" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="46" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="73" y1="56" x2="88" y2="56" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="108,45 128,30 148,45 143,75 113,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="106" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="100" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="110" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="117" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="145" y1="56" x2="160" y2="56" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="178,45 198,30 218,45 213,75 183,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="176" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="180" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="185" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire de D-glucose Â· HÃ©lice</text>
</svg>
Amylose â€” Î±(1â†’4) linÃ©aire', true, 2),
  ('10000000-0000-0000-0000-000000000026', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">GlycogÃ¨ne â€” Î±(1â†’6)</text>
  <polygon points="55,40 75,25 95,40 90,68 60,68" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="53" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="38" y="52" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="60" y="78" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="63" y="20" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="88" y1="53" x2="103" y2="53" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="123,40 143,25 163,40 158,68 128,68" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="121" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="106" y="52" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="128" y="78" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="122" y="20" font-size="7" fill="#34d399" font-family="monospace">CHâ‚‚</text>
  <line x1="135" y1="16" x2="135" y2="6" stroke="#34d399" stroke-width="1.6"/>
  <polygon points="160,25 175,10 185,25 180,45 163,45" fill="none" stroke="#9ca3af" stroke-width="1.4"/>
  <text x="158" y="23" font-size="7" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="181" y="35" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="148" y="55" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="155" y="8" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="105" font-size="8" fill="#6b7a99" font-family="monospace">Ramification Î±(1â†’6)</text>
  <text x="5" y="118" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne principale Î±(1â†’4)</text>
</svg>
GlycogÃ¨ne â€” ramifiÃ©', false, 3),
  ('10000000-0000-0000-0000-000000000026', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Maltose â€” Î±(1â†’4)</text>
  <polygon points="55,35 80,50 75,80 35,80 30,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="80" y="50" font-size="8" fill="#34d399" font-family="monospace">OH</text>
  <text x="30" y="90" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="38" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="77" y1="60" x2="90" y2="60" stroke="#f0a500" stroke-width="2"/>
  <text x="86" y="57" font-size="8" fill="#f0a500" font-family="monospace">Î±</text>
  <polygon points="145,35 170,50 165,80 125,80 120,50" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="143" y="33" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="62" font-size="8" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="120" y="90" font-size="8" fill="#34d399" font-family="monospace">OH OH</text>
  <text x="128" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,4)-Glc Â· RÃ©ducteur</text>
</svg>
Maltose â€” diholoside', false, 4),
  ('10000000-0000-0000-0000-000000000027', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Amylose â€” liaisons Î±(1â†’4)</text>
  <polygon points="35,45 55,30 75,45 70,75 40,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="33" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="27" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="37" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="46" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="73" y1="56" x2="88" y2="56" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="108,45 128,30 148,45 143,75 113,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="106" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="100" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="110" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="117" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="145" y1="56" x2="160" y2="56" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="178,45 198,30 218,45 213,75 183,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="176" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="57" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="180" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="185" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire de D-glucose Â· HÃ©lice</text>
</svg>
Amylose â€” Î±(1â†’4)', false, 1),
  ('10000000-0000-0000-0000-000000000027', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">GlycogÃ¨ne â€” Î±(1â†’6)</text>
  <polygon points="55,40 75,25 95,40 90,68 60,68" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="53" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="38" y="52" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="60" y="78" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="63" y="20" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="88" y1="53" x2="103" y2="53" stroke="#f0a500" stroke-width="1.8"/>
  <polygon points="123,40 143,25 163,40 158,68 128,68" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="121" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="106" y="52" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="128" y="78" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="122" y="20" font-size="7" fill="#34d399" font-family="monospace">CHâ‚‚</text>
  <line x1="135" y1="16" x2="135" y2="6" stroke="#34d399" stroke-width="1.6"/>
  <polygon points="160,25 175,10 185,25 180,45 163,45" fill="none" stroke="#9ca3af" stroke-width="1.4"/>
  <text x="158" y="23" font-size="7" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="181" y="35" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="148" y="55" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="155" y="8" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="105" font-size="8" fill="#6b7a99" font-family="monospace">Ramification Î±(1â†’6)</text>
  <text x="5" y="118" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne principale Î±(1â†’4)</text>
</svg>
GlycogÃ¨ne â€” Î±(1â†’6)', false, 2),
  ('10000000-0000-0000-0000-000000000027', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Cellulose â€” liaisons Î²(1â†’4)</text>
  <polygon points="35,45 55,30 75,45 70,75 40,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="33" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="75" y="60" font-size="7" fill="#34d399" font-family="monospace">OH</text>
  <text x="37" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="46" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="74" y1="56" x2="92" y2="56" stroke="#2dd4bf" stroke-width="1.8"/>
  <polygon points="112,75 132,60 152,75 147,105 117,105" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="110" y="73" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="104" y="90" font-size="7" fill="#34d399" font-family="monospace">OH</text>
  <text x="112" y="115" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="118" y="52" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <line x1="148" y1="90" x2="166" y2="74" stroke="#2dd4bf" stroke-width="1.8"/>
  <polygon points="186,45 206,30 218,45 213,75 183,75" fill="none" stroke="#9ca3af" stroke-width="1.6"/>
  <text x="184" y="43" font-size="8" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="218" y="60" font-size="7" fill="#34d399" font-family="monospace">OH</text>
  <text x="185" y="85" font-size="7" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="186" y="22" font-size="7" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="130" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire rigide Â· liaisons H</text>
</svg>
Cellulose â€” Î²(1â†’4) rigide', true, 3),
  ('10000000-0000-0000-0000-000000000027', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Saccharose â€” Î±(1â†’2)Î²</text>
  <polygon points="55,40 80,58 72,88 38,88 30,58" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="53" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="30" y="100" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="36" y="32" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="78" y="62" font-size="8" fill="#f0a500" font-family="monospace">1â†’2</text>
  <polygon points="125,50 148,38 168,55 158,85 125,85" fill="none" stroke="#9ca3af" stroke-width="1.8"/>
  <text x="140" y="38" font-size="9" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="108" y="98" font-size="8" fill="#9ca3af" font-family="monospace">OH OH</text>
  <text x="145" y="100" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="165" y="65" font-size="8" fill="#9ca3af" font-family="monospace">HOHâ‚‚C</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Glc-Î±(1,2)Î²-Fru Â· Non rÃ©ducteur</text>
</svg>
Saccharose', false, 4),
  ('10000000-0000-0000-0000-000000000028', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">D-Glucosamine</text>
  <polygon points="110,38 168,65 155,105 65,105 52,65" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="168" y="80" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="138" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="70" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="30" y="80" font-size="10" fill="#34d399" font-family="monospace">NHâ‚‚</text>
  <text x="80" y="38" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="135" font-size="9" fill="#6b7a99" font-family="monospace">OH en C2 remplacÃ© par NHâ‚‚</text>
</svg>
D-Glucosamine (NHâ‚‚ en C2)', false, 1),
  ('10000000-0000-0000-0000-000000000028', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Acide D-Glucuronique</text>
  <polygon points="110,38 168,65 155,105 65,105 52,65" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="168" y="63" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="80" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="138" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="70" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="30" y="80" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="38" font-size="10" fill="#34d399" font-family="monospace">COOâ»</text>
  <text x="5" y="135" font-size="9" fill="#6b7a99" font-family="monospace">CHâ‚‚OH â†’ COOâ» par KMnOâ‚„</text>
</svg>
Acide D-Glucuronique (COOâ» en C6)', true, 2),
  ('10000000-0000-0000-0000-000000000028', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">2-DÃ©soxyribose</text>
  <polygon points="110,40 160,75 140,118 80,118 60,75" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="38" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="162" y="78" font-size="9" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="108" y="128" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="44" y="78" font-size="10" fill="#34d399" font-family="monospace">H</text>
  <text x="75" y="42" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="136" font-size="9" fill="#6b7a99" font-family="monospace">OH en C2 remplacÃ© par H</text>
</svg>
2-DÃ©soxyribose (H en C2)', false, 3),
  ('10000000-0000-0000-0000-000000000028', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#34d399" font-family="monospace">Î±-D-Glucopyranose</text>
  <polygon points="110,30 170,55 160,100 60,100 50,55" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="28" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="53" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="75" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="148" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="35" y="73" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="90" y="42" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="8" y="130" font-size="9" fill="#6b7a99" font-family="monospace">OH en C1 trans CHâ‚‚OH â†’ Î±</text>
</svg>
Î±-D-Glucopyranose', false, 4),
  ('10000000-0000-0000-0000-000000000029', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Acide D-Glucuronique</text>
  <polygon points="110,38 168,65 155,105 65,105 52,65" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="168" y="63" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="80" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="138" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="70" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="30" y="80" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="38" font-size="10" fill="#34d399" font-family="monospace">COOâ»</text>
  <text x="5" y="135" font-size="9" fill="#6b7a99" font-family="monospace">CHâ‚‚OH â†’ COOâ» par KMnOâ‚„</text>
</svg>
Acide glucuronique (COOH en C6)', false, 1),
  ('10000000-0000-0000-0000-000000000029', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">2-DÃ©soxyribose</text>
  <polygon points="110,40 160,75 140,118 80,118 60,75" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="38" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="162" y="78" font-size="9" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="108" y="128" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="44" y="78" font-size="10" fill="#34d399" font-family="monospace">H</text>
  <text x="75" y="42" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="136" font-size="9" fill="#6b7a99" font-family="monospace">OH en C2 remplacÃ© par H</text>
</svg>
2-DÃ©soxyribose (H en C2)', false, 2),
  ('10000000-0000-0000-0000-000000000029', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="16" font-size="9" fill="#34d399" font-family="monospace">Î±-D-Glucopyranose</text>
  <polygon points="110,30 170,55 160,100 60,100 50,55" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="28" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="170" y="53" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="75" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="148" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="115" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="35" y="73" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="90" y="42" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="8" y="130" font-size="9" fill="#6b7a99" font-family="monospace">OH en C1 trans CHâ‚‚OH â†’ Î±</text>
</svg>
Î±-D-Glucopyranose', false, 3),
  ('10000000-0000-0000-0000-000000000029', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">D-Glucosamine</text>
  <polygon points="110,38 168,65 155,105 65,105 52,65" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="168" y="80" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="138" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="70" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="30" y="80" font-size="10" fill="#34d399" font-family="monospace">NHâ‚‚</text>
  <text x="80" y="38" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="135" font-size="9" fill="#6b7a99" font-family="monospace">OH en C2 remplacÃ© par NHâ‚‚</text>
</svg>
D-Glucosamine (NHâ‚‚ en C2)', true, 4),
  ('10000000-0000-0000-0000-000000000030', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="98" y="28" font-size="11" fill="#34d399" font-family="monospace">CHO</text>
  <line x1="110" y1="30" x2="110" y2="46" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="58" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="60" x2="110" y2="76" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="88" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="90" x2="110" y2="106" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="72" y="118" font-size="10" fill="#9ca3af" font-family="monospace">H â”€Câ”€ OH</text>
  <line x1="110" y1="120" x2="110" y2="130" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="92" y="140" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="85" y="28" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="85" y="58" font-size="9" fill="#f0a500" font-family="monospace">2</text>
  <text x="85" y="88" font-size="9" fill="#f0a500" font-family="monospace">3</text>
  <text x="85" y="118" font-size="9" fill="#f0a500" font-family="monospace">4</text>
  <text x="15" y="30" font-size="9" fill="#6b7a99" font-family="monospace">D-Ribose</text>
  <text x="15" y="44" font-size="9" fill="#6b7a99" font-family="monospace">aldopentose</text>
</svg>
D-Ribose (OH en C2)', false, 1),
  ('10000000-0000-0000-0000-000000000030', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">D-Glucosamine</text>
  <polygon points="110,38 168,65 155,105 65,105 52,65" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="168" y="80" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="138" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="70" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="30" y="80" font-size="10" fill="#34d399" font-family="monospace">NHâ‚‚</text>
  <text x="80" y="38" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="135" font-size="9" fill="#6b7a99" font-family="monospace">OH en C2 remplacÃ© par NHâ‚‚</text>
</svg>
D-Glucosamine (NHâ‚‚ en C2)', false, 2),
  ('10000000-0000-0000-0000-000000000030', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">2-DÃ©soxyribose</text>
  <polygon points="110,40 160,75 140,118 80,118 60,75" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="38" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="162" y="78" font-size="9" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="108" y="128" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="44" y="78" font-size="10" fill="#34d399" font-family="monospace">H</text>
  <text x="75" y="42" font-size="10" fill="#9ca3af" font-family="monospace">CHâ‚‚OH</text>
  <text x="5" y="136" font-size="9" fill="#6b7a99" font-family="monospace">OH en C2 remplacÃ© par H</text>
</svg>
2-DÃ©soxyribose (H en C2)', true, 3),
  ('10000000-0000-0000-0000-000000000030', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Acide D-Glucuronique</text>
  <polygon points="110,38 168,65 155,105 65,105 52,65" fill="none" stroke="#9ca3af" stroke-width="2"/>
  <text x="108" y="36" font-size="10" fill="#2dd4bf" font-family="monospace">O</text>
  <text x="168" y="63" font-size="9" fill="#f0a500" font-family="monospace">1</text>
  <text x="172" y="80" font-size="10" fill="#34d399" font-family="monospace">OH</text>
  <text x="138" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="70" y="118" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="30" y="80" font-size="10" fill="#9ca3af" font-family="monospace">OH</text>
  <text x="64" y="38" font-size="10" fill="#34d399" font-family="monospace">COOâ»</text>
  <text x="5" y="135" font-size="9" fill="#6b7a99" font-family="monospace">CHâ‚‚OH â†’ COOâ» par KMnOâ‚„</text>
</svg>
Acide glucuronique', false, 4),
  ('10000000-0000-0000-0000-000000000031', 'Oses (monosaccharides)', false, 1),
  ('10000000-0000-0000-0000-000000000031', 'Oligosides (2â€“10 unitÃ©s d''oses)', true, 2),
  ('10000000-0000-0000-0000-000000000031', 'Polyosides (>10 unitÃ©s)', false, 3),
  ('10000000-0000-0000-0000-000000000031', 'HÃ©tÃ©rosides', false, 4),
  ('10000000-0000-0000-0000-000000000032', 'CÃ©tohexoses', false, 1),
  ('10000000-0000-0000-0000-000000000032', 'Aldopentoses', false, 2),
  ('10000000-0000-0000-0000-000000000032', 'Aldohexoses', true, 3),
  ('10000000-0000-0000-0000-000000000032', 'CÃ©topentoses', false, 4),
  ('10000000-0000-0000-0000-000000000033', 'Glucose', false, 1),
  ('10000000-0000-0000-0000-000000000033', 'Maltose', false, 2),
  ('10000000-0000-0000-0000-000000000033', 'Saccharose', true, 3),
  ('10000000-0000-0000-0000-000000000033', 'Lactose', false, 4),
  ('10000000-0000-0000-0000-000000000034', 'Homopolysaccharides de D-glucose en liaisons Î²', false, 1),
  ('10000000-0000-0000-0000-000000000034', 'HÃ©tÃ©ropolysaccharides', false, 2),
  ('10000000-0000-0000-0000-000000000034', 'Homopolysaccharides de D-glucose en liaisons Î±', true, 3),
  ('10000000-0000-0000-0000-000000000034', 'Oligosides rÃ©ducteurs', false, 4),
  ('10000000-0000-0000-0000-000000000035', 'Ã‰nergÃ©tique (rÃ©serve)', false, 1),
  ('10000000-0000-0000-0000-000000000035', 'Structural (paroi/squelette)', true, 2),
  ('10000000-0000-0000-0000-000000000035', 'Signal (hormonal)', false, 3),
  ('10000000-0000-0000-0000-000000000035', 'Transport (membranaire)', false, 4),
  ('10000000-0000-0000-0000-000000000036', 'Acide glucarique (oxydation forte)', false, 1),
  ('10000000-0000-0000-0000-000000000036', 'D-Sorbitol (rÃ©duction)', false, 2),
  ('10000000-0000-0000-0000-000000000036', 'Acide D-gluconique (acide aldonique)', true, 3),
  ('10000000-0000-0000-0000-000000000036', 'Glucose-6-phosphate', false, 4),
  ('10000000-0000-0000-0000-000000000037', 'Acide gluconique', false, 1),
  ('10000000-0000-0000-0000-000000000037', 'D-Sorbitol (polyalcool)', true, 2),
  ('10000000-0000-0000-0000-000000000037', 'Acide glucuronique', false, 3),
  ('10000000-0000-0000-0000-000000000037', 'D-Fructose', false, 4),
  ('10000000-0000-0000-0000-000000000038', 'Holosides simples (oses uniquement)', false, 1),
  ('10000000-0000-0000-0000-000000000038', 'Glycosaminoglycanes (osamines + acides uroniques)', true, 2),
  ('10000000-0000-0000-0000-000000000038', 'GlycoprotÃ©ines', false, 3),
  ('10000000-0000-0000-0000-000000000038', 'Triholosides', false, 4),
  ('10000000-0000-0000-0000-000000000039', 'Oxyde seulement la fonction aldÃ©hyde', false, 1),
  ('10000000-0000-0000-0000-000000000039', 'Coupe entre deux carbones adjacents porteurs de â€“OH libres', true, 2),
  ('10000000-0000-0000-0000-000000000039', 'Phosphoryle l''alcool primaire', false, 3),
  ('10000000-0000-0000-0000-000000000039', 'RÃ©duit les oses en polyalcools', false, 4),
  ('10000000-0000-0000-0000-000000000040', 'Ã‰pimÃ¨res (1 seul C* diffÃ©rent)', false, 1),
  ('10000000-0000-0000-0000-000000000040', 'Ã‰nantiomÃ¨res (tous les C* inversÃ©s â€” images miroir)', true, 2),
  ('10000000-0000-0000-0000-000000000040', 'DiastÃ©rÃ©oisomÃ¨res non Ã©nantiomÃ¨res', false, 3),
  ('10000000-0000-0000-0000-000000000040', 'IsomÃ¨res de fonction', false, 4),
  ('20000000-0000-0000-0000-000000000001', 'Ils sont solubles dans l''eau', false, 1),
  ('20000000-0000-0000-0000-000000000001', 'Ils sont insolubles dans l''eau mais solubles dans les solvants organiques', true, 2),
  ('20000000-0000-0000-0000-000000000001', 'Ils contiennent tous de l''azote', false, 3),
  ('20000000-0000-0000-0000-000000000001', 'Ils sont tous des esters de glycÃ©rol', false, 4),
  ('20000000-0000-0000-0000-000000000002', 'Les glycÃ©rophospholipides', false, 1),
  ('20000000-0000-0000-0000-000000000002', 'Les sphingolipides', false, 2),
  ('20000000-0000-0000-0000-000000000002', 'Les glycÃ©rides', true, 3),
  ('20000000-0000-0000-0000-000000000002', 'Les plasmalogÃ¨nes', false, 4),
  ('20000000-0000-0000-0000-000000000003', 'CnH2nO2', false, 1),
  ('20000000-0000-0000-0000-000000000003', 'CHâ‚ƒâ€“(CHâ‚‚)nâ€“COOH', true, 2),
  ('20000000-0000-0000-0000-000000000003', 'CHâ‚ƒâ€“(CHâ‚‚)nâ€“CH=CHâ€“COOH', false, 3),
  ('20000000-0000-0000-0000-000000000003', 'CnH2n-2O2', false, 4),
  ('20000000-0000-0000-0000-000000000004', 'C18:0', false, 1),
  ('20000000-0000-0000-0000-000000000004', 'C18:1 Î”9', true, 2),
  ('20000000-0000-0000-0000-000000000004', 'C18:2 Î”9,12', false, 3),
  ('20000000-0000-0000-0000-000000000004', 'C20:4 Î”5,8,11,14', false, 4),
  ('20000000-0000-0000-0000-000000000005', 'L''huile contient plus de protÃ©ines', false, 1),
  ('20000000-0000-0000-0000-000000000005', 'L''huile est riche en acides gras insaturÃ©s qui ont un point de fusion bas', true, 2),
  ('20000000-0000-0000-0000-000000000005', 'Le beurre contient du cholestÃ©rol', false, 3),
  ('20000000-0000-0000-0000-000000000005', 'L''huile est plus lÃ©gÃ¨re que le beurre', false, 4),
  ('20000000-0000-0000-0000-000000000006', 'La quantitÃ© en g d''iode fixÃ©e par 100 g de lipide', false, 1),
  ('20000000-0000-0000-0000-000000000006', 'La quantitÃ© en mg de potasse (KOH) nÃ©cessaire pour saponifier 1 g de matiÃ¨re grasse', true, 2),
  ('20000000-0000-0000-0000-000000000006', 'Le rapport entre AG saturÃ©s et insaturÃ©s', false, 3),
  ('20000000-0000-0000-0000-000000000006', 'La masse molÃ©culaire de l''acide gras', false, 4),
  ('20000000-0000-0000-0000-000000000007', 'La masse molÃ©culaire des glycÃ©rides', false, 1),
  ('20000000-0000-0000-0000-000000000007', 'L''indice d''aciditÃ© de la matiÃ¨re grasse', false, 2),
  ('20000000-0000-0000-0000-000000000007', 'Le degrÃ© d''insaturation des acides gras', true, 3),
  ('20000000-0000-0000-0000-000000000007', 'La quantitÃ© de phospholipides', false, 4),
  ('20000000-0000-0000-0000-000000000008', 'Il porte 3 AG identiques', false, 1),
  ('20000000-0000-0000-0000-000000000008', 'Il peut donner naissance Ã  2 isomÃ¨res optiques (I et II)', true, 2),
  ('20000000-0000-0000-0000-000000000008', 'Il est toujours libre (non estÃ©rifiÃ©)', false, 3),
  ('20000000-0000-0000-0000-000000000008', 'Il ne peut Ãªtre estÃ©rifiÃ© qu''avec un AG saturÃ©', false, 4),
  ('20000000-0000-0000-0000-000000000009', '2 AG insaturÃ©s en CÎ± et CÎ²', false, 1),
  ('20000000-0000-0000-0000-000000000009', 'AG saturÃ© en CÎ± et AG insaturÃ© en CÎ²', true, 2),
  ('20000000-0000-0000-0000-000000000009', 'AG insaturÃ© en CÎ± et AG saturÃ© en CÎ²', false, 3),
  ('20000000-0000-0000-0000-000000000009', '3 AG identiques sur tous les carbones', false, 4),
  ('20000000-0000-0000-0000-000000000010', 'Phospholipase A1', false, 1),
  ('20000000-0000-0000-0000-000000000010', 'Phospholipase A2', true, 2),
  ('20000000-0000-0000-0000-000000000010', 'Phospholipase C', false, 3),
  ('20000000-0000-0000-0000-000000000010', 'Phospholipase D', false, 4),
  ('20000000-0000-0000-0000-000000000011', 'Les sphingolipides contiennent du glycÃ©rol Ã  la place de la sphingosine', false, 1),
  ('20000000-0000-0000-0000-000000000011', 'Les sphingolipides contiennent de la sphingosine Ã  la place du glycÃ©rol comme alcool de base', true, 2),
  ('20000000-0000-0000-0000-000000000011', 'Les sphingolipides n''ont pas d''acides gras', false, 3),
  ('20000000-0000-0000-0000-000000000011', 'Les sphingolipides sont uniquement prÃ©sents dans les bactÃ©ries', false, 4),
  ('20000000-0000-0000-0000-000000000012', 'Le tissu adipeux', false, 1),
  ('20000000-0000-0000-0000-000000000012', 'Le foie', false, 2),
  ('20000000-0000-0000-0000-000000000012', 'Les neurones (gaine de myÃ©line)', true, 3),
  ('20000000-0000-0000-0000-000000000012', 'Les globules rouges', false, 4),
  ('20000000-0000-0000-0000-000000000013', 'CÃ©ramide + phosphate + choline', false, 1),
  ('20000000-0000-0000-0000-000000000013', 'CÃ©ramide + D-galactose (liaison Î²-glycosidique)', true, 2),
  ('20000000-0000-0000-0000-000000000013', 'Sphingosine + acide phosphatidique', false, 3),
  ('20000000-0000-0000-0000-000000000013', 'GlycÃ©rol + D-galactose + 2 AG', false, 4),
  ('20000000-0000-0000-0000-000000000014', 'D''isoprÃ¨ne (2-mÃ©thyl-1,3-butadiÃ¨ne)', true, 1),
  ('20000000-0000-0000-0000-000000000014', 'De glucose', false, 2),
  ('20000000-0000-0000-0000-000000000014', 'D''acide gras saturÃ©', false, 3),
  ('20000000-0000-0000-0000-000000000014', 'De glycÃ©rol', false, 4),
  ('20000000-0000-0000-0000-000000000015', 'Uniquement des acides gras libres', false, 1),
  ('20000000-0000-0000-0000-000000000015', 'Du glycÃ©rol et des sels d''acides gras (savons)', true, 2),
  ('20000000-0000-0000-0000-000000000015', 'Du glycÃ©rol et des esters mÃ©thyliques', false, 3),
  ('20000000-0000-0000-0000-000000000015', 'De l''acide sulfurique et du glycÃ©rol', false, 4),
  ('20000000-0000-0000-0000-000000000016', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Ac. Palmitique C16</text>
  <text x="5" y="32" font-size="9" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“(CHâ‚‚)â‚â‚„â€“COOH</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="65" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="50" x2="42" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="62" x2="54" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="50" x2="66" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="62" x2="78" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="50" x2="90" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="62" x2="102" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="102" y1="50" x2="114" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="62" x2="126" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="50" x2="138" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="62" x2="150" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="50" x2="165" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="45" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire saturÃ©e</text>
  <text x="5" y="113" font-size="8" fill="#6b7a99" font-family="monospace">Pas de double liaison</text>
  <text x="5" y="130" font-size="8" fill="#f0a500" font-family="monospace">Solide Ã  TÂ° ambiante</text>
</svg>
Acide palmitique C16:0', true, 1),
  ('20000000-0000-0000-0000-000000000016', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Ac. OlÃ©ique C18:Î”9</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚ƒ(CHâ‚‚)â‚‡â€“CH=CHâ€“(CHâ‚‚)â‚‡COOH</text>
  <line x1="10" y1="48" x2="95" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="63" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="48" x2="42" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="60" x2="54" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="48" x2="66" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="60" x2="78" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="48" x2="90" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="60" x2="102" y2="48" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="90" y1="56" x2="102" y2="44" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="36" font-size="9" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="102" y1="48" x2="114" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="60" x2="126" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="48" x2="138" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="60" x2="150" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="48" x2="165" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="44" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">1 double liaison cis en C9</text>
  <text x="5" y="115" font-size="8" fill="#2dd4bf" font-family="monospace">Liquide Ã  TÂ° ambiante</text>
</svg>
Acide olÃ©ique C18:1', false, 2),
  ('20000000-0000-0000-0000-000000000016', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Ac. LinolÃ©ique C18:Î”9,12</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">2 doubles liaisons</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="0.8" stroke-dasharray="2,2"/>
  <line x1="10" y1="55" x2="55" y2="55" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="55" y1="55" x2="68" y2="42" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="58" y1="55" x2="71" y2="42" stroke="#2dd4bf" stroke-width="2"/>
  <text x="60" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="68" y1="42" x2="105" y2="42" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="105" y1="42" x2="118" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="108" y1="42" x2="121" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <text x="110" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">Î”12</text>
  <line x1="118" y1="55" x2="155" y2="55" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="157" y="59" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="80" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">Ac. gras essentiel (omÃ©ga-6)</text>
  <text x="5" y="125" font-size="8" fill="#2dd4bf" font-family="monospace">Point de fusion trÃ¨s bas</text>
</svg>
Acide linolÃ©ique C18:2', false, 3),
  ('20000000-0000-0000-0000-000000000016', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f87171" font-family="monospace">Ac. Arachidonique C20:Î”5,8,11,14</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">4 doubles liaisons</text>
  <line x1="5" y1="50" x2="30" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="30" y1="50" x2="45" y2="38" stroke="#f87171" stroke-width="2"/>
  <line x1="33" y1="50" x2="48" y2="38" stroke="#f87171" stroke-width="2"/>
  <text x="36" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”5</text>
  <line x1="45" y1="38" x2="70" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="70" y1="38" x2="85" y2="50" stroke="#f87171" stroke-width="2"/>
  <line x1="73" y1="38" x2="88" y2="50" stroke="#f87171" stroke-width="2"/>
  <text x="75" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”8</text>
  <line x1="85" y1="50" x2="110" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="110" y1="50" x2="125" y2="38" stroke="#f87171" stroke-width="2"/>
  <line x1="113" y1="50" x2="128" y2="38" stroke="#f87171" stroke-width="2"/>
  <text x="115" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”11</text>
  <line x1="125" y1="38" x2="150" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="150" y1="38" x2="165" y2="50" stroke="#f87171" stroke-width="2"/>
  <line x1="153" y1="38" x2="168" y2="50" stroke="#f87171" stroke-width="2"/>
  <text x="152" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”14</text>
  <line x1="165" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="75" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">OmÃ©ga-6, prÃ©curseur prostaglandines</text>
  <text x="5" y="115" font-size="8" fill="#f87171" font-family="monospace">C20 â€” AG polyinsaturÃ©</text>
</svg>
Acide arachidonique C20:4', false, 4),
  ('20000000-0000-0000-0000-000000000017', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Ac. Palmitique C16</text>
  <text x="5" y="32" font-size="9" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“(CHâ‚‚)â‚â‚„â€“COOH</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="65" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="50" x2="42" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="62" x2="54" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="50" x2="66" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="62" x2="78" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="50" x2="90" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="62" x2="102" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="102" y1="50" x2="114" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="62" x2="126" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="50" x2="138" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="62" x2="150" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="50" x2="165" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="45" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire saturÃ©e</text>
  <text x="5" y="113" font-size="8" fill="#6b7a99" font-family="monospace">Pas de double liaison</text>
  <text x="5" y="130" font-size="8" fill="#f0a500" font-family="monospace">Solide Ã  TÂ° ambiante</text>
</svg>
Acide palmitique C16:0', false, 1),
  ('20000000-0000-0000-0000-000000000017', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Ac. OlÃ©ique C18:Î”9</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚ƒ(CHâ‚‚)â‚‡â€“CH=CHâ€“(CHâ‚‚)â‚‡COOH</text>
  <line x1="10" y1="48" x2="95" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="63" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="48" x2="42" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="60" x2="54" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="48" x2="66" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="60" x2="78" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="48" x2="90" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="60" x2="102" y2="48" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="90" y1="56" x2="102" y2="44" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="36" font-size="9" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="102" y1="48" x2="114" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="60" x2="126" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="48" x2="138" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="60" x2="150" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="48" x2="165" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="44" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">1 double liaison cis en C9</text>
  <text x="5" y="115" font-size="8" fill="#2dd4bf" font-family="monospace">Liquide Ã  TÂ° ambiante</text>
</svg>
Acide olÃ©ique C18:1 Î”9', true, 2),
  ('20000000-0000-0000-0000-000000000017', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Acide Butyrique C4</text>
  <text x="5" y="35" font-size="12" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“CHâ‚‚â€“CHâ‚‚â€“COOH</text>
  <text x="5" y="60" font-size="9" fill="#f0a500" font-family="monospace">C1</text>
  <line x1="20" y1="70" x2="55" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="56" y="65" font-size="9" fill="#9ca3af" font-family="monospace">C2</text>
  <line x1="70" y1="70" x2="105" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="65" font-size="9" fill="#9ca3af" font-family="monospace">C3</text>
  <line x1="120" y1="70" x2="155" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="156" y="65" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="15" y="90" font-size="9" fill="#f0a500" font-family="monospace">CHâ‚ƒ</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">Plus petit AG des lipides</text>
  <text x="5" y="128" font-size="8" fill="#6b7a99" font-family="monospace">PrÃ©sent dans le beurre</text>
</svg>
Acide butyrique C4', false, 3),
  ('20000000-0000-0000-0000-000000000017', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Acide StÃ©arique C18</text>
  <text x="5" y="30" font-size="9" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“(CHâ‚‚)â‚â‚†â€“COOH</text>
  <line x1="10" y1="52" x2="210" y2="52" stroke="#9ca3af" stroke-width="1"/>
  <text x="5" y="65" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="28" y1="52" x2="40" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="40" y1="64" x2="52" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="52" y1="52" x2="64" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="64" y1="64" x2="76" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="76" y1="52" x2="88" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="88" y1="64" x2="100" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="100" y1="52" x2="112" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="112" y1="64" x2="124" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="124" y1="52" x2="136" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="136" y1="64" x2="148" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="148" y1="52" x2="160" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="160" y="48" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="95" font-size="8" fill="#6b7a99" font-family="monospace">AG saturÃ© C18 â€” solide</text>
  <text x="5" y="110" font-size="8" fill="#2dd4bf" font-family="monospace">Point de fusion Ã©levÃ©</text>
</svg>
Acide stÃ©arique C18:0', false, 4),
  ('20000000-0000-0000-0000-000000000018', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">MonoglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 1 AG esterifiÃ©</text>
</svg>
MonoglycÃ©ride', false, 1),
  ('20000000-0000-0000-0000-000000000018', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">DiglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="72" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="28" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="72" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="72" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="90" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 2 AG esterifiÃ©s</text>
</svg>
DiglycÃ©ride', false, 2),
  ('20000000-0000-0000-0000-000000000018', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">TriglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚ƒ</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 3 AG esterifiÃ©s</text>
</svg>
TriglycÃ©ride', true, 3),
  ('20000000-0000-0000-0000-000000000018', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">PhosphoglycÃ©ride</text>
  <line x1="55" y1="22" x2="55" y2="112" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="38" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="5" y="51" font-size="7" fill="#f0a500" font-family="monospace">pÃ´le hydrophobe</text>
  <text x="28" y="66" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="88" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“X</text>
  <text x="5" y="101" font-size="7" fill="#2dd4bf" font-family="monospace">pÃ´le hydrophile</text>
  <line x1="8" y1="72" x2="20" y2="72" stroke="#f0a500" stroke-width="1.5"/>
  <line x1="8" y1="92" x2="20" y2="92" stroke="#2dd4bf" stroke-width="1.5"/>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">2 AG + glycÃ©rol + acide phosphorique</text>
</svg>
PhosphoglycÃ©ride', false, 4),
  ('20000000-0000-0000-0000-000000000019', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">TriglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚ƒ</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 3 AG esterifiÃ©s</text>
</svg>
TriglycÃ©ride', false, 1),
  ('20000000-0000-0000-0000-000000000019', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">DiglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="72" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="28" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="72" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="72" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="90" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 2 AG esterifiÃ©s</text>
</svg>
DiglycÃ©ride', false, 2),
  ('20000000-0000-0000-0000-000000000019', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">PhosphoglycÃ©ride</text>
  <line x1="55" y1="22" x2="55" y2="112" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="38" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="5" y="51" font-size="7" fill="#f0a500" font-family="monospace">pÃ´le hydrophobe</text>
  <text x="28" y="66" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="88" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“X</text>
  <text x="5" y="101" font-size="7" fill="#2dd4bf" font-family="monospace">pÃ´le hydrophile</text>
  <line x1="8" y1="72" x2="20" y2="72" stroke="#f0a500" stroke-width="1.5"/>
  <line x1="8" y1="92" x2="20" y2="92" stroke="#2dd4bf" stroke-width="1.5"/>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">2 AG + glycÃ©rol + acide phosphorique</text>
</svg>
PhosphoglycÃ©ride', false, 3),
  ('20000000-0000-0000-0000-000000000019', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">MonoglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 1 AG esterifiÃ©</text>
</svg>
MonoglycÃ©ride', true, 4),
  ('20000000-0000-0000-0000-000000000020', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">TriglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚ƒ</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 3 AG esterifiÃ©s</text>
</svg>
TriglycÃ©ride', false, 1),
  ('20000000-0000-0000-0000-000000000020', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">PhosphoglycÃ©ride</text>
  <line x1="55" y1="22" x2="55" y2="112" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="38" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="5" y="51" font-size="7" fill="#f0a500" font-family="monospace">pÃ´le hydrophobe</text>
  <text x="28" y="66" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="88" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“X</text>
  <text x="5" y="101" font-size="7" fill="#2dd4bf" font-family="monospace">pÃ´le hydrophile</text>
  <line x1="8" y1="72" x2="20" y2="72" stroke="#f0a500" stroke-width="1.5"/>
  <line x1="8" y1="92" x2="20" y2="92" stroke="#2dd4bf" stroke-width="1.5"/>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">2 AG + glycÃ©rol + acide phosphorique</text>
</svg>
GlycÃ©rophospholipide', true, 2),
  ('20000000-0000-0000-0000-000000000020', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">CÃ©ramide</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">Sphingosine + AG (amide)</text>
  <line x1="60" y1="40" x2="60" y2="115" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="53" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“OH</text>
  <text x="5" y="68" font-size="8" fill="#2dd4bf" font-family="monospace">HCâ€“NHâ€“COâ€“R</text>
  <text x="38" y="68" font-size="8" fill="#34d399" font-family="monospace">â† liaison amide</text>
  <text x="5" y="83" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“OH</text>
  <text x="5" y="98" font-size="8" fill="#9ca3af" font-family="monospace">HC=CHâ€“(CHâ‚‚)â‚â‚‚â€“CHâ‚ƒ</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">PrÃ©curseur des sphingolipides</text>
  <text x="5" y="133" font-size="8" fill="#2dd4bf" font-family="monospace">Pas de phosphate, pas d''ose</text>
</svg>
CÃ©ramide', false, 3),
  ('20000000-0000-0000-0000-000000000020', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Cire â€” Palmitate de cÃ©tyle</text>
  <text x="5" y="30" font-size="8" fill="#9ca3af" font-family="monospace">Câ‚ƒâ‚€Hâ‚†â‚â€“Oâ€“COâ€“Câ‚â‚…Hâ‚ƒâ‚</text>
  <text x="5" y="50" font-size="9" fill="#9ca3af" font-family="monospace">Alcool aliphatique</text>
  <line x1="5" y1="55" x2="100" y2="55" stroke="#f0a500" stroke-width="2"/>
  <text x="88" y="50" font-size="9" fill="#34d399" font-family="monospace">O</text>
  <line x1="95" y1="55" x2="105" y2="45" stroke="#34d399" stroke-width="2"/>
  <line x1="105" y1="45" x2="115" y2="55" stroke="#34d399" stroke-width="2"/>
  <text x="112" y="50" font-size="9" fill="#34d399" font-family="monospace">C=O</text>
  <line x1="135" y1="55" x2="210" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <text x="140" y="68" font-size="9" fill="#2dd4bf" font-family="monospace">Acide gras</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">Esters Ã  trÃ¨s longue chaÃ®ne</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">92% du blanc de baleine</text>
  <text x="5" y="130" font-size="8" fill="#f0a500" font-family="monospace">Cires vÃ©gÃ©tales & insectes</text>
</svg>
Cire', false, 4),
  ('20000000-0000-0000-0000-000000000021', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">LÃ©cithine (Phosphatidylcholine)</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">X = Choline</text>
  <line x1="55" y1="35" x2="55" y2="100" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="50" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="28" y="67" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="84" font-size="8" fill="#2dd4bf" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“Choline</text>
  <text x="130" y="100" font-size="8" fill="#34d399" font-family="monospace">â€“Nâº(CHâ‚ƒ)â‚ƒ</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">Membrane cellules animales</text>
  <text x="5" y="128" font-size="8" fill="#2dd4bf" font-family="monospace">Amphiphile â€” bicouche lipidique</text>
</svg>
LÃ©cithine (phosphatidylcholine)', false, 1),
  ('20000000-0000-0000-0000-000000000021', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">SphingomyÃ©line</text>
  <text x="5" y="30" font-size="8" fill="#9ca3af" font-family="monospace">Sphingosine + AG (liaison amide)</text>
  <line x1="30" y1="48" x2="30" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="50" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“OH</text>
  <text x="5" y="65" font-size="8" fill="#2dd4bf" font-family="monospace">HCâ€“NHâ€“COâ€“R</text>
  <text x="5" y="80" font-size="8" fill="#9ca3af" font-family="monospace">HC=CHâ€“(CHâ‚‚)â‚â‚‚â€“CHâ‚ƒ</text>
  <text x="5" y="96" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“Choline</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Gaine de myÃ©line â€” neurones</text>
  <text x="5" y="132" font-size="8" fill="#34d399" font-family="monospace">Liaison amide â‰  ester</text>
</svg>
SphingomyÃ©line', true, 2),
  ('20000000-0000-0000-0000-000000000021', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">CÃ©ramide</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">Sphingosine + AG (amide)</text>
  <line x1="60" y1="40" x2="60" y2="115" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="53" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“OH</text>
  <text x="5" y="68" font-size="8" fill="#2dd4bf" font-family="monospace">HCâ€“NHâ€“COâ€“R</text>
  <text x="38" y="68" font-size="8" fill="#34d399" font-family="monospace">â† liaison amide</text>
  <text x="5" y="83" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“OH</text>
  <text x="5" y="98" font-size="8" fill="#9ca3af" font-family="monospace">HC=CHâ€“(CHâ‚‚)â‚â‚‚â€“CHâ‚ƒ</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">PrÃ©curseur des sphingolipides</text>
  <text x="5" y="133" font-size="8" fill="#2dd4bf" font-family="monospace">Pas de phosphate, pas d''ose</text>
</svg>
CÃ©ramide', false, 3),
  ('20000000-0000-0000-0000-000000000021', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">GalactocÃ©rÃ©broside</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CÃ©ramide + D-Galactose</text>
  <polygon points="35,55 60,40 85,55 80,85 40,85" fill="none" stroke="#f0a500" stroke-width="2"/>
  <text x="33" y="53" font-size="9" fill="#f0a500" font-family="monospace">O</text>
  <text x="48" y="33" font-size="8" fill="#9ca3af" font-family="monospace">Gal</text>
  <line x1="82" y1="68" x2="100" y2="68" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="63" font-size="8" fill="#2dd4bf" font-family="monospace">Î²(1â†’1)</text>
  <text x="110" y="60" font-size="8" fill="#34d399" font-family="monospace">CÃ©ramide</text>
  <text x="110" y="75" font-size="8" fill="#9ca3af" font-family="monospace">(sphingosine</text>
  <text x="110" y="88" font-size="8" fill="#9ca3af" font-family="monospace">+ AG)</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">Lipide non phosphorÃ©</text>
  <text x="5" y="125" font-size="8" fill="#34d399" font-family="monospace">1 ose = D-galactose</text>
  <text x="5" y="138" font-size="8" fill="#f0a500" font-family="monospace">Tissu nerveux</text>
</svg>
GalactocÃ©rÃ©broside', false, 4),
  ('20000000-0000-0000-0000-000000000022', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">PhosphoglycÃ©ride</text>
  <line x1="55" y1="22" x2="55" y2="112" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="38" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="5" y="51" font-size="7" fill="#f0a500" font-family="monospace">pÃ´le hydrophobe</text>
  <text x="28" y="66" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="88" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“X</text>
  <text x="5" y="101" font-size="7" fill="#2dd4bf" font-family="monospace">pÃ´le hydrophile</text>
  <line x1="8" y1="72" x2="20" y2="72" stroke="#f0a500" stroke-width="1.5"/>
  <line x1="8" y1="92" x2="20" y2="92" stroke="#2dd4bf" stroke-width="1.5"/>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">2 AG + glycÃ©rol + acide phosphorique</text>
</svg>
PhosphoglycÃ©ride', false, 1),
  ('20000000-0000-0000-0000-000000000022', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">MonoglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 1 AG esterifiÃ©</text>
</svg>
MonoglycÃ©ride', false, 2),
  ('20000000-0000-0000-0000-000000000022', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Cire â€” Palmitate de cÃ©tyle</text>
  <text x="5" y="30" font-size="8" fill="#9ca3af" font-family="monospace">Câ‚ƒâ‚€Hâ‚†â‚â€“Oâ€“COâ€“Câ‚â‚…Hâ‚ƒâ‚</text>
  <text x="5" y="50" font-size="9" fill="#9ca3af" font-family="monospace">Alcool aliphatique</text>
  <line x1="5" y1="55" x2="100" y2="55" stroke="#f0a500" stroke-width="2"/>
  <text x="88" y="50" font-size="9" fill="#34d399" font-family="monospace">O</text>
  <line x1="95" y1="55" x2="105" y2="45" stroke="#34d399" stroke-width="2"/>
  <line x1="105" y1="45" x2="115" y2="55" stroke="#34d399" stroke-width="2"/>
  <text x="112" y="50" font-size="9" fill="#34d399" font-family="monospace">C=O</text>
  <line x1="135" y1="55" x2="210" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <text x="140" y="68" font-size="9" fill="#2dd4bf" font-family="monospace">Acide gras</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">Esters Ã  trÃ¨s longue chaÃ®ne</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">92% du blanc de baleine</text>
  <text x="5" y="130" font-size="8" fill="#f0a500" font-family="monospace">Cires vÃ©gÃ©tales & insectes</text>
</svg>
Palmitate de cÃ©tyle (cire)', true, 3),
  ('20000000-0000-0000-0000-000000000022', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">TriglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚ƒ</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 3 AG esterifiÃ©s</text>
</svg>
TriglycÃ©ride', false, 4),
  ('20000000-0000-0000-0000-000000000023', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">GalactocÃ©rÃ©broside</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CÃ©ramide + D-Galactose</text>
  <polygon points="35,55 60,40 85,55 80,85 40,85" fill="none" stroke="#f0a500" stroke-width="2"/>
  <text x="33" y="53" font-size="9" fill="#f0a500" font-family="monospace">O</text>
  <text x="48" y="33" font-size="8" fill="#9ca3af" font-family="monospace">Gal</text>
  <line x1="82" y1="68" x2="100" y2="68" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="63" font-size="8" fill="#2dd4bf" font-family="monospace">Î²(1â†’1)</text>
  <text x="110" y="60" font-size="8" fill="#34d399" font-family="monospace">CÃ©ramide</text>
  <text x="110" y="75" font-size="8" fill="#9ca3af" font-family="monospace">(sphingosine</text>
  <text x="110" y="88" font-size="8" fill="#9ca3af" font-family="monospace">+ AG)</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">Lipide non phosphorÃ©</text>
  <text x="5" y="125" font-size="8" fill="#34d399" font-family="monospace">1 ose = D-galactose</text>
  <text x="5" y="138" font-size="8" fill="#f0a500" font-family="monospace">Tissu nerveux</text>
</svg>
CÃ©ramide + D-galactose', false, 1),
  ('20000000-0000-0000-0000-000000000023', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">SphingomyÃ©line</text>
  <text x="5" y="30" font-size="8" fill="#9ca3af" font-family="monospace">Sphingosine + AG (liaison amide)</text>
  <line x1="30" y1="48" x2="30" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="50" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“OH</text>
  <text x="5" y="65" font-size="8" fill="#2dd4bf" font-family="monospace">HCâ€“NHâ€“COâ€“R</text>
  <text x="5" y="80" font-size="8" fill="#9ca3af" font-family="monospace">HC=CHâ€“(CHâ‚‚)â‚â‚‚â€“CHâ‚ƒ</text>
  <text x="5" y="96" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“Choline</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Gaine de myÃ©line â€” neurones</text>
  <text x="5" y="132" font-size="8" fill="#34d399" font-family="monospace">Liaison amide â‰  ester</text>
</svg>
CÃ©ramide + phosphocholine', false, 2),
  ('20000000-0000-0000-0000-000000000023', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">CÃ©ramide</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">Sphingosine + AG (amide)</text>
  <line x1="60" y1="40" x2="60" y2="115" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="53" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“OH</text>
  <text x="5" y="68" font-size="8" fill="#2dd4bf" font-family="monospace">HCâ€“NHâ€“COâ€“R</text>
  <text x="38" y="68" font-size="8" fill="#34d399" font-family="monospace">â† liaison amide</text>
  <text x="5" y="83" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“OH</text>
  <text x="5" y="98" font-size="8" fill="#9ca3af" font-family="monospace">HC=CHâ€“(CHâ‚‚)â‚â‚‚â€“CHâ‚ƒ</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">PrÃ©curseur des sphingolipides</text>
  <text x="5" y="133" font-size="8" fill="#2dd4bf" font-family="monospace">Pas de phosphate, pas d''ose</text>
</svg>
Sphingosine + AG (liaison amide)', true, 3),
  ('20000000-0000-0000-0000-000000000023', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">LÃ©cithine (Phosphatidylcholine)</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">X = Choline</text>
  <line x1="55" y1="35" x2="55" y2="100" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="50" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="28" y="67" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="84" font-size="8" fill="#2dd4bf" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“Choline</text>
  <text x="130" y="100" font-size="8" fill="#34d399" font-family="monospace">â€“Nâº(CHâ‚ƒ)â‚ƒ</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">Membrane cellules animales</text>
  <text x="5" y="128" font-size="8" fill="#2dd4bf" font-family="monospace">Amphiphile â€” bicouche lipidique</text>
</svg>
GlycÃ©rol + 2 AG + phosphocholine', false, 4),
  ('20000000-0000-0000-0000-000000000024', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">CÃ©ramide</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">Sphingosine + AG (amide)</text>
  <line x1="60" y1="40" x2="60" y2="115" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="53" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“OH</text>
  <text x="5" y="68" font-size="8" fill="#2dd4bf" font-family="monospace">HCâ€“NHâ€“COâ€“R</text>
  <text x="38" y="68" font-size="8" fill="#34d399" font-family="monospace">â† liaison amide</text>
  <text x="5" y="83" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“OH</text>
  <text x="5" y="98" font-size="8" fill="#9ca3af" font-family="monospace">HC=CHâ€“(CHâ‚‚)â‚â‚‚â€“CHâ‚ƒ</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">PrÃ©curseur des sphingolipides</text>
  <text x="5" y="133" font-size="8" fill="#2dd4bf" font-family="monospace">Pas de phosphate, pas d''ose</text>
</svg>
CÃ©ramide seul', false, 1),
  ('20000000-0000-0000-0000-000000000024', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">GalactocÃ©rÃ©broside</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CÃ©ramide + D-Galactose</text>
  <polygon points="35,55 60,40 85,55 80,85 40,85" fill="none" stroke="#f0a500" stroke-width="2"/>
  <text x="33" y="53" font-size="9" fill="#f0a500" font-family="monospace">O</text>
  <text x="48" y="33" font-size="8" fill="#9ca3af" font-family="monospace">Gal</text>
  <line x1="82" y1="68" x2="100" y2="68" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="63" font-size="8" fill="#2dd4bf" font-family="monospace">Î²(1â†’1)</text>
  <text x="110" y="60" font-size="8" fill="#34d399" font-family="monospace">CÃ©ramide</text>
  <text x="110" y="75" font-size="8" fill="#9ca3af" font-family="monospace">(sphingosine</text>
  <text x="110" y="88" font-size="8" fill="#9ca3af" font-family="monospace">+ AG)</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">Lipide non phosphorÃ©</text>
  <text x="5" y="125" font-size="8" fill="#34d399" font-family="monospace">1 ose = D-galactose</text>
  <text x="5" y="138" font-size="8" fill="#f0a500" font-family="monospace">Tissu nerveux</text>
</svg>
GalactocÃ©rÃ©broside (cÃ©ramide + Gal)', true, 2),
  ('20000000-0000-0000-0000-000000000024', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">SphingomyÃ©line</text>
  <text x="5" y="30" font-size="8" fill="#9ca3af" font-family="monospace">Sphingosine + AG (liaison amide)</text>
  <line x1="30" y1="48" x2="30" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="50" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“OH</text>
  <text x="5" y="65" font-size="8" fill="#2dd4bf" font-family="monospace">HCâ€“NHâ€“COâ€“R</text>
  <text x="5" y="80" font-size="8" fill="#9ca3af" font-family="monospace">HC=CHâ€“(CHâ‚‚)â‚â‚‚â€“CHâ‚ƒ</text>
  <text x="5" y="96" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“Choline</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">Gaine de myÃ©line â€” neurones</text>
  <text x="5" y="132" font-size="8" fill="#34d399" font-family="monospace">Liaison amide â‰  ester</text>
</svg>
SphingomyÃ©line', false, 3),
  ('20000000-0000-0000-0000-000000000024', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">LÃ©cithine (Phosphatidylcholine)</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">X = Choline</text>
  <line x1="55" y1="35" x2="55" y2="100" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="50" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="28" y="67" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="84" font-size="8" fill="#2dd4bf" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“Choline</text>
  <text x="130" y="100" font-size="8" fill="#34d399" font-family="monospace">â€“Nâº(CHâ‚ƒ)â‚ƒ</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">Membrane cellules animales</text>
  <text x="5" y="128" font-size="8" fill="#2dd4bf" font-family="monospace">Amphiphile â€” bicouche lipidique</text>
</svg>
LÃ©cithine', false, 4),
  ('20000000-0000-0000-0000-000000000025', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Ac. OlÃ©ique C18:Î”9</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚ƒ(CHâ‚‚)â‚‡â€“CH=CHâ€“(CHâ‚‚)â‚‡COOH</text>
  <line x1="10" y1="48" x2="95" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="63" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="48" x2="42" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="60" x2="54" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="48" x2="66" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="60" x2="78" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="48" x2="90" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="60" x2="102" y2="48" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="90" y1="56" x2="102" y2="44" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="36" font-size="9" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="102" y1="48" x2="114" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="60" x2="126" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="48" x2="138" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="60" x2="150" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="48" x2="165" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="44" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">1 double liaison cis en C9</text>
  <text x="5" y="115" font-size="8" fill="#2dd4bf" font-family="monospace">Liquide Ã  TÂ° ambiante</text>
</svg>
1 double liaison (C18:1)', false, 1),
  ('20000000-0000-0000-0000-000000000025', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Ac. LinolÃ©ique C18:Î”9,12</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">2 doubles liaisons</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="0.8" stroke-dasharray="2,2"/>
  <line x1="10" y1="55" x2="55" y2="55" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="55" y1="55" x2="68" y2="42" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="58" y1="55" x2="71" y2="42" stroke="#2dd4bf" stroke-width="2"/>
  <text x="60" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="68" y1="42" x2="105" y2="42" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="105" y1="42" x2="118" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="108" y1="42" x2="121" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <text x="110" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">Î”12</text>
  <line x1="118" y1="55" x2="155" y2="55" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="157" y="59" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="80" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">Ac. gras essentiel (omÃ©ga-6)</text>
  <text x="5" y="125" font-size="8" fill="#2dd4bf" font-family="monospace">Point de fusion trÃ¨s bas</text>
</svg>
2 doubles liaisons (C18:2)', false, 2),
  ('20000000-0000-0000-0000-000000000025', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f87171" font-family="monospace">Ac. Arachidonique C20:Î”5,8,11,14</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">4 doubles liaisons</text>
  <line x1="5" y1="50" x2="30" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="30" y1="50" x2="45" y2="38" stroke="#f87171" stroke-width="2"/>
  <line x1="33" y1="50" x2="48" y2="38" stroke="#f87171" stroke-width="2"/>
  <text x="36" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”5</text>
  <line x1="45" y1="38" x2="70" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="70" y1="38" x2="85" y2="50" stroke="#f87171" stroke-width="2"/>
  <line x1="73" y1="38" x2="88" y2="50" stroke="#f87171" stroke-width="2"/>
  <text x="75" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”8</text>
  <line x1="85" y1="50" x2="110" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="110" y1="50" x2="125" y2="38" stroke="#f87171" stroke-width="2"/>
  <line x1="113" y1="50" x2="128" y2="38" stroke="#f87171" stroke-width="2"/>
  <text x="115" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”11</text>
  <line x1="125" y1="38" x2="150" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="150" y1="38" x2="165" y2="50" stroke="#f87171" stroke-width="2"/>
  <line x1="153" y1="38" x2="168" y2="50" stroke="#f87171" stroke-width="2"/>
  <text x="152" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”14</text>
  <line x1="165" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="75" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">OmÃ©ga-6, prÃ©curseur prostaglandines</text>
  <text x="5" y="115" font-size="8" fill="#f87171" font-family="monospace">C20 â€” AG polyinsaturÃ©</text>
</svg>
4 doubles liaisons (C20:4)', true, 3),
  ('20000000-0000-0000-0000-000000000025', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Ac. Palmitique C16</text>
  <text x="5" y="32" font-size="9" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“(CHâ‚‚)â‚â‚„â€“COOH</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="65" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="50" x2="42" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="62" x2="54" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="50" x2="66" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="62" x2="78" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="50" x2="90" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="62" x2="102" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="102" y1="50" x2="114" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="62" x2="126" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="50" x2="138" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="62" x2="150" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="50" x2="165" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="45" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire saturÃ©e</text>
  <text x="5" y="113" font-size="8" fill="#6b7a99" font-family="monospace">Pas de double liaison</text>
  <text x="5" y="130" font-size="8" fill="#f0a500" font-family="monospace">Solide Ã  TÂ° ambiante</text>
</svg>
Aucune double liaison (C16:0)', false, 4),
  ('20000000-0000-0000-0000-000000000026', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">TriglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚ƒ</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 3 AG esterifiÃ©s</text>
</svg>
TriglycÃ©ride', false, 1),
  ('20000000-0000-0000-0000-000000000026', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">CÃ©ramide</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">Sphingosine + AG (amide)</text>
  <line x1="60" y1="40" x2="60" y2="115" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="53" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“OH</text>
  <text x="5" y="68" font-size="8" fill="#2dd4bf" font-family="monospace">HCâ€“NHâ€“COâ€“R</text>
  <text x="38" y="68" font-size="8" fill="#34d399" font-family="monospace">â† liaison amide</text>
  <text x="5" y="83" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“OH</text>
  <text x="5" y="98" font-size="8" fill="#9ca3af" font-family="monospace">HC=CHâ€“(CHâ‚‚)â‚â‚‚â€“CHâ‚ƒ</text>
  <text x="5" y="120" font-size="8" fill="#6b7a99" font-family="monospace">PrÃ©curseur des sphingolipides</text>
  <text x="5" y="133" font-size="8" fill="#2dd4bf" font-family="monospace">Pas de phosphate, pas d''ose</text>
</svg>
CÃ©ramide', false, 2),
  ('20000000-0000-0000-0000-000000000026', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">LÃ©cithine (Phosphatidylcholine)</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">X = Choline</text>
  <line x1="55" y1="35" x2="55" y2="100" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="50" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="28" y="67" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="84" font-size="8" fill="#2dd4bf" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“Choline</text>
  <text x="130" y="100" font-size="8" fill="#34d399" font-family="monospace">â€“Nâº(CHâ‚ƒ)â‚ƒ</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">Membrane cellules animales</text>
  <text x="5" y="128" font-size="8" fill="#2dd4bf" font-family="monospace">Amphiphile â€” bicouche lipidique</text>
</svg>
LÃ©cithine (phosphatidylcholine)', true, 3),
  ('20000000-0000-0000-0000-000000000026', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">GalactocÃ©rÃ©broside</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">CÃ©ramide + D-Galactose</text>
  <polygon points="35,55 60,40 85,55 80,85 40,85" fill="none" stroke="#f0a500" stroke-width="2"/>
  <text x="33" y="53" font-size="9" fill="#f0a500" font-family="monospace">O</text>
  <text x="48" y="33" font-size="8" fill="#9ca3af" font-family="monospace">Gal</text>
  <line x1="82" y1="68" x2="100" y2="68" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="63" font-size="8" fill="#2dd4bf" font-family="monospace">Î²(1â†’1)</text>
  <text x="110" y="60" font-size="8" fill="#34d399" font-family="monospace">CÃ©ramide</text>
  <text x="110" y="75" font-size="8" fill="#9ca3af" font-family="monospace">(sphingosine</text>
  <text x="110" y="88" font-size="8" fill="#9ca3af" font-family="monospace">+ AG)</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">Lipide non phosphorÃ©</text>
  <text x="5" y="125" font-size="8" fill="#34d399" font-family="monospace">1 ose = D-galactose</text>
  <text x="5" y="138" font-size="8" fill="#f0a500" font-family="monospace">Tissu nerveux</text>
</svg>
GalactocÃ©rÃ©broside', false, 4),
  ('20000000-0000-0000-0000-000000000027', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Acide StÃ©arique C18</text>
  <text x="5" y="30" font-size="9" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“(CHâ‚‚)â‚â‚†â€“COOH</text>
  <line x1="10" y1="52" x2="210" y2="52" stroke="#9ca3af" stroke-width="1"/>
  <text x="5" y="65" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="28" y1="52" x2="40" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="40" y1="64" x2="52" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="52" y1="52" x2="64" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="64" y1="64" x2="76" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="76" y1="52" x2="88" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="88" y1="64" x2="100" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="100" y1="52" x2="112" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="112" y1="64" x2="124" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="124" y1="52" x2="136" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="136" y1="64" x2="148" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="148" y1="52" x2="160" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="160" y="48" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="95" font-size="8" fill="#6b7a99" font-family="monospace">AG saturÃ© C18 â€” solide</text>
  <text x="5" y="110" font-size="8" fill="#2dd4bf" font-family="monospace">Point de fusion Ã©levÃ©</text>
</svg>
Acide stÃ©arique C18', false, 1),
  ('20000000-0000-0000-0000-000000000027', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Ac. Palmitique C16</text>
  <text x="5" y="32" font-size="9" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“(CHâ‚‚)â‚â‚„â€“COOH</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="65" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="50" x2="42" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="62" x2="54" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="50" x2="66" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="62" x2="78" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="50" x2="90" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="62" x2="102" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="102" y1="50" x2="114" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="62" x2="126" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="50" x2="138" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="62" x2="150" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="50" x2="165" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="45" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire saturÃ©e</text>
  <text x="5" y="113" font-size="8" fill="#6b7a99" font-family="monospace">Pas de double liaison</text>
  <text x="5" y="130" font-size="8" fill="#f0a500" font-family="monospace">Solide Ã  TÂ° ambiante</text>
</svg>
Acide palmitique C16', false, 2),
  ('20000000-0000-0000-0000-000000000027', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Ac. OlÃ©ique C18:Î”9</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚ƒ(CHâ‚‚)â‚‡â€“CH=CHâ€“(CHâ‚‚)â‚‡COOH</text>
  <line x1="10" y1="48" x2="95" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="63" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="48" x2="42" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="60" x2="54" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="48" x2="66" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="60" x2="78" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="48" x2="90" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="60" x2="102" y2="48" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="90" y1="56" x2="102" y2="44" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="36" font-size="9" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="102" y1="48" x2="114" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="60" x2="126" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="48" x2="138" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="60" x2="150" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="48" x2="165" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="44" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">1 double liaison cis en C9</text>
  <text x="5" y="115" font-size="8" fill="#2dd4bf" font-family="monospace">Liquide Ã  TÂ° ambiante</text>
</svg>
Acide olÃ©ique C18:1', false, 3),
  ('20000000-0000-0000-0000-000000000027', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Acide Butyrique C4</text>
  <text x="5" y="35" font-size="12" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“CHâ‚‚â€“CHâ‚‚â€“COOH</text>
  <text x="5" y="60" font-size="9" fill="#f0a500" font-family="monospace">C1</text>
  <line x1="20" y1="70" x2="55" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="56" y="65" font-size="9" fill="#9ca3af" font-family="monospace">C2</text>
  <line x1="70" y1="70" x2="105" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="65" font-size="9" fill="#9ca3af" font-family="monospace">C3</text>
  <line x1="120" y1="70" x2="155" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="156" y="65" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="15" y="90" font-size="9" fill="#f0a500" font-family="monospace">CHâ‚ƒ</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">Plus petit AG des lipides</text>
  <text x="5" y="128" font-size="8" fill="#6b7a99" font-family="monospace">PrÃ©sent dans le beurre</text>
</svg>
Acide butyrique C4', true, 4),
  ('20000000-0000-0000-0000-000000000028', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Acide Butyrique C4</text>
  <text x="5" y="35" font-size="12" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“CHâ‚‚â€“CHâ‚‚â€“COOH</text>
  <text x="5" y="60" font-size="9" fill="#f0a500" font-family="monospace">C1</text>
  <line x1="20" y1="70" x2="55" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="56" y="65" font-size="9" fill="#9ca3af" font-family="monospace">C2</text>
  <line x1="70" y1="70" x2="105" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="106" y="65" font-size="9" fill="#9ca3af" font-family="monospace">C3</text>
  <line x1="120" y1="70" x2="155" y2="70" stroke="#9ca3af" stroke-width="2"/>
  <text x="156" y="65" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="15" y="90" font-size="9" fill="#f0a500" font-family="monospace">CHâ‚ƒ</text>
  <text x="5" y="115" font-size="8" fill="#6b7a99" font-family="monospace">Plus petit AG des lipides</text>
  <text x="5" y="128" font-size="8" fill="#6b7a99" font-family="monospace">PrÃ©sent dans le beurre</text>
</svg>
Acide butyrique C4:0', false, 1),
  ('20000000-0000-0000-0000-000000000028', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Acide StÃ©arique C18</text>
  <text x="5" y="30" font-size="9" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“(CHâ‚‚)â‚â‚†â€“COOH</text>
  <line x1="10" y1="52" x2="210" y2="52" stroke="#9ca3af" stroke-width="1"/>
  <text x="5" y="65" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="28" y1="52" x2="40" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="40" y1="64" x2="52" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="52" y1="52" x2="64" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="64" y1="64" x2="76" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="76" y1="52" x2="88" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="88" y1="64" x2="100" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="100" y1="52" x2="112" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="112" y1="64" x2="124" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="124" y1="52" x2="136" y2="64" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="136" y1="64" x2="148" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="148" y1="52" x2="160" y2="52" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="160" y="48" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="95" font-size="8" fill="#6b7a99" font-family="monospace">AG saturÃ© C18 â€” solide</text>
  <text x="5" y="110" font-size="8" fill="#2dd4bf" font-family="monospace">Point de fusion Ã©levÃ©</text>
</svg>
Acide stÃ©arique C18:0', true, 2),
  ('20000000-0000-0000-0000-000000000028', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Ac. OlÃ©ique C18:Î”9</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚ƒ(CHâ‚‚)â‚‡â€“CH=CHâ€“(CHâ‚‚)â‚‡COOH</text>
  <line x1="10" y1="48" x2="95" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="63" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="48" x2="42" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="60" x2="54" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="48" x2="66" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="60" x2="78" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="48" x2="90" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="60" x2="102" y2="48" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="90" y1="56" x2="102" y2="44" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="36" font-size="9" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="102" y1="48" x2="114" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="60" x2="126" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="48" x2="138" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="60" x2="150" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="48" x2="165" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="44" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">1 double liaison cis en C9</text>
  <text x="5" y="115" font-size="8" fill="#2dd4bf" font-family="monospace">Liquide Ã  TÂ° ambiante</text>
</svg>
Acide olÃ©ique C18:1', false, 3),
  ('20000000-0000-0000-0000-000000000028', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Ac. LinolÃ©ique C18:Î”9,12</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">2 doubles liaisons</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="0.8" stroke-dasharray="2,2"/>
  <line x1="10" y1="55" x2="55" y2="55" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="55" y1="55" x2="68" y2="42" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="58" y1="55" x2="71" y2="42" stroke="#2dd4bf" stroke-width="2"/>
  <text x="60" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="68" y1="42" x2="105" y2="42" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="105" y1="42" x2="118" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="108" y1="42" x2="121" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <text x="110" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">Î”12</text>
  <line x1="118" y1="55" x2="155" y2="55" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="157" y="59" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="80" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">Ac. gras essentiel (omÃ©ga-6)</text>
  <text x="5" y="125" font-size="8" fill="#2dd4bf" font-family="monospace">Point de fusion trÃ¨s bas</text>
</svg>
Acide linolÃ©ique C18:2', false, 4),
  ('20000000-0000-0000-0000-000000000029', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">MonoglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 1 AG esterifiÃ©</text>
</svg>
MonoglycÃ©ride', false, 1),
  ('20000000-0000-0000-0000-000000000029', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">TriglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="30" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="75" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="30" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="75" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="30" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="75" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="75" y="90" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚ƒ</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 3 AG esterifiÃ©s</text>
</svg>
TriglycÃ©ride', false, 2),
  ('20000000-0000-0000-0000-000000000029', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">DiglycÃ©ride</text>
  <line x1="55" y1="25" x2="55" y2="110" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="40" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="37" x2="72" y2="37" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="40" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚</text>
  <text x="28" y="65" font-size="9" fill="#9ca3af" font-family="monospace">HC</text>
  <line x1="47" y1="62" x2="72" y2="62" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="65" font-size="9" fill="#34d399" font-family="monospace">Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="90" font-size="9" fill="#9ca3af" font-family="monospace">Hâ‚‚C</text>
  <line x1="52" y1="87" x2="72" y2="87" stroke="#9ca3af" stroke-width="1.3"/>
  <text x="72" y="90" font-size="9" fill="#f0a500" font-family="monospace">OH</text>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">GlycÃ©rol + 2 AG esterifiÃ©s</text>
</svg>
DiglycÃ©ride', true, 3),
  ('20000000-0000-0000-0000-000000000029', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">PhosphoglycÃ©ride</text>
  <line x1="55" y1="22" x2="55" y2="112" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="28" y="38" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“COâ€“Râ‚</text>
  <text x="5" y="51" font-size="7" fill="#f0a500" font-family="monospace">pÃ´le hydrophobe</text>
  <text x="28" y="66" font-size="8" fill="#9ca3af" font-family="monospace">HCâ€“Oâ€“COâ€“Râ‚‚</text>
  <text x="28" y="88" font-size="8" fill="#9ca3af" font-family="monospace">Hâ‚‚Câ€“Oâ€“POâ‚„â€“X</text>
  <text x="5" y="101" font-size="7" fill="#2dd4bf" font-family="monospace">pÃ´le hydrophile</text>
  <line x1="8" y1="72" x2="20" y2="72" stroke="#f0a500" stroke-width="1.5"/>
  <line x1="8" y1="92" x2="20" y2="92" stroke="#2dd4bf" stroke-width="1.5"/>
  <text x="5" y="125" font-size="8" fill="#6b7a99" font-family="monospace">2 AG + glycÃ©rol + acide phosphorique</text>
</svg>
GlycÃ©rophospholipide', false, 4),
  ('20000000-0000-0000-0000-000000000030', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#2dd4bf" font-family="monospace">Ac. OlÃ©ique C18:Î”9</text>
  <text x="5" y="28" font-size="8" fill="#9ca3af" font-family="monospace">CHâ‚ƒ(CHâ‚‚)â‚‡â€“CH=CHâ€“(CHâ‚‚)â‚‡COOH</text>
  <line x1="10" y1="48" x2="95" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="63" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="48" x2="42" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="60" x2="54" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="48" x2="66" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="60" x2="78" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="48" x2="90" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="60" x2="102" y2="48" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="90" y1="56" x2="102" y2="44" stroke="#2dd4bf" stroke-width="2"/>
  <text x="95" y="36" font-size="9" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="102" y1="48" x2="114" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="60" x2="126" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="48" x2="138" y2="60" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="60" x2="150" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="48" x2="165" y2="48" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="44" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">1 double liaison cis en C9</text>
  <text x="5" y="115" font-size="8" fill="#2dd4bf" font-family="monospace">Liquide Ã  TÂ° ambiante</text>
</svg>
Acide olÃ©ique C18:1 Î”9', false, 1),
  ('20000000-0000-0000-0000-000000000030', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#34d399" font-family="monospace">Ac. LinolÃ©ique C18:Î”9,12</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">2 doubles liaisons</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="0.8" stroke-dasharray="2,2"/>
  <line x1="10" y1="55" x2="55" y2="55" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="55" y1="55" x2="68" y2="42" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="58" y1="55" x2="71" y2="42" stroke="#2dd4bf" stroke-width="2"/>
  <text x="60" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">Î”9</text>
  <line x1="68" y1="42" x2="105" y2="42" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="105" y1="42" x2="118" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <line x1="108" y1="42" x2="121" y2="55" stroke="#2dd4bf" stroke-width="2"/>
  <text x="110" y="38" font-size="8" fill="#2dd4bf" font-family="monospace">Î”12</text>
  <line x1="118" y1="55" x2="155" y2="55" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="157" y="59" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="80" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <text x="5" y="110" font-size="8" fill="#6b7a99" font-family="monospace">Ac. gras essentiel (omÃ©ga-6)</text>
  <text x="5" y="125" font-size="8" fill="#2dd4bf" font-family="monospace">Point de fusion trÃ¨s bas</text>
</svg>
Acide linolÃ©ique C18:2 Î”9,12', true, 2),
  ('20000000-0000-0000-0000-000000000030', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f87171" font-family="monospace">Ac. Arachidonique C20:Î”5,8,11,14</text>
  <text x="5" y="27" font-size="8" fill="#9ca3af" font-family="monospace">4 doubles liaisons</text>
  <line x1="5" y1="50" x2="30" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="30" y1="50" x2="45" y2="38" stroke="#f87171" stroke-width="2"/>
  <line x1="33" y1="50" x2="48" y2="38" stroke="#f87171" stroke-width="2"/>
  <text x="36" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”5</text>
  <line x1="45" y1="38" x2="70" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="70" y1="38" x2="85" y2="50" stroke="#f87171" stroke-width="2"/>
  <line x1="73" y1="38" x2="88" y2="50" stroke="#f87171" stroke-width="2"/>
  <text x="75" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”8</text>
  <line x1="85" y1="50" x2="110" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="110" y1="50" x2="125" y2="38" stroke="#f87171" stroke-width="2"/>
  <line x1="113" y1="50" x2="128" y2="38" stroke="#f87171" stroke-width="2"/>
  <text x="115" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”11</text>
  <line x1="125" y1="38" x2="150" y2="38" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="150" y1="38" x2="165" y2="50" stroke="#f87171" stroke-width="2"/>
  <line x1="153" y1="38" x2="168" y2="50" stroke="#f87171" stroke-width="2"/>
  <text x="152" y="34" font-size="7" fill="#f87171" font-family="monospace">Î”14</text>
  <line x1="165" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="5" y="75" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€ COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">OmÃ©ga-6, prÃ©curseur prostaglandines</text>
  <text x="5" y="115" font-size="8" fill="#f87171" font-family="monospace">C20 â€” AG polyinsaturÃ©</text>
</svg>
Acide arachidonique C20:4', false, 3),
  ('20000000-0000-0000-0000-000000000030', '<svg viewBox="0 0 220 140" xmlns="http://www.w3.org/2000/svg"><rect width="220" height="140" fill="#181d2e" rx="8"/>
  <text x="5" y="14" font-size="9" fill="#f0a500" font-family="monospace">Ac. Palmitique C16</text>
  <text x="5" y="32" font-size="9" fill="#9ca3af" font-family="monospace">CHâ‚ƒâ€“(CHâ‚‚)â‚â‚„â€“COOH</text>
  <line x1="10" y1="50" x2="210" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="5" y="65" font-size="8" fill="#34d399" font-family="monospace">CHâ‚ƒ</text>
  <line x1="30" y1="50" x2="42" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="42" y1="62" x2="54" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="54" y1="50" x2="66" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="66" y1="62" x2="78" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="78" y1="50" x2="90" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="90" y1="62" x2="102" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="102" y1="50" x2="114" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="114" y1="62" x2="126" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="126" y1="50" x2="138" y2="62" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="138" y1="62" x2="150" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <line x1="150" y1="50" x2="165" y2="50" stroke="#9ca3af" stroke-width="1.2"/>
  <text x="165" y="45" font-size="9" fill="#34d399" font-family="monospace">COOH</text>
  <text x="5" y="100" font-size="8" fill="#6b7a99" font-family="monospace">ChaÃ®ne linÃ©aire saturÃ©e</text>
  <text x="5" y="113" font-size="8" fill="#6b7a99" font-family="monospace">Pas de double liaison</text>
  <text x="5" y="130" font-size="8" fill="#f0a500" font-family="monospace">Solide Ã  TÂ° ambiante</text>
</svg>
Acide palmitique C16:0', false, 4),
  ('20000000-0000-0000-0000-000000000031', 'Lipides composÃ©s (hÃ©tÃ©rolipides)', false, 1),
  ('20000000-0000-0000-0000-000000000031', 'Lipides de rÃ©serve (glycÃ©rides)', false, 2),
  ('20000000-0000-0000-0000-000000000031', 'Lipides simples (homolipides)', true, 3),
  ('20000000-0000-0000-0000-000000000031', 'Lipides membranaires (phospholipides)', false, 4),
  ('20000000-0000-0000-0000-000000000032', 'Les glycÃ©rides (triglycÃ©rides)', false, 1),
  ('20000000-0000-0000-0000-000000000032', 'Les cires', false, 2),
  ('20000000-0000-0000-0000-000000000032', 'Les phospholipides, galactolipides et sulfolipides', true, 3),
  ('20000000-0000-0000-0000-000000000032', 'Les terpÃ¨nes', false, 4),
  ('20000000-0000-0000-0000-000000000033', 'Ã€ partir de C4', false, 1),
  ('20000000-0000-0000-0000-000000000033', 'Ã€ partir de C8', true, 2),
  ('20000000-0000-0000-0000-000000000033', 'Ã€ partir de C16', false, 3),
  ('20000000-0000-0000-0000-000000000033', 'Ils sont tous solubles dans l''eau', false, 4),
  ('20000000-0000-0000-0000-000000000034', 'L''hydrolyse enzymatique par les lipases', false, 1),
  ('20000000-0000-0000-0000-000000000034', 'L''oxydation spontanÃ©e des acides gras insaturÃ©s Ã  l''air', true, 2),
  ('20000000-0000-0000-0000-000000000034', 'La saponification par la soude', false, 3),
  ('20000000-0000-0000-0000-000000000034', 'La rÃ©action avec l''iode', false, 4),
  ('20000000-0000-0000-0000-000000000035', 'Du glycÃ©rol + acides gras libres', false, 1),
  ('20000000-0000-0000-0000-000000000035', 'Du glycÃ©rol + sels de sodium', false, 2),
  ('20000000-0000-0000-0000-000000000035', 'Des esters mÃ©thyliques d''AG + glycÃ©rol', true, 3),
  ('20000000-0000-0000-0000-000000000035', 'Du savon + eau', false, 4),
  ('20000000-0000-0000-0000-000000000036', 'Les AG courts (C4)', false, 1),
  ('20000000-0000-0000-0000-000000000036', 'Les AG Ã  longue chaÃ®ne et insaturÃ©s', true, 2),
  ('20000000-0000-0000-0000-000000000036', 'Les AG saturÃ©s Ã  courte chaÃ®ne', false, 3),
  ('20000000-0000-0000-0000-000000000036', 'Tous sortent en mÃªme temps', false, 4),
  ('20000000-0000-0000-0000-000000000037', 'Les membranes des cellules vÃ©gÃ©tales', false, 1),
  ('20000000-0000-0000-0000-000000000037', 'Les membranes bactÃ©riennes et des mitochondries cardiaques', true, 2),
  ('20000000-0000-0000-0000-000000000037', 'Le cytoplasme des neurones', false, 3),
  ('20000000-0000-0000-0000-000000000037', 'La surface des globules rouges', false, 4),
  ('20000000-0000-0000-0000-000000000038', 'GlycÃ©rides', false, 1),
  ('20000000-0000-0000-0000-000000000038', 'Phospholipides', false, 2),
  ('20000000-0000-0000-0000-000000000038', 'TerpÃ¨nes (lipides polyisoprÃ©niques)', true, 3),
  ('20000000-0000-0000-0000-000000000038', 'Sphingolipides', false, 4),
  ('20000000-0000-0000-0000-000000000039', 'Le tissu adipeux uniquement', false, 1),
  ('20000000-0000-0000-0000-000000000039', 'Le tissu nerveux et musculaire, et dans le plasma sanguin', true, 2),
  ('20000000-0000-0000-0000-000000000039', 'Uniquement dans les bactÃ©ries', false, 3),
  ('20000000-0000-0000-0000-000000000039', 'Le tissu osseux', false, 4),
  ('20000000-0000-0000-0000-000000000040', 'Vitamines liposolubles', false, 1),
  ('20000000-0000-0000-0000-000000000040', 'Pigments (lipides riches en doubles liaisons conjuguÃ©es)', true, 2),
  ('20000000-0000-0000-0000-000000000040', 'Acides gras essentiels', false, 3),
  ('20000000-0000-0000-0000-000000000040', 'CÃ©rÃ©brosides', false, 4),
  ('40000000-0000-0000-0000-000000000001', 'Bronches', false, 1),
  ('40000000-0000-0000-0000-000000000001', 'Alveoles', true, 2),
  ('40000000-0000-0000-0000-000000000001', 'Trachee', false, 3),
  ('40000000-0000-0000-0000-000000000001', 'Plevre', false, 4),
  ('40000000-0000-0000-0000-000000000002', 'Transporter l''oxygene', false, 1),
  ('40000000-0000-0000-0000-000000000002', 'Reduire la tension superficielle dans les alveoles', true, 2),
  ('40000000-0000-0000-0000-000000000002', 'Proteger les bronches des infections', false, 3),
  ('40000000-0000-0000-0000-000000000002', 'Produire du mucus', false, 4),
  ('40000000-0000-0000-0000-000000000003', 'Pneumocyte de type I', false, 1),
  ('40000000-0000-0000-0000-000000000003', 'Pneumocyte de type II', true, 2),
  ('40000000-0000-0000-0000-000000000003', 'Macrophage alveolaire', false, 3),
  ('40000000-0000-0000-0000-000000000003', 'Cellule ciliee', false, 4),
  ('40000000-0000-0000-0000-000000000004', 'Cartilage', false, 1),
  ('40000000-0000-0000-0000-000000000004', 'Capillaires pulmonaires', true, 2),
  ('40000000-0000-0000-0000-000000000004', 'Bronchioles', false, 3),
  ('40000000-0000-0000-0000-000000000004', 'Membrane basale epaisse', false, 4),
  ('40000000-0000-0000-0000-000000000005', 'Muscles intercostaux externes', false, 1),
  ('40000000-0000-0000-0000-000000000005', 'Diaphragme', true, 2),
  ('40000000-0000-0000-0000-000000000005', 'Sternocleidomastoidien', false, 3),
  ('40000000-0000-0000-0000-000000000005', 'Scalenes', false, 4),
  ('40000000-0000-0000-0000-000000000006', 'Cortex moteur', false, 1),
  ('40000000-0000-0000-0000-000000000006', 'Bulbe rachidien', true, 2),
  ('40000000-0000-0000-0000-000000000006', 'Hypothalamus', false, 3),
  ('40000000-0000-0000-0000-000000000006', 'Moelle epiniere lombaire', false, 4),
  ('40000000-0000-0000-0000-000000000007', 'La cage thoracique', false, 1),
  ('40000000-0000-0000-0000-000000000007', 'Les poumons', true, 2),
  ('40000000-0000-0000-0000-000000000007', 'Le diaphragme', false, 3),
  ('40000000-0000-0000-0000-000000000007', 'Les bronches', false, 4),
  ('40000000-0000-0000-0000-000000000008', 'Dissous dans le plasma', false, 1),
  ('40000000-0000-0000-0000-000000000008', 'Combine a l''hemoglobine', false, 2),
  ('40000000-0000-0000-0000-000000000008', 'Sous forme de bicarbonate', true, 3),
  ('40000000-0000-0000-0000-000000000008', 'Sous forme de carbone libre', false, 4),
  ('40000000-0000-0000-0000-000000000009', 'Plasma libre', false, 1),
  ('40000000-0000-0000-0000-000000000009', 'Hemoglobine', true, 2),
  ('40000000-0000-0000-0000-000000000009', 'Leucocytes', false, 3),
  ('40000000-0000-0000-0000-000000000009', 'Plaquettes', false, 4),
  ('40000000-0000-0000-0000-000000000010', 'Oxygene', false, 1),
  ('40000000-0000-0000-0000-000000000010', 'Dioxyde de carbone', true, 2),
  ('40000000-0000-0000-0000-000000000010', 'Azote', false, 3),
  ('40000000-0000-0000-0000-000000000010', 'Methane', false, 4),
  ('40000000-0000-0000-0000-000000000011', 'Produire du surfactant', false, 1),
  ('40000000-0000-0000-0000-000000000011', 'Detruire les particules etrangeres', true, 2),
  ('40000000-0000-0000-0000-000000000011', 'Transporter l''oxygene', false, 3),
  ('40000000-0000-0000-0000-000000000011', 'Secreter du mucus', false, 4),
  ('40000000-0000-0000-0000-000000000012', 'Bronches principales', false, 1),
  ('40000000-0000-0000-0000-000000000012', 'Alveoles', false, 2),
  ('40000000-0000-0000-0000-000000000012', 'Bronchioles respiratoires', true, 3),
  ('40000000-0000-0000-0000-000000000012', 'Trachee', false, 4),
  ('40000000-0000-0000-0000-000000000013', 'Inspiration', true, 1),
  ('40000000-0000-0000-0000-000000000013', 'Expiration', false, 2),
  ('40000000-0000-0000-0000-000000000013', 'Repos', false, 3),
  ('40000000-0000-0000-0000-000000000013', 'Apnee', false, 4),
  ('40000000-0000-0000-0000-000000000014', 'Active', false, 1),
  ('40000000-0000-0000-0000-000000000014', 'Hormonale', false, 2),
  ('40000000-0000-0000-0000-000000000014', 'Volontaire', false, 3),
  ('40000000-0000-0000-0000-000000000014', 'Passive', true, 4),
  ('40000000-0000-0000-0000-000000000015', 'Le larynx', false, 1),
  ('40000000-0000-0000-0000-000000000015', 'La trachee', true, 2),
  ('40000000-0000-0000-0000-000000000015', 'Le pharynx', false, 3),
  ('40000000-0000-0000-0000-000000000015', 'Le nez', false, 4),
  ('40000000-0000-0000-0000-000000000016', 'Volume courant (VC)', true, 1),
  ('40000000-0000-0000-0000-000000000016', 'Volume residuel (VR)', false, 2),
  ('40000000-0000-0000-0000-000000000016', 'Volume de reserve inspiratoire (VRI)', false, 3),
  ('40000000-0000-0000-0000-000000000016', 'Capacite vitale (CV)', false, 4),
  ('40000000-0000-0000-0000-000000000017', 'L''oesophage', false, 1),
  ('40000000-0000-0000-0000-000000000017', 'Les capillaires pulmonaires', false, 2),
  ('40000000-0000-0000-0000-000000000017', 'La trachee', true, 3),
  ('40000000-0000-0000-0000-000000000017', 'Les bronchioles', false, 4),
  ('40000000-0000-0000-0000-000000000018', 'Le volume d''air dans les voies de conduction qui ne participe pas aux echanges gazeux', true, 1),
  ('40000000-0000-0000-0000-000000000018', 'Une zone pulmonaire detruite par une pathologie', false, 2),
  ('40000000-0000-0000-0000-000000000018', 'Le volume d''air restant apres une expiration forcee', false, 3),
  ('40000000-0000-0000-0000-000000000018', 'L''espace entre les deux feuillets de la plevre', false, 4),
  ('40000000-0000-0000-0000-000000000019', 'La tension superficielle', false, 1),
  ('40000000-0000-0000-0000-000000000019', 'La surface disponible et l''epaisseur de la membrane', true, 2),
  ('40000000-0000-0000-0000-000000000019', 'La presence de macrophages', false, 3),
  ('40000000-0000-0000-0000-000000000019', 'La secretion de mucus', false, 4),
  ('40000000-0000-0000-0000-000000000020', 'Epithelium squameux stratifie', false, 1),
  ('40000000-0000-0000-0000-000000000020', 'Epithelium pseudo-stratifie cilie avec cellules caliciformes', true, 2),
  ('40000000-0000-0000-0000-000000000020', 'Epithelium cubique simple', false, 3),
  ('40000000-0000-0000-0000-000000000020', 'Epithelium cylindrique simple', false, 4),
  ('40000000-0000-0000-0000-000000000021', 'Une augmentation de l''affinite de l''hemoglobine pour l''oxygene', false, 1),
  ('40000000-0000-0000-0000-000000000021', 'Une baisse du 2,3-DPG', false, 2),
  ('40000000-0000-0000-0000-000000000021', 'Une diminution de la temperature corporelle', false, 3),
  ('40000000-0000-0000-0000-000000000021', 'Une baisse du pH sanguin (acidose)', true, 4),
  ('40000000-0000-0000-0000-000000000022', 'Les peripheriques ne sont sensibles qu au pH', false, 1),
  ('40000000-0000-0000-0000-000000000022', 'Les centraux reagissent plus rapidement que les peripheriques', false, 2),
  ('40000000-0000-0000-0000-000000000022', 'Les peripheriques sont les seuls sensibles a une baisse directe de la PaO2', true, 3),
  ('40000000-0000-0000-0000-000000000022', 'Les centraux sont situes dans les corps carotidiens', false, 4),
  ('40000000-0000-0000-0000-000000000023', 'Volume de reserve expiratoire + volume residuel', true, 1),
  ('40000000-0000-0000-0000-000000000023', 'Volume courant + volume de reserve expiratoire', false, 2),
  ('40000000-0000-0000-0000-000000000023', 'Volume de reserve inspiratoire + volume courant', false, 3),
  ('40000000-0000-0000-0000-000000000023', 'Volume residuel + capacite vitale', false, 4),
  ('40000000-0000-0000-0000-000000000024', 'La ventilation y est maximale', false, 1),
  ('40000000-0000-0000-0000-000000000024', 'Il n''y a pas d''alveoles a l''apex', false, 2),
  ('40000000-0000-0000-0000-000000000024', 'Le surfactant y est absent', false, 3),
  ('40000000-0000-0000-0000-000000000024', 'La gravite reduit massivement la perfusion a l''apex', true, 4),
  ('40000000-0000-0000-0000-000000000025', 'Loi de Poiseuille', false, 1),
  ('40000000-0000-0000-0000-000000000025', 'Loi de Henry', false, 2),
  ('40000000-0000-0000-0000-000000000025', 'Loi de Dalton', false, 3),
  ('40000000-0000-0000-0000-000000000025', 'Loi de Fick', true, 4),
  ('40000000-0000-0000-0000-000000000026', 'Anemie severe', false, 1),
  ('40000000-0000-0000-0000-000000000026', 'Syndrome obstructif (ex : asthme)', true, 2),
  ('40000000-0000-0000-0000-000000000026', 'Syndrome restrictif (ex : fibrose)', false, 3),
  ('40000000-0000-0000-0000-000000000026', 'Embolie pulmonaire', false, 4),
  ('40000000-0000-0000-0000-000000000027', 'Toujours egale a la pression alveolaire', false, 1),
  ('40000000-0000-0000-0000-000000000027', 'Positive par rapport a la pression atmospherique', false, 2),
  ('40000000-0000-0000-0000-000000000027', 'Negative (subatmospherique)', true, 3),
  ('40000000-0000-0000-0000-000000000027', 'Nulle', false, 4),
  ('40000000-0000-0000-0000-000000000028', 'Augmente la concentration de protons (H+)', false, 1),
  ('40000000-0000-0000-0000-000000000028', 'Provoque une alcalose respiratoire', true, 2),
  ('40000000-0000-0000-0000-000000000028', 'N''a aucun effet sur le pH', false, 3),
  ('40000000-0000-0000-0000-000000000028', 'Provoque une acidose respiratoire', false, 4),
  ('40000000-0000-0000-0000-000000000029', 'Une inhibition des secretions de mucus', false, 1),
  ('40000000-0000-0000-0000-000000000029', 'Une acceleration du rythme respiratoire', false, 2),
  ('40000000-0000-0000-0000-000000000029', 'Une bronchoconstriction', true, 3),
  ('40000000-0000-0000-0000-000000000029', 'Une bronchodilatation', false, 4),
  ('40000000-0000-0000-0000-000000000030', 'L''epiglotte', true, 1),
  ('40000000-0000-0000-0000-000000000030', 'Le cartilage cricoide', false, 2),
  ('40000000-0000-0000-0000-000000000030', 'Les cordes vocales', false, 3),
  ('40000000-0000-0000-0000-000000000030', 'La glotte', false, 4),
  ('40000000-0000-0000-0000-000000000031', '40 mmHg', false, 1),
  ('40000000-0000-0000-0000-000000000031', '760 mmHg', false, 2),
  ('40000000-0000-0000-0000-000000000031', '100 mmHg', true, 3),
  ('40000000-0000-0000-0000-000000000031', '160 mmHg', false, 4),
  ('40000000-0000-0000-0000-000000000032', 'Elle diminue fortement', false, 1),
  ('40000000-0000-0000-0000-000000000032', 'Elle reste parfaitement identique au repos', false, 2),
  ('40000000-0000-0000-0000-000000000032', 'Elle depasse la pression arterielle systemique', false, 3),
  ('40000000-0000-0000-0000-000000000032', 'Elle augmente legerement grace au recrutement de capillaires', true, 4)
on conflict (question_id, option_order) do update set
  option_text = excluded.option_text,
  is_correct = excluded.is_correct;

insert into question_items (question_id, label, correct_answer, position_x, position_y, item_order)
values
  ('30000000-0000-0000-0000-000000000001', 'Reponse', 'Le cÂœur.', null, null, 1),
  ('30000000-0000-0000-0000-000000000002', 'Reponse', '4 cavitÃ©s.', null, null, 1),
  ('30000000-0000-0000-0000-000000000003', 'Reponse', 'Les oreillettes.', null, null, 1),
  ('30000000-0000-0000-0000-000000000004', 'Reponse', 'Les ventricules.', null, null, 1),
  ('30000000-0000-0000-0000-000000000005', 'Reponse', 'Les artÃ¨res.', null, null, 1),
  ('30000000-0000-0000-0000-000000000006', 'Reponse', 'Les veines.', null, null, 1),
  ('30000000-0000-0000-0000-000000000007', 'Reponse', 'Transporter lÂ’oxygÃ¨ne, les nutriments et Ã©liminer les dÃ©chets.', null, null, 1),
  ('30000000-0000-0000-0000-000000000008', 'Reponse', 'La valve mitrale.', null, null, 1),
  ('30000000-0000-0000-0000-000000000009', 'Reponse', 'LÂ’aorte.', null, null, 1),
  ('30000000-0000-0000-0000-000000000010', 'Reponse', 'Le cÃ´tÃ© gauche.', null, null, 1),
  ('31000000-0000-0000-0000-000000000001', 'Reponse', 'Le cÂœur agit comme une pompe qui propulse le sang dans tout lÂ’organisme.', null, null, 1),
  ('31000000-0000-0000-0000-000000000002', 'Reponse', 'La circulation pulmonaire La circulation systÃ©mique', null, null, 1),
  ('31000000-0000-0000-0000-000000000003', 'Reponse', 'Systole : contraction du cÂœur Diastole : relÃ¢chement et remplissage du cÂœur', null, null, 1),
  ('31000000-0000-0000-0000-000000000004', 'Reponse', 'Le dÃ©bit cardiaque est le volume de sang Ã©jectÃ© par le cÂœur en une minute.', null, null, 1),
  ('31000000-0000-0000-0000-000000000005', 'Reponse', 'DC=FCÃ—VESDC = FC \times VESDC=FCÃ—VES', null, null, 1),
  ('31000000-0000-0000-0000-000000000006', 'Reponse', 'CÂ’est le nombre de battements du cÂœur par minute.', null, null, 1),
  ('31000000-0000-0000-0000-000000000007', 'Reponse', 'CÂ’est la quantitÃ© de sang Ã©jectÃ©e par un ventricule Ã  chaque contraction.', null, null, 1),
  ('31000000-0000-0000-0000-000000000008', 'Reponse', 'Entre 60 et 100 battements par minute.', null, null, 1),
  ('31000000-0000-0000-0000-000000000009', 'Reponse', 'Force exercÃ©e par le sang sur la paroi des artÃ¨res.', null, null, 1),
  ('31000000-0000-0000-0000-000000000010', 'Reponse', 'Environ 120/80 mmHg.', null, null, 1),
  ('31000000-0000-0000-0000-000000000011', 'Reponse', 'La pression maximale lors de la contraction ventriculaire.', null, null, 1),
  ('31000000-0000-0000-0000-000000000012', 'Reponse', 'La pression minimale lors du relÃ¢chement du cÂœur.', null, null, 1),
  ('31000000-0000-0000-0000-000000000013', 'Reponse', 'EmpÃªcher le reflux du sang.', null, null, 1),
  ('31000000-0000-0000-0000-000000000014', 'Reponse', 'Le cÂœur possÃ¨de 4 cavitÃ©s : 2 oreillettes 2 ventricules', null, null, 1),
  ('31000000-0000-0000-0000-000000000015', 'Reponse', 'Il envoie le sang oxygÃ©nÃ© dans tout lÂ’organisme.', null, null, 1),
  ('31000000-0000-0000-0000-000000000016', 'Reponse', 'Il envoie le sang vers les poumons.', null, null, 1),
  ('31000000-0000-0000-0000-000000000017', 'Reponse', 'QuantitÃ© de sang revenant au cÂœur par les veines.', null, null, 1),
  ('31000000-0000-0000-0000-000000000018', 'Reponse', 'Enregistrement de lÂ’activitÃ© Ã©lectrique du cÂœur.', null, null, 1),
  ('31000000-0000-0000-0000-000000000019', 'Reponse', 'La dÃ©polarisation des oreillettes.', null, null, 1),
  ('31000000-0000-0000-0000-000000000020', 'Reponse', 'La dÃ©polarisation des ventricules.', null, null, 1),
  ('31000000-0000-0000-0000-000000000021', 'Reponse', 'La repolarisation ventriculaire.', null, null, 1),
  ('31000000-0000-0000-0000-000000000022', 'Reponse', 'Le nÂœud sinusal.', null, null, 1),
  ('31000000-0000-0000-0000-000000000023', 'Reponse', 'Ralentir la conduction Ã©lectrique entre oreillettes et ventricules.', null, null, 1),
  ('31000000-0000-0000-0000-000000000024', 'Reponse', 'Augmentation du diamÃ¨tre des vaisseaux sanguins.', null, null, 1),
  ('31000000-0000-0000-0000-000000000025', 'Reponse', 'Diminution du diamÃ¨tre des vaisseaux sanguins.', null, null, 1),
  ('31000000-0000-0000-0000-000000000026', 'Reponse', 'Ã‰tirement des fibres cardiaques avant la contraction.', null, null, 1),
  ('31000000-0000-0000-0000-000000000027', 'Reponse', 'RÃ©sistance contre laquelle le ventricule Ã©jecte le sang.', null, null, 1),
  ('31000000-0000-0000-0000-000000000028', 'Reponse', 'CapacitÃ© du muscle cardiaque Ã  se contracter.', null, null, 1),
  ('31000000-0000-0000-0000-000000000029', 'Reponse', 'Pourcentage de sang Ã©jectÃ© par le ventricule gauche Ã  chaque systole.', null, null, 1),
  ('31000000-0000-0000-0000-000000000030', 'Reponse', 'Plus le remplissage du cÂœur augmente, plus la force de contraction augmente.', null, null, 1),
  ('31000000-0000-0000-0000-000000000031', 'Reponse', 'Expansion rythmique des artÃ¨res due Ã  lÂ’Ã©jection sanguine.', null, null, 1),
  ('31000000-0000-0000-0000-000000000032', 'Reponse', 'Transporter le sang du cÂœur vers les organes.', null, null, 1),
  ('31000000-0000-0000-0000-000000000033', 'Reponse', 'Ramener le sang vers le cÂœur.', null, null, 1),
  ('31000000-0000-0000-0000-000000000034', 'Reponse', 'Permettre les Ã©changes entre le sang et les tissus.', null, null, 1),
  ('31000000-0000-0000-0000-000000000035', 'Reponse', 'Ã‰tude des mouvements du sang dans le systÃ¨me cardiovasculaire.', null, null, 1),
  ('31000000-0000-0000-0000-000000000036', 'Reponse', 'RÃ©cepteur sensible aux variations de pression artÃ©rielle.', null, null, 1),
  ('31000000-0000-0000-0000-000000000037', 'Reponse', 'Le systÃ¨me nerveux sympathique.', null, null, 1),
  ('31000000-0000-0000-0000-000000000038', 'Reponse', 'Le systÃ¨me parasympathique.', null, null, 1),
  ('31000000-0000-0000-0000-000000000039', 'Reponse', 'Dans les cavitÃ©s gauches.', null, null, 1),
  ('31000000-0000-0000-0000-000000000040', 'Reponse', 'Dans les cavites droites', null, null, 1)
on conflict (question_id, item_order) do update set
  label = excluded.label,
  correct_answer = excluded.correct_answer,
  position_x = excluded.position_x,
  position_y = excluded.position_y;
