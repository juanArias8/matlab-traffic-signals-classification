function res = detectaBlanco( imagen )
%--------------------------------------------------------------------------
%-- 1. Tnicia de la función detectaBlanco ---------------------------------
%--------------------------------------------------------------------------
[fil,col] = size(imagen);%llevamos a las variables fil y col, el numero de filas y de columnas respectivamente
res = 0;%variable que devolvera la respuesta
centroX = round(fil/2);%optenemos la primera coordenada de la mitad de nuestra señal aunmentada
centroY = round(col/2);%optenemos la segunda coordenada de la mitad de nuestra señal aunmentada
puntoX1 = centroX-4*2;%optenemos la primera coordena en X de nuestra señal aunmetada
puntoY1 = centroY-7*2;%optenemos la primera coordena en Y de nuestra señal aunmetada
puntoX2 = centroX-7*2;%optenemos la segunda coordena en X de nuestra señal aunmetada
puntoY2 = centroY-4*2;%optenemos la segunda coordena en Y de nuestra señal aunmetada
%--------------------------------------------------------------------------
%-- 2. Creacion de la cruz de umbrales ------------------------------------
%--------------------------------------------------------------------------
%si detectamos en este rectangulo un pixel en 1 devolvemos un 1 en la
%variable
for i = puntoX1:puntoX1+8*2
    for j = puntoY1:puntoY1+14*2
        if(imagen(i,j)==1)
            res = 1;%le llevamos 1 a la variable res
        end
    end
end
%si detectamos en este rectangulo un pixel en 1 devolvemos un 1 en la
%variable
for i = puntoX2:puntoX2+14*2
    for j = puntoY2:puntoY2+8*2
        if(imagen(i,j)==1)
            res = 1;%le llevamos 1 a la variable res
        end         
    end
end
end

