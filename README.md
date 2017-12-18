# README

## Fonctionnement
Il y a deux fichiers principaux :
- MGI.m, qui calcule le modèle géométrique inverse d'un robot 3RPR
- MGD.m, qui calcule le modèle géométrique directe d'un robot 3RPR

Ces deux fichiers utilisent des fonctions, dont les fichiers sont situés dans le dossier `functions`. Il est important de bien rajouter ce répertoire dans le path de matlab pour que les fonctions puissent être utilisées. Il est aussi possible de mettre les fonctions dans le même répertoire que les programmes principaux.

Avant d'exécuter MGI.m ou MGD.m, il est possible de paramétrer des variables en début de fichier, dans la partie `Variables à paramétrer`, afin de calculer le MGI ou le MGD d'une configuration particulière. La partie `Calcul` ne doit pas être modifié.

## MGI
Limite : le MGI ne peut être calculé que pour des triangles équilatéraux.  
La solution du système est répartie dans trois variables :
- At1 pour la première liaison rotoide,
- P pour la liaison prismatique,
- At2 Pour la deuxième liaison rotoide.

## MGD
Le MGD peut être calculé pour tout type de triangle.  
Les solutions du système sont dans la variable G  et sont au nombre de 6 :
- Colonne 1 : coordonnée en abscisse du centre de gravité
- Colonne 2 : coordonnée en ordonnée du centre de gravité
- Colonne 3 : rotation sur l'axe z du triangle


## Sources

- Design and control of a three degree-of-freedom planar parallel robot, Joshi, Atul Ravindra, https://etd.ohiolink.edu/pg_10?0::NO:10:P10_ACCESSION_NUM:ohiou1175180058
- Solutions polynomiales au probleme de la cinematique directe des manipulateurs paralleles plans a trois degres de liberte, Clément Gosselin, https://www.academia.edu/12514527/Solutions_polynomiales_au_probleme_de_la_cinematique_directe_des_manipulateurs_paralleles_plans_a_trois_degres_de_liberte
