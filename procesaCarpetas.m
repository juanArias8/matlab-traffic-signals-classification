dirList = dir(['seniales/']);    
    for ndir=1:length(dirList)
        if ~(strcmp(dirList(ndir).name, '.') || strcmp(dirList(ndir).name, '..'))
            if dirList(ndir).isdir == 1,
                disp(['PROCESANDO CARPETA: ' dirList(ndir).name]);        
                % se obtiene la lista de imagenes de cada clase
                folderName = dirList(ndir).name;
                disp(folderName);
                imageList = dir(['seniales/' folderName '/']);              
                % se obtiene la metrica que nos servirá para eliminar las
                % imágenes diferentes a las esperadas,área
                for nImage=3:length(imageList)
                    %se obtiene la imagen actual
                    disp([folderName,'/',imageList(nImage).name]);
                    %disp(imageList(nImage).name);
                    imagen = imread(['seniales\',folderName,'\',imageList(nImage).name]);
                    [senalRecor] = binarizar(imagen);
                    [imaR]=getSegments(senalRecor);
                    imwrite(imaR,['senialesProcesadas\',folderName,'\',imageList(nImage).name,'.bmp']);
                    figure(1); imshow(imaR);
                end
            end
        end
    end