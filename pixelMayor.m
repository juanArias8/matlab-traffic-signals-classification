function aumentada = pixelMayor( plancha,imagen )
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
mayor = 255 - mayor;
for i = 1:fil
    for j = 1:col
        aumentada(i,j) = imagen(i,j)+mayor;
    end
end
end

