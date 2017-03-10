#*Curso Procesamiento Digital de imágenes*
*Universidad de Antioquia*

### __*Juego con Arduino*__

Este proyecto fue realizado para el primer trabajo del curso __Procesamiento Digital de Imagenes (PDI)__ del programa Ingerniería de Sistemas de la Universidad de Antioquia. 

Lenguajes de programación utilizados:

+ MATLAB
+ C - Arduino

Hardware requerido:

+ Arduino 
+ Modulo Bluetooth 
+ Puente H
+ Motores
+ Camara

###__*Objetivo*__

Reconocer señales de tránsito mediante __PDI__ y lograr que un carro de juguete entienda éstas señales y cumpla con lo indicado por la señal.

Las tres señaes a reconocer son: 

+ Pare
+ Giro a la derecha
+ Giro a la izquierda

###__*¿Como funciona?*__

__1. Camara:__ Se realiza conección por medio de una camara conectada al computador donde se tiene corriendo el programa desarrollado. 

__2. Bluetooth:__ Se realiza una conección via bluetooth con el arduino previemente configurado con el código que interpreta un serial, el cual le indica hacia donde dirigirse.

__3. Captura y procesado de la imagen:__ El programa estará constantemente tomando Frames a los cuales les realizará un procesamiento previo con la intensión de eliminar información innecesaria de la imagen y donde sobrevivirá la información deseada. De allí, por medio de una comparación directa con las señales guardadas en la base de datos (Carpeta señales) se encontrarán los pixeles que coincidan e indicará cual es aquella que tiene mayor similutd.

__4. Envio de datos:__ Por medio del serial conectado al Bluetoothse enviará la señal que corresponda según la señal identificada. En caso de no identificar ninguna el carrito sseguirá su camino.

###__*Nota*__

+ Se debe correr el script llamado Main.
+ Se debe identificar la camara y las caracteristicas de la misma que se utilizará  ```imaqhwinfo```
