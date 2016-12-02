function aumentada = pixelMayor2( plancha,imagen )
[fil,col] = size(imagen);
mayor = 0;
for i = 1:fil
    for j = 1:col
        if(plancha(i,j)>mayor)
            mayor = plancha(i,j);
        end
    end
end
aumentada = imagen;
mayor2 = mayor;
mayor = 255 - mayor;
for i = 1:fil
    for j = 1:col
        if(imagen(i,j)>90 && mayor2>120)
            aumentada(i,j) = imagen(i,j)+mayor;
        end
    end
end
area = fil*col;
negros = 0;
for i = 1:fil
    for j = 1:col
        if(imagen(i,j)==0)
            negros = negros + 1;
        end
    end
end
if(negros > area/10)
   for i = 1:fil
    for j = 1:col
        if(imagen(i,j)>40)
            aumentada(i,j) = imagen(i,j)+mayor;
        end
    end
   end
end
end