% Déterminer l'angle d'une liaison rotoide sur le plan à partir de 2 points 
% tanoa = opposé / adjacent
function t = atanoa(P1, P2)
    x = P1(1)-P2(1);
    y = P1(2)-P2(2);
 
    t=0;
    
    if x > 0 && y > 0
      t = atan(y/x)*180/pi;
    elseif x < 0 && y < 0
      t = atan(y/x)*180/pi - 180;
    elseif x < 0 && y > 0
      t = 180 - atan(y/-x)*180/pi;
    elseif x > 0 && y < 0
      t = - atan(-y/x)*180/pi;
    elseif x == 0 && y > 0
      t = 90;
    elseif x == 0 && y < 0
      t = -90;
    elseif y == 0 && x < 0
        t = 180;
     else
        t = 0;
    end
end

