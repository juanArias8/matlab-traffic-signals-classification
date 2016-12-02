function aumentada = pixelMayor( plancha,imagen )
%--------------------------------------------------------------------------
%-- 1. Inicio de la función pixelMayor2 -----------------------------------
%--------------------------------------------------------------------------
[fil,col] = size(imagen);%llevamos a las variables fil y col, el numero de filas y de columnas respectivamente
mayor = 0;%inicializamos la variable que tendra el umbral mayor
%--------------------------------------------------------------------------
%-- 2. Encontrar umbral mayor de la plantilla -----------------------------
%--------------------------------------------------------------------------
for i = 1:fil
    for j = 1:col
        if(plancha(i,j)>mayor)%comparamos el umbral actual con el del pixel que se lee
            mayor = plancha(i,j);%en caso de ser mayor se le lleva este valor a la variable
        end
    end
end
aumentada = imagen;%llevamos en aunmentamos la imagen con la que trabajaremos
mayor = 255 - mayor;%ahora obtenemos la diferencia respecto al pixel mayor 
%--------------------------------------------------------------------------
%-- 3. Aunmentar umbral ---------------------------------------------------
%--------------------------------------------------------------------------
for i = 1:fil
    for j = 1:col
        if(imagen(i,j)>50)
            aumentada(i,j) = imagen(i,j)+mayor;%sumamos esa diferencia en cada uno de los prixeles de la señal
        end
    end
end
end

