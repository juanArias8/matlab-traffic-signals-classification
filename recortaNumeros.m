function recortada = recortaNumeros(imagen)
[fil,col] = size(imagen);
recortada = ~imagen;
for i = 1:col
    for j = 1:fil
        if(recortada(j,i)==1)
           recortada(j,i)=0;
        else
            break;
        end
    end
end
recortada = imrotate(recortada,180);
for i = 1:col
    for j = 1:fil
        if(recortada(j,i)==1)
           recortada(j,i)=0;
        else
            break;
        end
    end
end
recortada = imrotate(recortada,180);
end

