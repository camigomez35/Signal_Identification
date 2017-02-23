%--------------------------------------------------------------------------
%------- PLANTILLA DE CÓDIGO ----------------------------------------------
%------- Coceptos básicos de PDI-------------------------------------------
%------- Por: David Fernández    david.fernandez@udea.edu.co --------------
%-------      Profesor Facultad de Ingenieria BLQ 21-409  -----------------
%-------      CC 71629489, Tel 2198528,  Wpp 3007106588 -------------------
%------- Curso Básico de Procesamiento de Imágenes y Visión Artificial-----
%------- V2 Abril de 2015--------------------------------------------------
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%--1. Inicializo el sistema -----------------------------------------------
%--------------------------------------------------------------------------

clear all   % Inicializa todas las variables
close all   % Cierra todas las ventanas, archivos y procesos abiertos
clc         % Limpia la ventana de comandos

%--------------------------------------------------------------------------
%-- 2. Paso de imagen a color en sus componentes RGB  ---------------------
%--------------------------------------------------------------------------

%---- Se toma la imagen de pimientos que trae matlab -------------------------

X=imread('Peppers.PNG');% cargo las variables que contienen la imagen de pimientos (X)
figure(1)               % abro una ventana en matlab exclusiva (1) para mostrarla
imshow(X)               % se muestra en la figura (1) la imagen del pimientos

%---- Se extrae las componentes R G B  ------------------------------------

R=X;G=X;B=X;    % Realizo la copia de la imagen a las tres componentes
R(:,:,2:3)=0;   % Las capas verde y azul las vuelvo 0 para que quede la roja
G(:,:,1:2:3)=0; % Las capas roja y azul las vuelvo 0 para que quede la verde
B(:,:,1:2)=0;   % Las capas roja y verde las vuelvo 0 para que quede la azul

%---- Se muestra en composición las 4 imagenes  ---------------------------

figure(2)       % Se crea la figura donde se muestran las componentes
subplot(2,2,1)  % Se divide la ventana en 2 filas x 2 columnas de imagenes
imshow(X)       % en la primera se muestra el pimientos
subplot(2,2,2)  % En la segunda
imshow(R)       % Se muestra la componente roja
subplot(2,2,3)  % En la tercera
imshow(G)       % Se muestra la componente verde
subplot(2,2,4)  % En la cuarta
imshow(B)       % Se muestra la componente azul
impixelinfo     % Sobre la imagen muestra las componentes RGB del punto 
                %   señalado por el cursor

%--------------------------------------------------------------------------
%---------------------------  FIN DEL PROGRAMA ----------------------------
%--------------------------------------------------------------------------
