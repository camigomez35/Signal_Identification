function [imagenes] = recortar(imagen)
    [fil_o, col_o, cap]= size(imagen);
    if cap>1; imagen2=rgb2gray(imagen); end;
    [l,n] = bwlabel(imagen2);
    imagenes = [];
    for i = 1:n
        figura=imagen2*0; 
        figura(l==i)=255;
        [fil, col]=find(figura>0);
        fil_min = min(fil(:));
        fil_max = max(fil(:));
        col_min = min(col(:));
        col_max = max(col(:));
        e = imagen(fil_min:fil_max,col_min:col_max, :);
        e = imresize(e, [200, 200]);
        imagenes = [imagenes, e];
    end
end
