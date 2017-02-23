%--------------------------------------------------------------------------
%------- CÓDIGO -----------------------------------------------------------
%------- Proyecto 1 -------------------------------------------------------
%------- Por: Maria Camila Gomez maria.gomez26@udea.edu.co ----------------
%-------      CC 1152454724 -----------------------------------------------
%------- Por: Santiago Romero santiago.romero@udea.edu.co -----------------
%-------      CC 1152454724 -----------------------------------------------
%------- Por: Milena Cardenas milena.cardenas@udea.edu.co -----------------
%-------      CC 1152454724 -----------------------------------------------
%------- Curso Básico de Procesamiento de Imágenes y Visión Artificial-----
%------- Marzo de 2017-----------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--1. Inicializo el sistema -----------------------------------------------
%--------------------------------------------------------------------------
clear all
close all
clc


%--------------------------------------------------------------------------
%-- 2. Lectura de la imagen  ----------------------------------------------
%--------------------------------------------------------------------------
camara =videoinput('winvideo',1,'MJPG_1280x720');
imagen = getsnapshot(camara); %b=imresize(b, 0.5);
[fil,col,cap]=size(imagen);
figure(1);imshow(imagen);impixelinfo
%imwrite(imagen, 'imagen.jpg');

%--------------------------------------------------------------------------
%-- 3. Sepera la imagen en sus tres componentes CMY  ----------------------
%--------------------------------------------------------------------------
[componente] = componentes(imagen);
%figure(2);imshow([s,c,m,y]);impixelinfo

%--------------------------------------------------------------------------
%-- 4. Sepera la imagen en sus cuatro componentes SCMY  -------------------
%--------------------------------------------------------------------------

%Para señales rojas
%min1 = min(s,m);
min1 = componente;
%figure(3); imshow(min1);impixelinfo
min1(min1<150)=0;
min1(min1>0)=255;
min1 = [min1,min1,min1];
min1 = reshape(min1,[fil,col,cap]);
copiaImagen = imagen;
copiaImagen(min1==0)=0;
%figure(4);imshow(copiaImagen);impixelinfo


%--------------------------------------------------------------------------
%-- 5. Segmentar la imagen y eliminar ruido -------------------------------
%--------------------------------------------------------------------------
if cap>1
    copiaImagen=rgb2gray(copiaImagen); 
end;

copiaImagen=imclearborder(copiaImagen);

[l,n] = bwlabel(copiaImagen);
%figure(7); imagesc(l);colormap('hot');
%title(['Numero objetos = ', num2str(n)]);
%impixelinfo

LB = 1000; % Area minima
UB = 500000; % Area maxima
% Eliminar objetos que no esten en el rango
sinRuido = xor(bwareaopen(l,LB),  bwareaopen(l,UB));

ee= strel('square',2);
sinRuido = imdilate(sinRuido,ee);
%figure(8); imshow(sinRuido);

% Se hace dilatacion y luego erosion para unir las partes de la figura
ee= strel('square', 15);
sinRuido = imdilate(sinRuido,ee);
%figure(9); imshow(sinRuido);
ee = strel('square', 11);
sinRuido = imerode(sinRuido,ee);
%figure(10); imshow(sinRuido);

% Se llenan los huecos de la señal
sinRuido = imfill(sinRuido,'holes');
% Se limpian los bordes
sinRuido = imclearborder(sinRuido);
%figure(11); imshow(sinRuido);

sinRuido = [sinRuido,sinRuido,sinRuido];
imagenDos = imagen;

imagenDos(sinRuido==0)=0;
figure(2); imshow(imagenDos);

[fil_o, col_o, cap]= size(imagenDos);
if cap>1; imagen2=rgb2gray(imagenDos); end;
[l,n] = bwlabel(imagen2);
imagenes = [];
resultados = [];
for i = 1:n
    figura=imagen2*0; 
    figura(l==i)=255;
    recorte = recortar(figura, imagenDos);
    porcentaje = reconocedor(recorte);
    porcentaje
    resultados = [resultados, porcentaje.Count]
end
resultados

% [l,n] = bwlabel(imagenDos);
% figure(3);imshow(l);impixelinfo
%reconocedor(l, n);

