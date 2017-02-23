function porcent = reconocedor(imagen, indice)    
     fnames = dir('se�ales/*.jpg');
     numfids = length(fnames);
     porcent = [];
     for i = 1 : numfids
        pattern = imread(strcat(pwd,'\se�ales\',fnames(i).name));
        pattern = imresize(pattern, [200,200]);
        var = matching(imagen, pattern);
        var = var.Count;
        porcent = [porcent, var];
     end
     maximo=max(porcent);
     ind = find(porcent==maximo)
     figure(indice); imshow(imagen); 
     title(['Se�al = ', fnames(ind).name]);
 end


