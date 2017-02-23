function [e] = recortar(imagen, imagen2)
    [fil, col]=find(imagen>0);
    fil_min = min(fil(:));
    fil_max = max(fil(:));
    col_min = min(col(:));
    col_max = max(col(:));
    e = imagen2(fil_min:fil_max,col_min:col_max, :);
    e = imresize(e, [200, 200]);
end
