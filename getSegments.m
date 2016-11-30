function[imaR] = getSegments(imagen)   
    ima = imresize(imagen, [300 300]);
    grayImage = ima;
    % 
    % fn = imnoise(grayImage,'gaussian');
    % h1=fspecial('gaussian');
    % h2=fspecial('average');
    % g1=imfilter(fn,h1);
    % media2=imfilter(fn,h2);
    % %Representaciones de las imágenes
    % figure(1);
    % subplot(2,2,1),subimage(ima),title('Imagen original');
    % subplot(2,2,2),subimage(fn),title('Imagen con ruido gaussiano');
    % subplot(2,2,3),subimage(g1),title('Filtro gaussiano');
    % subplot(2,2,4),subimage(media2),title('Filtro de media 3X3'); 
    % 
    % grayImage = media2;

%     figure(2); 
%     subplot 221; imshow(ima);

    % Segmentación en regiones
    %Se segmenta la imagen en regiones, idealmente las regiones encontradas
    %son 2: el fondo y las letras mismas.
    thresh = multithresh(grayImage,1);

    %La imagen segmentada contiene SÓLO valores 1 y 2
    segmentedImage = imquantize(grayImage,thresh);

    % corrección para binarización
    %Se corrige la imagen Segmentada para que tengan valores de 1 y 0. es
    %decir se "binariza"
    segmentedImage = -1*(segmentedImage -2);

    %debug mode
%     if DEBUG == 1,
%     %subplot 222; imshow(segmentedImage)
%     title('Imagen en SIN bordes dilatados');        
%     end

    % Dilatar regiones
    dilateFactor=3;
    se = strel('disk',dilateFactor);
    dilatedImage = imdilate(segmentedImage,se);   

    % Cerrar regiones
    %Se cierran regiones.
    closeFactor=2;
    se = strel('disk',closeFactor);
    closedImage = imclose(dilatedImage,se);    

    % Erosion de regiones
    %Se se erosiona la imagen.
    erodeFactor=2;
    se = strel('disk',erodeFactor);
    erodedImage = imerode(closedImage,se);


    %debug mode
%     if DEBUG == 1,
%     %subplot 223; imshow(erodedImage)
%     title('Imagen en con bordes erosionados');                
%     end

    % Etiquetado de las regiones hallados
    [regions, numObj] = bwlabel(erodedImage);

    % Se obtiene el Bounding Box de las regiones conectadas
    bBox = regionprops(regions, 'BoundingBox');


%     %debug mode
%     if DEBUG == 1,
%     %subplot 224; imshow(regions)
%     title('Regiones halladas');        
%     hold on
%     end

    % Se llena la estructura de regiones encontradas
    for k = 1 : numObj
        %se obtiene la región de imagen segmentada
        segments(k).image = regions( ...
            ceil(bBox(k).BoundingBox(1,2)) : floor(bBox(k).BoundingBox(1,2)) + floor(bBox(k).BoundingBox(1,4)), ...
            ceil(bBox(k).BoundingBox(1,1)) : floor(bBox(k).BoundingBox(1,1)) + floor(bBox(k).BoundingBox(1,3)));
        %se obtiene el centro
        segments(k).center = ceil(size(segments(k).image)/2);
        segments(k).bBox = bBox(k).BoundingBox;
        %se obtiene el tamaño
        segments(k).size = size(segments(k).image);

        %debug mode
        rectangle('Position', bBox(k).BoundingBox,'EdgeColor','y');
    end
% 
%     %debug mode
%     if DEBUG == 1, 
%     hold off
%     end

    fn = imnoise(regions,'gaussian');
    h1=fspecial('gaussian');
    h2=fspecial('average');
    g1=imfilter(fn,h1);
    media2=imfilter(fn,h2);
    %Representaciones de las imágenes
%     figure(3);
%     subplot(2,2,1),subimage(regions),title('Imagen original');
%     subplot(2,2,2),subimage(fn),title('Imagen con ruido gaussiano');
%     subplot(2,2,3),subimage(g1),title('Filtro gaussiano');
%     subplot(2,2,4),subimage(media2),title('Filtro de media 3X3');

    bw = im2bw(media2);
    se = strel('disk',3);
    ss = strel('disk',2);
    bw = imerode(bw,ss);
    bw = imclose(bw,se);  
    
%     figure(4); imshow(bw);
%     imwrite(bw,'imprueba.bmp');
    imaR = bw;
end