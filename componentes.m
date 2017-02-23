function [a] = componentes(a)
    [fil,col,cap] = size(a);
    % CMYK
%     cform = makecform('srgb2cmyk');
%     cmyk = applycform(a, cform);
%     k = cmyk(:,:,4);
%     k = [k,k,k];
%     cmy = cmyk(:,:,1:3);
%     cmy = normaliza(cmy);
%    
%     hsi = rgb2hsv(a);
%     hsi = normaliza(hsi);
%     
%     
%     s = hsi(:, (col+1):col*2);
%     c = cmy(:, 1:col);
%     m = cmy(:, (col+1):col*2);
%     y = cmy(:, (col*2+1):col*3);
    %LAB
    cform = makecform('srgb2lab');
    lab = applycform(a,cform);
    lab2 = normaliza(lab);

    a = lab2(:, (col+1):col*2);
end

