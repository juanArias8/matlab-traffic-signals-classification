%http://watermarkero.blogspot.mx/
%http://watermarkero.blogspot.mx/2015/03/reconocimiento-de-caracteres-usando.html
%Reconocimiento de caracteres usando Matlab

function [features] = getFeatures(imagen)
     % Valores por default
     features = zeros(); 
     img = double(imagen);
     cont = 1;
     
      [fil, col] = size(img);
     midf = fil/2;
     x=0;
     for i=1 : col
        if(img(midf,i)) == 1
            x = x+1;
        end
     end
     features(cont,1) = x;
     cont = cont+1;
     midc = col/2;
     y=0;
     for i=1 : fil
        if(img(i,midc)) == 1
            y = y+1;
        end
     end
     features(cont,1) = y;
     cont = cont +1;
     
     
     prop = regionprops(img,'all');
     
%      boundingBox = prop.BoundingBox;
% %      features(cont) = boundingBox;
%     features = cat(features, boundingBox);
%      cont = cont+1;
     
%      centroid = prop.Centroid;
%      features(cont) = centroid;
%      cont = cont+1;
     
     eccentricity = prop.Eccentricity;
     features(cont,1) =eccentricity;
     cont = cont+1;
     
     equivDiameter = prop.EquivDiameter;
     features(cont,1) =equivDiameter;
     cont = cont+1;
     
     eulerNumber = prop.EulerNumber;
    features(cont,1) = eulerNumber;
     cont = cont+1;
     
%      extent = prop.Extent;
%      features(cont) = Extent;
%      cont = cont+1;
     
%      extrema = prop.Extrema;
%      features(cont) = extrema;
%      cont = cont+1;
     
     filledArea = prop.FilledArea;
     features(cont,1) =filledArea;
     cont = cont+1;
     
%      filledImage = prop.FilledImage;
%      features(cont) = filledImage;
%      cont = cont+1;
     
%      image = prop.Image;
%      features(cont) = image;
%      cont = cont+1;
     
     majorAxisLength = prop.MajorAxisLength;
     features(cont,1) = majorAxisLength;
     cont = cont+1;
     
%      maxIntensity = prop.MaxIntensity;
%      features(cont) = maxIntensity;
%      cont = cont+1;
     
%      meanIntensity = prop.MeanIntensity;
%      features(cont) = meanIntensity;
%      cont = cont+1;
     
     minorAxisLength = prop.MinorAxisLength;
     features(cont,1) = minorAxisLength;
     cont = cont+1;
     
     orientation = prop.Orientation;
     features(cont,1) =orientation;
     cont = cont+1;
     
     perimeter = prop.Perimeter;
    features(cont,1) = perimeter;
     cont = cont+1;
     
%      pixelIdxList = prop.PixelIdxList;
%      features(cont) = pixelIdxList;
%      cont = cont+1;
     
%      pixelList = prop.PixelList;
%      features(cont) = pixelList;
%      cont = cont+1;
     
%      pixelValues = prop.PixelValues;
%      features(cont) = pixelValues;
%      cont = cont+1;
     
%      subarrayIdx = prop.SubarrayIdx;
%      features(cont) = subarrayIdx;
%      cont = cont+1;
     
%      weightedCentroid = prop.WeightedCentroid;
%      features(cont) = weightedCentroid;
%      cont = cont+1;
     
%      basic = prop.basic;
%      features(cont) = basic;
%      cont = cont+1;
     
%     
     [nFilas, nCols] = size(img);
    center = [ceil(nFilas/2), ceil(nCols/2)];
        
    shrink = bwmorph(img,'shrink',Inf);
    spur = bwmorph(shrink,'spur',Inf);
% 
%                
    % raz�n nFilas/nCols
    features(cont,1) =nFilas/nCols;  
    cont = cont + 1;

    % razon de area - imagen
    features(cont,1) = sum(sum(spur))/nFilas*nCols;  
    cont = cont + 1;

    % centroide X, centroide Y
    [y, x] = find( spur );
    centroid = [mean(x) mean(y)];
   features(cont,1) = centroid(1);  
    cont = cont + 1;
    features(cont,1) =centroid(2);  
    cont = cont + 1;
    
    % distancia del centro al centroide
    features(cont,1) = sqrt( ...
        (center(1,1) - centroid(1))^2 + ...
        (center(1,2) - centroid(2))^2);    
    cont = cont + 1;
%         
%     %  numero de euler: e=#deObjetos - #deAgujerosEnLosObjetos
%     feature_euler  = regionprops(spur, 'EulerNumber');
%     features(cont) = feature_euler(1).EulerNumber;  
%     cont = cont + 1;
% 
%     % orientaci�n de la imagen  (in degrees ranging from -90 to 90 degrees) 
%     feature_orientation  = regionprops(spur, 'Orientation');
%     features(cont) = feature_orientation(1).Orientation;  
%     cont = cont + 1;
% 
    % STD X,STD Y
   features(cont,1) = mean(std(spur));  
    cont = cont + 1;
    features(cont,1) = mean(std(spur'));  
    cont = cont + 1;
%     
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
            features(cont,1) = sum(sum(imgBlock))/(m*n);  
            cont = cont + 1;
            colsProcesadas = colsProcesadas +1;
        end        
        %asegurar que las cols procesadas sean nBloques
        for i = colsProcesadas:(nBlocks-1)
            features(cont,1) = 0;
            cont = cont + 1;
        end              
        filasProcesadas = filasProcesadas +1;
    end    
    %asegurar que las cols procesadas sean nBloques
    for i = filasProcesadas:(nBlocks-1)
       features(cont,1) = 0;
        cont = cont + 1;
    end

    % numero de huecos
    filled = imfill(img, 'holes');
    holes = filled & ~img;
    bigholes = bwareaopen(holes, 200);
    stats = regionprops(bigholes, 'Area');
    nHoles = length(find([stats.Area]>10));
    features(cont,1) =nHoles;
    cont = cont + 1;
       

    
    % numero de end points
        endPoints = bwmorph(spur,'endpoints');
        branchpoints = bwmorph(spur,'branchpoints');
        se = strel('disk',round(nFilas/12));
        endPoints_dilated = imdilate(endPoints,se);    
        branchpoints_dilated = imdilate(branchpoints,se);    
        stats = regionprops(endPoints_dilated, 'Area');
        nEndPoints = length(find([stats.Area]>10));
        
        features(cont,1) = nEndPoints;
        cont = cont + 1;
        
     % numero de branch points               
        stats = regionprops(branchpoints_dilated, 'Area');
        nBranchPoints = length(find([stats.Area]>10));
        features(cont,1) =nBranchPoints;

    features = features;
end