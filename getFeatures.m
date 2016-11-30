%http://watermarkero.blogspot.mx/
%http://watermarkero.blogspot.mx/2015/03/reconocimiento-de-caracteres-usando.html
%Reconocimiento de caracteres usando Matlab

function [features] = getFeatures(img, DEBUG)
     % Valores por default
    DEBUG = 1;
    features = zeros();
    if nargin<2, 
        DEBUG=0; 
    end;    
    if nargin<1, 
        img = im2bw(imread('imprueba.bmp'));
        figure(1); imshow(img);
    end;    
    %casting
    img = double(img);
    %contador de caracteristicas
    cont = 1;
    [nFilas, nCols] = size(img);
    center = [ceil(nFilas/2), ceil(nCols/2)];
        
    shrink = bwmorph(img,'shrink',Inf);
    spur = bwmorph(shrink,'spur',Inf);

               
    % razón nFilas/nCols
    features(cont) = nFilas/nCols;  
    cont = cont + 1;

    % razon de area - imagen
    features(cont) = sum(sum(spur))/nFilas*nCols;  
    cont = cont + 1;

    % centroide X, centroide Y
    [y, x] = find( spur );
    centroid = [mean(x) mean(y)];
    features(cont) = centroid(1);  
    cont = cont + 1;
    features(cont) = centroid(2);  
    cont = cont + 1;
    
    % distancia del centro al centroide
    features(cont) = sqrt( ...
        (center(1,1) - centroid(1))^2 + ...
        (center(1,2) - centroid(2))^2);    
    cont = cont + 1;
        
    %  numero de euler: e=#deObjetos - #deAgujerosEnLosObjetos
    feature_euler  = regionprops(spur, 'EulerNumber');
    features(cont) = feature_euler(1).EulerNumber;  
    cont = cont + 1;

    % orientación de la imagen  (in degrees ranging from -90 to 90 degrees) 
    feature_orientation  = regionprops(spur, 'Orientation');
    features(cont) = feature_orientation(1).Orientation;  
    cont = cont + 1;

    % STD X,STD Y
    features(cont) = mean(std(spur));  
    cont = cont + 1;
    features(cont) = mean(std(spur'));  
    cont = cont + 1;
    
    % procesar por bloque
    nBlocks = 5;
    sizeBlockFila = nFilas/nBlocks;
    sizeBlockCol = nCols/nBlocks;    
    filasProcesadas = 0;    
    for f = 1:sizeBlockFila+1:nFilas
        colsProcesadas = 0;
        for c = 1:sizeBlockCol+1:nCols
            finFila = round(f + sizeBlockFila -1);
            finCol = round(c + sizeBlockCol - 1);
            if finFila>nFilas
                finFila = nFilas;
            end
            if finCol>nCols
                finCol = nCols;
            end
            imgBlock = spur(round(f):finFila,round(c):finCol);
            [m,n] = size(imgBlock);
            %atributo razon caracter - bloque
            features(cont) = sum(sum(imgBlock))/(m*n);  
            cont = cont + 1;
            colsProcesadas = colsProcesadas +1;
        end        
        %asegurar que las cols procesadas sean nBloques
        for i = colsProcesadas:(nBlocks-1)
            features(cont) = 0;
            cont = cont + 1;
        end              
        filasProcesadas = filasProcesadas +1;
    end    
    %asegurar que las cols procesadas sean nBloques
    for i = filasProcesadas:(nBlocks-1)
        features(cont) = 0;
        cont = cont + 1;
    end

    % numero de huecos
    filled = imfill(img, 'holes');
    holes = filled & ~img;
    bigholes = bwareaopen(holes, 200);
    stats = regionprops(bigholes, 'Area');
    nHoles = length(find([stats.Area]>10));
    features(cont) = nHoles;
    cont = cont + 1;
        
    %debug mode
    if DEBUG==1
        figure; imshow(filled); title('All holes filled')
        figure; imshow(holes); title('Hole pixels identified')        
        figure; imshow(bigholes); title('Only the big holes')        
    end
    
    % numero de end points
        endPoints = bwmorph(spur,'endpoints');
        branchpoints = bwmorph(spur,'branchpoints');
        se = strel('disk',round(nFilas/12));
        endPoints_dilated = imdilate(endPoints,se);    
        branchpoints_dilated = imdilate(branchpoints,se);    
        stats = regionprops(endPoints_dilated, 'Area');
        nEndPoints = length(find([stats.Area]>10));
        
        features(cont) = nEndPoints;
        cont = cont + 1;
        
     % numero de branch points               
        stats = regionprops(branchpoints_dilated, 'Area');
        nBranchPoints = length(find([stats.Area]>10));
        features(cont) = nBranchPoints;
        cont = cont + 1;


    %debug mode
    if DEBUG==1
        figure(2);
        subplot 322; imshow(spur); title('spur')
        subplot 323; imshow(endPoints); title('end points')
        subplot 324; imshow(branchpoints); title('branch points')
        subplot 325; imshow(endPoints_dilated); title('endPoints dilated')
        subplot 326; imshow(branchpoints_dilated); title('branch points dilated')
    end
end