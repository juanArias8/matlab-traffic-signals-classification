function [ senalBin ] = binarizar( senal )
%--------------------------------------------------------------------------
%-- 1. Inicio de la función binarizar -------------------------------------
%--------------------------------------------------------------------------
a = senal;%llevamos la imagen a la variable a
%--------------------------------------------------------------------------
%-- 2. Capas de la imagen -------------------------------------------------
%--------------------------------------------------------------------------
[b,cap]=componentes_color(a);%c contiene la capa con la que procesaremos el esqueje
%--------------------------------------------------------------------------
%-- 3. Aunmento de pixeles de la senal ------------------------------------
%--------------------------------------------------------------------------
[fil,col] = size(cap);%llevamos a las variables fil y col, el numero de filas y de columnas respectivamente
e = cap;%guardamos en una variable auxiliar la capa con la que vamos a trabajar
tamFil = fil*4;%llevamos a las variables el numero de filas multiplicado por 4
tamCol = col*4;%llevamos a las variables el numero de columnas multiplicado por 4
a = ones(tamFil,tamCol);%creamos una nueva imagen en 0 que sera la que contedra la señal aumentada
a = normaliza(a);%normalizamos la imagen para poder trabajar con ella
for i = 1:fil
    for j = 1:col
        for k = 1:3
            a(k+(4*(i-1)),k+(4*(j-1))) = e(i,j);%este algoritmo es que nos permitira aumentar la cantidad de pixeles
            a(k+(4*(i-1)),k+(4*(j-1))+1) = e(i,j);%como aumentamos nuestra imagen por 4 debemos llenar 
            a(k+(4*(i-1))+1,k+(4*(j-1))) = e(i,j);%esos 4 pixeles con el mismo que que se encuentra en esa misma posici{on
            a(k+(4*(i-1))+1,k+(4*(j-1))+1) = e(i,j);
        end
    end
end
e = imrotate(e,90);%rotamos la imagen guia de la cual nos estamos basando para aumentar el tamaño en escala real
a = imrotate(a,90);%rotamos nuestra imagen para realizar el mismo procedimiento
for i = 1:col
    for j = 1:fil
        for k = 1:3
            a(k+(4*(i-1)),k+(4*(j-1))) = e(i,j);
            a(k+(4*(i-1)),k+(4*(j-1))+1) = e(i,j);
            a(k+(4*(i-1))+1,k+(4*(j-1))) = e(i,j);
            a(k+(4*(i-1))+1,k+(4*(j-1))+1) = e(i,j);
        end
    end
end
capa = imrotate(a,-90);%volvemos la imagen resultando a su estado natural
original = capa;%guardamos esta imagen en una variable auxiliar
%--------------------------------------------------------------------------
%-- 3. Cruz de umbrales ---------------------------------------------------
%--------------------------------------------------------------------------
%con esta podremos saber los umbrales de la zona central de la señal
plancha = capa;%guardamos nuestra capa en la que va ser va ser nuestra plancha de cruz
plancha2 = capa;%guardamos la capa la cual sera recortada con la plancha 
plancha(plancha<256)=0;%volvemos nuestra imagen en una imagen vacia de solo 0
[fil,col] = size(capa);%actualizamos el valor respectivo de las filas y columnas de la imagen
centroX = round(fil/2);%optenemos la primera coordenada de la mitad de nuestra señal aunmentada
centroY = round(col/2);%optenemos la segunda coordenada de la mitad de nuestra señal aunmentada
puntoX1 = centroX-4*4;%optenemos la primera coordena en X de nuestra señal aunmetada
puntoY1 = centroY-7*4;%optenemos la primera coordena en Y de nuestra señal aunmetada
puntoX2 = centroX-7*4;%optenemos la segunda coordena en X de nuestra señal aunmetada
puntoY2 = centroY-4*4;%optenemos la segunda coordena en Y de nuestra señal aunmetada
%--------------------------------------------------------------------------
%-- 4. Crear cruz de umbrales ---------------------------------------------------
%--------------------------------------------------------------------------
for i = puntoX1:puntoX1+8*4
    for j = puntoY1:puntoY1+14*4
        plancha(i,j)=255;%Dibujamos un primer rectangulo teniendo en cuenta las coordenadas anteriores          
    end
end
for i = puntoX2:puntoX2+14*4
    for j = puntoY2:puntoY2+8*4
        plancha(i,j)=255;%Dibujamos el segundo rectangulo teniendo en cuenta las coordenadas anteriores          
    end
end
plancha2(plancha==0)=0;%teniendo el cuenta la cruz trazada la utilizamos la plantilla que sera analizada para los umbrales
capa=pixelMayor(plancha2,capa);%devolvemos una imagen aunmentada de contraste dependiendo de sus umbrales

%--------------------------------------------------------------------------
%-- 5. Binarización de la imagen ------------------------------------------
%--------------------------------------------------------------------------

capa(capa>150)=255;%definimos el umbral en el cual se encuentra la señal
capa(capa<255)=0;
capa = ~capa;%invertimos la polaridad de la imagen para poder procesarla 
sesalva = 0;%esta variable es la que nos servira de control para saber de la señales rellenas
%--------------------------------------------------------------------------
%-- 6. Plantilla para recortar la señal------------------------------------
%--------------------------------------------------------------------------
if(detectaBlanco(capa)==1)%usamos un metodo que nos dira si el centro esta en negro
    ee=strel('disk',4);%Definimos un elemento estructurante mayor
    capa=imerode(capa,ee);%realizamos la dilatación de la señal para que solo nos quede el centro de esta     
end
%teniendo en cuenta de la longitudes de la imagen son variadas utilizamos
%la medida de la fila como una medida aproximada
capa = bwareaopen(capa,fil*8);%procedemos a borrar lo que se encuentra en el centro de la señal        
if(capa(centroX,centroY)==0)%detectamos si la senal tiene relleno o tiene una linea transversal
    capa = eliExtrema(capa);
else
    capa = ~capa;%en caso tal de que tenga la linea lo que hacemos es invertir la imagen 
    sesalva = 1;%y cambiamos el valor de la variable que nos dice que es una señal transversal
end
%--------------------------------------------------------------------------
%-- 7. Pulido de la plantilla ---------------------------------------------
%--------------------------------------------------------------------------
ee=strel('disk',10);%Definimos un elemento estructurante
capa=imdilate(capa,ee);%realizamos la erosion de la imagen
%mejoramos la calidad de la plantilla con la que recortaremos la señal
ee=strel('disk',10);%Definimos un elemento estructurante mayor 
capa=imerode(capa,ee);%realizamos la dilatación de la imagen
%--------------------------------------------------------------------------
%-- 8. Recorte de la señal------------------------------------------------
%--------------------------------------------------------------------------
original(capa==0)=0;%con la variable anteriormente definida la retornamos para tene rnuestra capa recortada
%llamamos a un metodo que nos ayudara a mejorar los umbrales para una buena
%binarizacion
original=pixelMayor2(original,original);%todo lo que esta en negro en la imagen binarizada pongalo negro en la imagen original
%--------------------------------------------------------------------------
%-- 9. Binarización de la señal -------------------------------------------
%--------------------------------------------------------------------------
original(original>170)=255;%definimos el umbral en el cual se encuentra la señal
original(original<255)=0;
%--------------------------------------------------------------------------
%-- 10. Pulir la señal  ---------------------------------------------------
%--------------------------------------------------------------------------
ee=strel('square',1);%Definimos un elemento estructurante
original=imdilate(original,ee);%realizamos la erosion de la imagen
ee=strel('square',1);%Definimos un elemento estructurante mayor 
original=imerode(original,ee);%realizamos la dilatación de la imagen
%--------------------------------------------------------------------------
%-- 11. Recortar numero ---------------------------------------------------
%--------------------------------------------------------------------------        
%se tendra en cuenta la variable anteriormente creada que la usamos para
%determinar si era una señal rellena o tenia una transversal
if(sesalva ==0)
    original = recortaNumeros(original); %llamamos el metodo encargado de esto
end
original = bwareaopen(original,fil*2);%borramos desechos dejados por el metodo
%original = imresize(original, [300 300]);
senalBin = original; %retornamos la señal binarizada
end