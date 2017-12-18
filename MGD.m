clear all;
% Objectif : trouver le centre de gravité C du robot à partir des coordonnées acticulaires :
% - La position des bases des 3 membres du robot A1, A2 et A3
% - La longueur des membres A1R1, A2R2, A3R3
% - Les informations du triangle R1R2R3, organe effecteur du robot

%    A3
%    |
%    R3_
% y  |  --_
% ^  |  C  -
% |  R1-----R2
% | /        \
% A1-->x      A2

%--------------------------------------------------------------------------
%------------------------  Variables à paramétrer  ------------------------
%--------------------------------------------------------------------------

% A1, A2 et A3 sont les bases des 3 membres du robot
% Chacun de ces points est relié à R1, R2 ou R3, coins du triangle formant
% le corps du robot.
% A1 = [0 0];    % A1 se situe toujours à l'origine
% A2 = [x2 0];  % A2 a pour ordonné 0
% A3 = [x3 y3];

x2 = 15.91;
x3 = 0;
y3 = 10;

l2 = 17.04;        % Longueur R1R2
l3 = 20.84;        % Longueur R1R3
theta = 0.882603;  % Radian entre R1R2 et R1R3

% Longueur des membres au carré
p1 = 14.98^2;      % A1 - R1
p2 = 15.38^2;      % A2 - R2
p3 = 12^2;         % A3 - R3

% Chaque ligne de cette matrice donne une solution au système
% Colonne 1 : coordonnée en abscisse du barycentre de R1R2R3
% Colonne 2 : coordonnée en ordonnée du barycentre de R1R2R3
% Colonne 3 : rotation sur l'axe z du triangle
G = zeros(6,3); % G stocke les différentes solutions du MGD, 6 maximum

%--------------------------------------------------------------------------
%--------------------------- Calcul du MGD --------------------------------
%--------------------------------------------------------------------------

% Tangente de la moitié de l'angle de rotation en z du centre de gravité de R1R2R3
syms t;                

sphi = (2*t)/(1+t^2);  % sinus de l'angle de rotation en z (angle phi)
cphi= (1-t^2)/(1+t^2); % cosinus de l'angle de rotation en z (angle phi)

R = 2*l2*cphi-2*x2;
S = 2*l2*sphi;
Q = -2*x2*l2*cphi + l2^2 + x2^2;

cphit = cphi*cos(theta)-sphi*sin(theta); % cosinus de l'angle phi*theta
sphit = sphi*cos(theta)+cphi*sin(theta); % sinus de l'angle phi*theta

U = 2*l3*(cphit)-2*x3;
V = 2*l3*(sphit) -2*y3;
W = -2*y3*l3*(sphit) - 2*x3*l3*(cphit) + l3^2 + x3^2 + y3^2;

A1 = p3 - p1 - W;
A2 = p2 - p1 - Q;

SA1_VA2 = (S*A1 - V*A2);
RA1_UA2 = (R*A1 - U*A2);
RV_SU = (R*V - S*U);

% Les valeurs de t annulant l'equation sont les valeurs possibles de t dans le système défini
equation = SA1_VA2^2 + RA1_UA2^2 - p1*RV_SU^2;
simplify(equation);

P = numden(equation);  % Extraire polynome caracteristique du MGD (numérateur) du quotient
C = coeffs(P);         % Extraire coefficients du polynome caractéristique (ordonnés par degrés croissants par coeffs)
C = fliplr(C);         % Inverser la matrice (avec fliplr, coefficients ordonnés par degrés décroissants)

t_list = roots(C);     % Déterminer racines du polynome. Ces racines sont les valeurs possibles de l'angle t en radian

rotz = atan(t_list)*2; % Déterminer les angles possibles rotz en radian
s_list = size(rotz); s_list = s_list(1); % Nombre de solutions possibles

G(1:s_list,3) = rotz*180/pi; % Stocker rotation du triangle sur l'axe z en degré

for i=1:s_list % Déterminer coordonnées de R1 R2 R3
    % Déterminer point R1
    R1(i,1) = -SA1_VA2/RV_SU;
    R1(i,2) =  RA1_UA2/RV_SU;

    % Substituer la variable t par une des valeurs possibles pour cet angle
    R1(i,1:2) = subs(R1(i,1:2), t, t_list(i));

    % Positions des points R2 et R3     
    R2(i,1:2) = find_pos(R1(i,1:2), l2, rotz(i));
    R3(i,1:2) = find_pos(R1(i,1:2), l3, rotz(i)+theta);

    % Barycentre de R1R2R3
    G(i,1:2) = centroid_triangle(R1(i,1:2), R2(i,1:2), R3(i,1:2));
end

if s_list < 6
    G = G(1:s_list,1:3); % Pour que la matrice ait la bonne taille par rapport au nombre de solutions du système
end
% La solution du système est dans G.
% Si G est vide, aucune solution n'existe pour le système.