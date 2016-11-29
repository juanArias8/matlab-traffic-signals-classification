function res = detectaBlanco( imagen )
[fil,col] = size(imagen);
res = 0;
centroX = round(fil/2);
centroY = round(col/2);
puntoX1 = centroX-4*2;
puntoY1 = centroY-7*2;
puntoX2 = centroX-7*2;
puntoY2 = centroY-4*2;
for i = puntoX1:puntoX1+8*2
    for j = puntoY1:puntoY1+14*2
        if(imagen(i,j)==1)
            res = 1;
        end
    end
end
for i = puntoX2:puntoX2+14*2
    for j = puntoY2:puntoY2+8*2
        if(imagen(i,j)==1)
            res = 1;
        end         
    end
end
end

