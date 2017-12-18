% Déterminer l'angle (en degré) entre deux vecteurs  à partir de 4 points
% Les deux premiers points forment le premier vecteur
% Les deux points suivant forment le second vecteur
function t = angle_two_lines(P1, P2, P3, P4)
    u = P2(1)-P1(1);
    v = P2(2)-P1(2);
 
    u2 = P4(1)-P3(1);
    v2 = P4(2)-P3(2);
    
    t = atan2((u*v2 - u2*v),(u*u2 + v*v2))*180/pi;
end

