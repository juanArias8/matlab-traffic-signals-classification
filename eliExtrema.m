function recortada = eliExtrema(imagen)
[fil,col] = size(imagen);
mitadFil = round(fil/2);
mitadCol = round(col/2);
recortada = imagen;
entre = 0;
vueltas = 0;
while(vueltas < 2)
for i = mitadFil:fil
    for j = mitadCol:col
        if(imagen(i,j)==1)
            entre = 1;
        end
        if(entre == 1)
            recortada(i,j)=1;
        end
    end
    entre = 0;
end
recortada = imrotate(recortada,180);
vueltas = vueltas + 1;
end
vueltas = 0;
recortada = imrotate(recortada,90);
figure(11);imshow(recortada);impixelinfo%mostramo
while(vueltas < 2)
for i = mitadFil:fil
    for j = mitadCol:col
        if(imagen(i,j)==1)
            entre = 1;
        end
        if(entre == 1)
            recortada(j,i)=1;
        end
    end
    entre = 0;
end

recortada = imrotate(recortada,180);
vueltas = vueltas + 1;
end
recortada = imrotate(recortada,270);
recortada = ~recortada;
recortada = mayor(recortada);  
end

