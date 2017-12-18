% Objectif : déterminer à partir du centre de gravité C du robot
% - Les positions des points R1, R2, et, R3
% - Les longueurs des articulations A1R1,  A2R2 et A3R3

% y
% ^
% |  A3
% |  |
% |  R3_
% |  |  --_
% |  |  C  -
% |  R1-----R2
% | /        \
% A1----------A2--->x

%--------------------------------------------------------------------------
%------------------------  Variables à paramétrer  ------------------------
%--------------------------------------------------------------------------

% A1, A2 et A3 sont les bases des 3 membres du robot
% Chacun de ces points est relié à R1, R2 ou R3, coins du triangle formant
% le corps du robot.
A1 = [0 0];   % A1 se situe toujours à l'origine
A2 = [30 0];  % A2 a pour ordonné 0
A3 = [15 30];

% Longueur des cotés du triangle (le triangle doit etre equilateral)
l = 3; 

% Coordonnées du centre de gravité du triangle R1R2R3 représentant le robot.
G = [15 ; 10];
% Angle de l'effecteur
theta = 0;

RotZ = [cos(theta) -sin(theta);
        sin(theta) cos(theta)];
    
%--------------------------------------------------------------------------
%--------------------------- Calcul du MGI --------------------------------
%--------------------------------------------------------------------------

% Définir les coordonnées de G dans un repère dont l'origine est G,
% dont l'axe des abscisses est parallèle à R1R2, 
% et l'axe des ordonnées passe par le point R3.

R1_G = [-l/2 ; -l/3];                % Déterminer point R1 dans le repère défini depuis G
R1 = G + RotZ * R1_G;                 % Coordonnées du point depuis le repère défini en A1

l1 = euclidean_distance(A1, R1); % Distance A1R1

R2_G = [l/2 ; -l/3];                % Déterminer point R2 dans le repère défini depuis G 
R2 = G + RotZ * R2_G;                % Coordonnées du point depuis le repère défini en A2

l2 = euclidean_distance(A2, R2); % Distance A2R2

R3_G = [0 ; 2*l/3];               % Déterminer point R3 dans le repère défini depuis G 
R3 = G + RotZ * R3_G;                % Coordonnées du point depuis le repère défini en A3

l3 = euclidean_distance(A3, R3); % Distance A3R3

P = [l1,l2,l3]; % Solution du MGI (longueur des articulations)
% Chaque colonne de cette matrice détermine une longueur d'articulation.
% l1 : longueur de l'articulation A1R1. 
% l2 : longueur de l'articulation A2R2. 
% l3 : longueur de l'articulation A3R3. 

a1 = atanoa(R1,A1);
a2 = atanoa(R2,A2);
a3 = atanoa(A3,R3);
At1 = [a1, a2, a3] ; % Solution du MGI (angle de la rotation de la base des membres)
% Chaque colonne de cette matrice détermine l'angle de la première rotation de chaque membre
% a1 : angle de l'axe x à A1R1. 
% a2 : angle de l'axe x à A2R2. 
% a3 : angle de l'axe -x à A3R3. 

a1 = angle_two_lines(A1, R1, R1, G);
a2 = angle_two_lines(A2, R2, R2, G);
a3 = angle_two_lines(A3, R3, R3, G); 
At2 = [a1, a2, a3]; % Solution du MGI (angle de la rotation au niveau du corps de robot)
% Chaque colonne de cette matrice détermine l'angle de la deuxième rotation de chaque membre 
% a1 : angle de A1R1 à R1G.
% a2 : angle de A2R2 à R2G.
% a3 : angle de A3R3 à R3G.

% La solution du système est dans :
% At1 (liaison rotoide 1),
% P (liaison prismatique),
% et At2 (liaison rotoide 2).
