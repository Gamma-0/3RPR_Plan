% Calculer la distance P1P2 à l'aide des points P1 et P2
function L = euclidean_distance(P1, P2)
     L = sqrt((P1(1)-P2(1))^2 + (P1(2) - P2(2))^2);
end
