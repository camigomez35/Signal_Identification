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
disp('Reconocedor de señales de transito');

%Lectura de la cámara IP o del PC
%cam = videoinput('winvideo',2 ,'MJPG_1280x720');
cam = videoinput('winvideo',1 ,'RGB24_640x480');
disp('Enlace con camara ip establecido');
preview(cam);

%Iniciacilizamos conexión modulo Bluetooth
modulo_b = Bluetooth('HC-05',1);
fopen(modulo_b);
disp('Enlace con modulo Bluetooth establecido');
fwrite(modulo_b, 40);

%--------------------------------------------------------------------------
%-- 2. Lectura de la imagen  ----------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%Para la camara del PC se utilizan las siguientes lineas de codigo
%camara =videoinput('winvideo',1,'MJPG_1280x720');
%imagen = getsnapshot(camara); %b=imresize(b, 0.5);
%Para leer imagenes que ya estan en la base de datos
%imagen = imread('imagen_2.jpg');
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%-- 3. Procesamiento de imagenes-------------------------------------------
%--------------------------------------------------------------------------

while(1)
    tic
    %Captura de la imagen cada que se reinicia el While
	imagen = getsnapshot(cam);
    [fil,col,cap]=size(imagen);
    
%--------------------------------------------------------------------------
%-- 3.1. Separa la imagen en sus tres componentes CMY  --------------------
%--------------------------------------------------------------------------
    %Se trae la componente M de CMY
    [componente] = componentes(imagen);

%--------------------------------------------------------------------------
%-- 3.2. Sepera la imagen en sus cuatro componentes SCMY  -----------------
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
%-- 3.3. Segmentar la imagen y eliminar ruido -----------------------------
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
%-----------------------------<---------------------------------------------
%-- 4. Enviar información via Bluetooth al arduino-------------------------
%--------------------------------------------------------------------------
     mensaje = '';
     if cont >1
        for i = 1:cont
            resp = respuesta(i);
            resp = str2num(resp);
            switch resp
                case 1
                    mensaje = 'Pare';
                    fwrite(modulo_b, 30);
                case 3
                    mensaje = 'Derecha';
                    fwrite(modulo_b, 10);
                case 2
                    mensaje = 'Izquierda';
                    fwrite(modulo_b, 20);
                otherwise
                    mensaje = 'Adelante';
                    fwrite(modulo_b, 40);
            end
            disp(mensaje);
        end
     elseif cont == 1         
         respuesta = str2num(respuesta);
         switch respuesta
             case 1
                mensaje = 'Pare';
                fwrite(modulo_b, 30);
             case 3
                mensaje = 'Izquierda';
                fwrite(modulo_b, 20);
             case 2
                mensaje = 'Derecha';
                fwrite(modulo_b, 10);
             otherwise
                mensaje = 'Adelante';
                fwrite(modulo_b, 40);
         end
     end
     disp(mensaje);
     toc
end