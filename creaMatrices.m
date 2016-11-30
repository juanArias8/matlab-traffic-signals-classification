function[matrizE, matrizT]= creaMatrices()
    matrizEntrenamiento = [];
    nombreClase = [];
    cont = 1; 
    dirList = dir(['senialesProcesadas/']);    
    for ndir=1:length(dirList)
        if ~(strcmp(dirList(ndir).name, '.') || strcmp(dirList(ndir).name, '..'))
            if dirList(ndir).isdir == 1,
                disp(['PROCESANDO CARPETA: ' dirList(ndir).name]);        
                % se obtiene la lista de imagenes de cada clase
                folderName = dirList(ndir).name;
                imageList = dir(['senialesProcesadas/' folderName '/']);
                disp(folderName); 
                for nImage=3:length(imageList)
                    disp([folderName,'/',imageList(nImage).name]);   
                    %cargamos la imagen a procesar
                    imagen = imread(['senialesProcesadas\',folderName,'\',imageList(nImage).name]);
                    figure(1); imshow(imagen);
                    [featuresImaR] = getFeatures(imagen);
                    matrizEntrenamiento = cat(1, matrizEntrenamiento, featuresImaR);    
                    nombreClase(cont,ndir-2) = 1;
                    cont = cont+1;
                end 
            end
        end
    end
    save('matrizEntrenamiento.mat','matrizEntrenamiento');
    save('nombreClase.mat','nombreClase');
    matrizE = matrizEntrenamiento;
    matrizT = nombreClase;
end