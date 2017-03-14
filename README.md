#*Curso Procesamiento Digital de imágenes*
*Universidad de Antioquia*

### __*Juego con Arduino*__

Este proyecto fue realizado para el primer trabajo del curso __Procesamiento Digital de Imágenes (PDI)__ del programa Ingeniería de Sistemas de la Universidad de Antioquia. 

Lenguajes de programación utilizados:

+ MATLAB
+ C - Arduino

Hardware requerido:

+ Arduino 
+ Modulo Bluetooth 
+ Puente H
+ Motores
+ Cámara

###__*Objetivo*__

Reconocer señales de tránsito mediante __PDI__ y lograr que un carro de juguete entienda éstas señales y cumpla con lo indicado por la señal.

Las tres señales a reconocer son: 

+ Pare
+ Giro a la derecha
+ Giro a la izquierda

###__*¿Cómo funciona?*__

__1. Cámara:__ Se realiza conexión por medio de una cámara conectada al computador donde se tiene corriendo el programa desarrollado. 

__2. Bluetooth:__ Se realiza una conexión vía bluetooth con el arduino previamente configurado con el código que interpreta un serial, el cual le indica hacia dónde dirigirse.

__3. Captura y procesado de la imagen:__ El programa estará constantemente tomando Frames a los cuales les realizará un procesamiento previo con la intensión de eliminar información innecesaria de la imagen y donde sobrevivirá la información deseada. De allí, por medio de una comparación directa con las señales guardadas en la base de datos (Carpeta señales) se encontrarán los pixeles que coincidan e indicará cual es aquella que tiene mayor similitud.

__4. Envío de datos:__ Por medio del serial conectado al Bluetooth se enviará la señal que corresponda según la señal identificada. En caso de no identificar ninguna el carrito seguirá su camino.

###__*Nota*__

+ Se debe correr el script llamado Main.
+ Se debe identificar la cámara y las características de la misma que se utilizará  ```imaqhwinfo```
