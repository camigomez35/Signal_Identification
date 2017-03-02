%--------------------------------------------------------------------------
%------- CÓDIGO -----------------------------------------------------------
%------- Proyecto 1 -------------------------------------------------------
%------- Por: Maria Camila Gomez maria.gomez26@udea.edu.co ----------------
%-------      CC 1152454724 -----------------------------------------------
%------- Por: Santiago Romero santiago.romero@udea.edu.co -----------------
%-------      CC 1026154938 -----------------------------------------------
%------- Por: Milena Cardenas milena.cardenas@udea.edu.co -----------------
%-------      CC 1036934864 -----------------------------------------------
%------- Curso Básico de Procesamiento de Imágenes y Visión Artificial-----
%------- Marzo de 2017-----------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--1. Inicializo el sistema -----------------------------------------------
%--------------------------------------------------------------------------

%Limpiamos
clear all
close all
clc
%Leemos desde la cámara IP
url = 'http://192.168.1.55:8080/photo.jpg';
%Conectamos el arduino
% ard = arduino('COM3', 'Uno');
% out1 ='D13';
% out2 ='D12';
% out3 ='D8';
% out4 ='D7';

%--------------------------------------------------------------------------
%-- 2. Lectura de la imagen  ----------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%Para la camara del PC se utilizan las siguientes lineas de codigo
%camara =videoinput('winvideo',1,'MJPG_1280x720');
%imagen = getsnapshot(camara); %b=imresize(b, 0.5);
%Para leer imagenes que ya estan en la base de datos
imagen = imread('imagen_2.jpg');
%--------------------------------------------------------------------------

while(1)
    tic
%     writeDigitalPin(ard, out1, 1);%Adelante izquierda
%     writeDigitalPin(ard, out2, 0);%Atras izquierda
%     writeDigitalPin(ard, out3, 1);%Adelante derecha
%     writeDigitalPin(ard, out4, 0);%Atras derecha
    %Captuta de la imagen
	%imagen  = imread(url);
    [fil,col,cap]=size(imagen);
    
%--------------------------------------------------------------------------
%-- 3. Sepera la imagen en sus tres componentes CMY  ----------------------
%--------------------------------------------------------------------------
    %Se trae la componente M de CMY
    [componente] = componentes(imagen);

%--------------------------------------------------------------------------
%-- 4. Sepera la imagen en sus cuatro componentes SCMY  -------------------
%--------------------------------------------------------------------------

    %Para señales rojas
    min1 = componente;
    min1(min1<150)=0;
    min1(min1>0)=255;
    min1 = [min1,min1,min1];
    min1 = reshape(min1,[fil,col,cap]);
    copiaImagen = imagen;
    copiaImagen(min1==0)=0;
    
%--------------------------------------------------------------------------
%-- 5. Segmentar la imagen y eliminar ruido -------------------------------
%--------------------------------------------------------------------------
    if cap>1
        copiaImagen=rgb2gray(copiaImagen); 
    end;
    copiaImagen = imclearborder(copiaImagen);
    
    [l,n] = bwlabel(copiaImagen);
    LB = 1000; % Area minima
    UB = 500000; % Area maxima
    % Eliminar objetos que no esten en el rango
    sinRuido = xor(bwareaopen(l,LB),  bwareaopen(l,UB));

    ee= strel('square',2);
    sinRuido = imdilate(sinRuido,ee);

    % Se hace dilatacion y luego erosion para unir las partes de la figura
    ee= strel('square', 15);
    sinRuido = imdilate(sinRuido,ee);
    ee = strel('square', 11);
    sinRuido = imerode(sinRuido,ee);

    % Se llenan los huecos de la señal
    sinRuido = imfill(sinRuido,'holes');
    % Se limpian los bordes
    sinRuido = imclearborder(sinRuido);

    %Estiramos la imagen
    sinRuido = [sinRuido,sinRuido,sinRuido];
    imagenDos = imagen;

    imagenDos(sinRuido==0)=0;

    [fil_o, col_o, cap]= size(imagenDos);
    if cap>1; imagen2=rgb2gray(imagenDos); end;
    
    [l,n] = bwlabel(imagen2);
    imagenes = [];
    respuesta = [];
    cont=0;
    for i = 1:n
        figura=imagen2*0; 
        figura(l==i)=255;
        recorte = recortar(figura, imagenDos);
        porcentaje = reconocedor(recorte, i);
        respuesta = [respuesta; porcentaje];
        cont = cont+1;
    end

     queHacer = 'Que hago?'
     respuesta = str2num(respuesta)
     if(respuesta == 1)
        pare = 'pare'
%         writeDigitalPin(ard, out1, 0);%Adelante izquierda
%         writeDigitalPin(ard, out2, 0);%Atras izquierda
%         writeDigitalPin(ard, out3, 0);%Adelante derecha
%         writeDigitalPin(ard, out4, 0);%Atras derecha
%         pause(2);
     %El carro gira a la izquierda
     elseif (respuesta==3)
        izqu = 'izquierda'
%         writeDigitalPin(ard, out1, 0);%Adelante izquierda
%         writeDigitalPin(ard, out2, 0);%Atras izquierda
%         writeDigitalPin(ard, out3, 1);%Adelante derecha
%         writeDigitalPin(ard, out4, 0);%Atras derecha
%         pause(2);
     %El carro gira a la derecha
     elseif (respuesta==2)
        derecha = 'derecha'
%         writeDigitalPin(ard, out1, 1);%Adelante izquierda
%         writeDigitalPin(ard, out2, 0);%Atras izquierda
%         writeDigitalPin(ard, out3, 0);%Adelante derecha
%         writeDigitalPin(ard, out4, 0);%Atras derecha
%         pause(2);
    end
       
    toc
end