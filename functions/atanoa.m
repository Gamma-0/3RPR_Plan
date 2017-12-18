% Déterminer l'angle (en degré) d'une liaison rotoide sur le plan à partir de 2 points 
% tanoa = opposé / adjacent
function t = atanoa(P1, P2)
    x = P1(1)-P2(1);
    y = P1(2)-P2(2);
 
    t = atan2(y,x)*180/pi;
end

