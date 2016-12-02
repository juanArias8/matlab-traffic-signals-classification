function [ esquejeBin ] = binarizar( esqueje )
%--------------------------------------------------------------------------
%-- 1. Inicio de la funci�n recortaTallo ----------------------------------
%--------------------------------------------------------------------------
%figure(12);imshow(esqueje);impixelinfo%mostramos las diferentes capas retornadas
a = esqueje;%llevamos la imagen a la variable a



%--------------------------------------------------------------------------
%-- 2. Capas de la imagen -------------------------------------------------
%--------------------------------------------------------------------------


[b,cap]=componentes_color(a);%c contiene la capa con la que procesaremos el esqueje
%metodo de fill


% 
% [d] = filtros(cap);
% figure(17);imshow(cap);impixelinfo
% figure(27);imshow(d);impixelinfo;
% 
% e = impixel;%escoger los umbrales
% em = min(e(:));
% d(d>em)=255;d(d<255)=0;
% d = imfill(d);
% figure(30);imshow(d);impixelinfo
% 
% [e] = mayor(d);%eliminar bordes
% figure(50);imshow(e);
% d = e;
% figure(27);imshow(d);impixelinfo;

%termina metodo fil
[fil,col] = size(cap);
e = cap;
tamFil = fil*4;
tamCol = col*4;
a = ones(tamFil,tamCol);
a = normaliza(a);
for i = 1:fil
    for j = 1:col
        for k = 1:3
            a(k+(4*(i-1)),k+(4*(j-1))) = e(i,j);
            a(k+(4*(i-1)),k+(4*(j-1))+1) = e(i,j);
            a(k+(4*(i-1))+1,k+(4*(j-1))) = e(i,j);
            a(k+(4*(i-1))+1,k+(4*(j-1))+1) = e(i,j);
        end
    end
end
e = imrotate(e,90);
a = imrotate(a,90);
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
c = imrotate(a,-90);

h = c;
%figure(1);imshow(b);impixelinfo%mostramos las diferentes capas retornadas
%title('Las diferentes capas en escala de grises');
%figure(2);imshow(c);impixelinfo%mostramos la capa que seleccionamos para procesar el esqueje
%title('usaremos');

%%%%%circulo
plancha = c;
plancha2 = c;
plancha(plancha<256)=0;
[fil,col] = size(c);
centroX = round(fil/2);
centroY = round(col/2);
puntoX1 = centroX-4*4;
puntoY1 = centroY-7*4;
puntoX2 = centroX-7*4;
puntoY2 = centroY-4*4;
for i = puntoX1:puntoX1+8*4
    for j = puntoY1:puntoY1+14*4
        plancha(i,j)=255;           
    end
end
for i = puntoX2:puntoX2+14*4
    for j = puntoY2:puntoY2+8*4
        plancha(i,j)=255;           
    end
end
plancha2(plancha==0)=0;
%figure(5);imshow(plancha2);impixelinfo
c=pixelMayor(plancha2,c);%todo lo que esta en negro en la imagen binarizada pongalo negro en la imagen original
%figure(3);imshow(c);impixelinfo
%%%%para mejorar la calida
%%%%aqui termina
%%%%fin circulo
%%Luego de obtener la imagen de interes, declaramos un umbral y lo

%--------------------------------------------------------------------------
%-- 3. Binarizaci�n de la imagen ------------------------------------------
%--------------------------------------------------------------------------

c(c>150)=255;
c(c<255)=0;%definimos el umbral en el cual se encuentra el esqueje
%figure(4);imshow(c);impixelinfo%mostramos el esqueje binarizado
c = ~c;
%figure(6);imshow(c);impixelinfo%mostramos el esqueje binarizado
%inicio de funcion

% for i = 1:fil
%     for j = 1:col
%         if(c(i,j)==1)
%             if(j<col)
%             if(c(i,j+1)==0)
%                 cont = cont +1;
%             end
%             end
%         end
%     end
%     if(cont<3)
%         for j = 1:col
%             c(i,j)=0;
%         end
%     end
%     cont = 0;
% end
% ee=strel('disk',1);%Definimos un elemento estructurante
%         c=imdilate(c,ee);%realizamos la erosion de la imagen
%         figure(7);imshow(c);impixelinfo%mostramos el esqueje binarizado
sesalva = 0;
if(detectaBlanco(c)==1)
    ee=strel('disk',4);%Definimos un elemento estructurante mayor 
        c=imerode(c,ee);%realizamos la dilataci�n de la imagen
        %figure(7);imshow(c);impixelinfo%mostramos el esqueje binarizado
        
