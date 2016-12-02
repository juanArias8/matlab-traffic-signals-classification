function recortada = recortaNumeros(imagen)
%--------------------------------------------------------------------------
%-- 1. Inicio de la función recortaNumeros --------------------------------
%--------------------------------------------------------------------------
[fil,col] = size(imagen);%llevamos a las variables fil y col, el numero de filas y de columnas respectivamente
recortada = ~imagen;%invertimos los valores de la imagen
%--------------------------------------------------------------------------
%-- 2. Relleno de la imagen -----------------------------------------------
%--------------------------------------------------------------------------
%rellenamos la imagen para que solo queden los numeros recorremos cada una
%de la columnas volviendo todo lo que este en 1 en 0 en caso contrario pasa
%a la columna
for i = 1:col
    for j = 1:fil
        if(recortada(j,i)==1)
           recortada(j,i)=0;%llevamos el valor de 0 en dicha posicion
        else
            break;%pasamos a la siguiente columna
        end
    end
end
recortada = imrotate(recortada,180);%giramos la imagen para procesar el otro lado
for i = 1:col
    for j = 1:fil
        if(recortada(j,i)==1)
           recortada(j,i)=0;
        else
            break;
        end
    end
end
recortada = imrotate(recortada,180);%por ultimo devolvemos la imagen en la posicion indicada
end

