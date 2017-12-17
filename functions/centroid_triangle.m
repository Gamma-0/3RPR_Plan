% Calculer le barycentre d'un triangle à l'aide de
% la position de ses trois points P1, P2 et P3
function C = centroid_triangle(P1, P2, P3)
     C(1) = (P1(1) + P2(1) + P3(1))/3;
     C(2) = (P1(2) + P2(2) + P3(2))/3;
end