end

c = bwareaopen(c,fil*8);        


%figure(8);imshow(c);impixelinfo%mostramos el esqueje binarizado
if(c(centroX,centroY)==0)
    c = eliExtrema(c);
    
else
    c = ~c;
    sesalva = 1;
end
%figure(9);imshow(c);impixelinfo%mostramos el esqueje binarizado
ee=strel('disk',10);%Definimos un elemento estructurante
        c=imdilate(c,ee);%realizamos la erosion de la imagen
       % figure(10);imshow(c);impixelinfo%mostramos el esqueje binarizado
        ee=strel('disk',10);%Definimos un elemento estructurante mayor 
        c=imerode(c,ee);%realizamos la dilataci�n de la imagen
        %figure(11);imshow(c);impixelinfo%mostramos el esqueje binarizado
h(c==0)=0;

%fin de funciom
%figure(12);imshow(h);impixelinfo%mostramos el esqueje binarizado
h=pixelMayor2(h,h);%todo lo que esta en negro en la imagen binarizada pongalo negro en la imagen original
%figure(13);imshow(h);impixelinfo
%%%%para mejorar la calida
%%%%aqui termina
%%%%fin circulo
%%Luego de obtener la imagen de interes, declaramos un umbral y lo

%--------------------------------------------------------------------------
%-- 3. Binarizaci�n de la imagen ------------------------------------------
%--------------------------------------------------------------------------

h(h>170)=255;
h(h<255)=0;%definimos el umbral en el cual se encuentra el esqueje
%figure(14);imshow(h);impixelinfo%mostramos el esqueje binarizado
ee=strel('square',1);%Definimos un elemento estructurante
        h=imdilate(h,ee);%realizamos la erosion de la imagen
     %   figure(15);imshow(h);impixelinfo%mostramos el esqueje binarizado
        ee=strel('square',1);%Definimos un elemento estructurante mayor 
        h=imerode(h,ee);%realizamos la dilataci�n de la imagen
        
       % figure(16);imshow(h);impixelinfo%mostramos el esqueje binarizado
if(sesalva ==0)
       h = recortaNumeros(h);
       figure(17);imshow(h);impixelinfo%mostramos el esqueje binarizado
 
 ee=strel('square',5);%Definimos un elemento estructurante
        h = bwareaopen(h,8); 
        %figure(19);imshow(h);impixelinfo%mostramos el esqueje binarizado
end

%--------------------------------------------------------------------------
%-- 6. realizamos la erosion del esqueje ---------------------------------
%--------------------------------------------------------------------------
        % ee=strel('disk',2);%Definimos un elemento estructurante
        % d=imerode(c,ee);%realizamos la erosion de la imagen
        % figure(4);imshow(d);%mostramos como queda la imagen
        % title('Imagen erosionada');
%--------------------------------------------------------------------------
%-- 6. realizamos la dilataci�n del esqueje -------------------------------
%--------------------------------------------------------------------------
        % ee=strel('disk',2);%Definimos un elemento estructurante mayor 
        % d=imdilate(d,ee);%realizamos la dilataci�n de la imagen
        % figure(5);imshow(d);%Luego de hacer erode y dilate veremos que nuestra imagen a cogido una
        % %forma m�s solida
        % title('Imagen dilatada');
%d = bwareaopen(d,40000);%eliminamos objetos que no pertenezcan al esqueje

esquejeBin = h; %retornamos imagen binarizada
%--------------------------------------------------------------------------
%-- 7. Imagen original recortada ------------------------------------------
%--------------------------------------------------------------------------
% d=[d,d,d];%unimos todas la capas de la imagen
% [fil,col,cap]=size(a);%obtenemos el tama�o de la imagen
% d=reshape(d,[fil,col,cap]);
% a(d==0)=0;%todo lo que esta en negro en la imagen binarizada pongalo negro en la imagen original
% talloBin = a;%devolvemos la imagen con un cuadro
end