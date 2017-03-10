function respuesta = reconocedor(imagen, indice)    
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
     if maximo>7
         ind = find(porcent==maximo);
         respuesta = fnames(ind).name;
         respuesta = respuesta(1);
     else
         respuesta = '0';
     end
     
     
 end


