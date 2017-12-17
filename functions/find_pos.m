% Déterminer la position d'un point P2 à partir 
% d'un point P, d'une distance d et d'un angle t
function P2 = find_pos(P, d, t)
     P2(1) = P(1) + d*cos(t);
     P2(2) = P(2) + d*sin(t);
end
