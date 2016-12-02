function recortada = eliExtrema(imagen)
%--------------------------------------------------------------------------
%-- 1. Inicio de la función eliExtrema -------------------------------------
%--------------------------------------------------------------------------
[fil,col] = size(imagen);%llevamos a las variables fil y col, el numero de filas y de columnas respectivamente
mitadFil = round(fil/2);%optenemos la primera coordenada de la mitad de nuestra señal aunmentada
mitadCol = round(col/2);%optenemos la segunda coordenada de la mitad de nuestra señal aunmentada
recortada = imagen;%guardamos en una variable auxiliar la señal
entre = 0;%tendremos dos variables de contro que iniciamos en  0
vueltas = 0;
%--------------------------------------------------------------------------
%-- 2. Borrado hacia arriba desde el centro -------------------------------
%--------------------------------------------------------------------------
%Luego de obtener la mitad de la imagen procedemos desde esta hacia afuera
%para eliminar todo tipo de ruido de la señal
while(vueltas < 2)%cuando demos dos vuelta a la imagen este bucle se detendra
    for i = mitadFil:fil
        for j = mitadCol:col
            if(imagen(i,j)==1)%con solo una vez que entre es suficiente para que siga poniendo 1 hacia afuera
                entre = 1;
            end
            if(entre == 1)
                recortada(i,j)=1;%pone 1 aunque solo haya detectatado 1
            end
        end
    entre = 0;%reiniciamos la variable para la siguiente colomna
    end
recortada = imrotate(recortada,180);%giramos la imagen 180 para que sea procesada
vueltas = vueltas + 1;%aunmentamos la variable para indicarle al buqle que dimos una vuelta
end
%--------------------------------------------------------------------------
%-- 3. Borramos desde el centro hacia afuera los laterales ----------------
%--------------------------------------------------------------------------
%funciona igual que los bubles anteriores solo que se intercambias la fila
%con la columna
vueltas = 0;%reiniciamos la la variable que me cuenta las rotaciones
recortada = imrotate(recortada,90);%rotamos la imagen 90 grados para que sea procesada
while(vueltas < 2)%cuando demos dos vuelta a la imagen este bucle se detendra
for i = mitadFil:fil
    for j = mitadCol:col
        if(imagen(i,j)==1)%con solo una vez que entre es suficiente para que siga poniendo 1 hacia afuera
            entre = 1;
        end
        if(entre == 1)
            recortada(j,i)=1;%pone 1 aunque solo haya detectatado 1
        end
    end
    entre = 0;%reiniciamos la variable para la siguiente colomna
end

recortada = imrotate(recortada,180);%giramos la imagen 180 para que sea procesada
vueltas = vueltas + 1;%aunmentamos la variable para indicarle al buqle que dimos una vuelta
end
recortada = imrotate(recortada,270);%volvemos nuestra imagen a la posicion inicial
recortada = ~recortada;%invertimos la imagen para los siguientes procesos
recortada = mayor(recortada); %eliminamos bordes restantes 
end

