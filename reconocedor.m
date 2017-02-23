function porcent = reconocedor(imagen, indice)    
     fnames = dir('señales/*.jpg');
     numfids = length(fnames);
     porcent = [];
     for i = 1 : numfids
        pattern = imread(strcat(pwd,'\señales\',fnames(i).name));
        pattern = imresize(pattern, [200,200]);
        var = matching(imagen, pattern);
        var = var.Count;
        porcent = [porcent, var];
     end
     maximo=max(porcent);
     ind = find(porcent==maximo)
     figure(indice); imshow(imagen); 
     title(['Señal = ', fnames(ind).name]);
 end


