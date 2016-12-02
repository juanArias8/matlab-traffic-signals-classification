function aumentada = pixelMayor2( plancha,imagen )
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
            mayor = plancha(i,j); %en caso de ser mayor se le lleva este valor a la variable
        end
    end
end
aumentada = imagen;%llevamos en aunmentamos la imagen con la que trabajaremos
mayor2 = mayor;%guardamos en una variable aunxiliar el valor del umbral mayor
mayor = 255 - mayor;%ahora obtenemos la diferencia respecto al pixel mayor ;
%-------------------------------------------------------------------------
%------ 3. Aunmentar el umbral .-------------------------------------------
%--------------------------------------------------------------------------
%es posible que la imagen posea umbrales muy bajos por la tanto se genero
%este codigo este caso
for i = 1:fil
    for j = 1:col
        if(imagen(i,j)>90 && mayor2>120)%cambiamos los umbrales para que queden equitativo respecto
            aumentada(i,j) = imagen(i,j)+mayor;%le llevamos ese valor  
        end
    end
end
%--------------------------------------------------------------------------
%-- 4. En otro caso -------------------------------------------------------
%--------------------------------------------------------------------------
area = fil*col;
negros = 0;
%--------------------------------------------------------------------------
%-- 5. contamos la cantidad de pixeles en 0 hay ---------------------------
%--------------------------------------------------------------------------
for i = 1:fil
    for j = 1:col
        if(imagen(i,j)==0)
            negros = negros + 1;%aunmenta la variable imagen
        end
    end
end
%--------------------------------------------------------------------------
%-- 6. Aunmentar umbral ---------------------------------------------------
%--------------------------------------------------------------------------
if(negros > area/10)%verificamos que el area no sea menos que el braxo
   for i = 1:fil
    for j = 1:col
        if(imagen(i,j)>40)
            aumentada(i,j) = imagen(i,j)+mayor;%aunmentamos lo que se encuentra ese ese pincxeñññ
        end
    end
   end
end
end