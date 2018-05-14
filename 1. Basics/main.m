% Ejercicios en MATLAB.
% 
% **** SALVO EL EJERCICIO 5, TODOS LOS EJERCICIOS DEBERÁN SER RESUELTOS CON UNA SOLA INSTRUCCIÓN
% 


% 1. Crear una matriz A de tamaño 20 x 40 donde los renglones de 1-10 sean 1 y el resto de
%    renglones sea 2. 

   A=ones(20,40);
   A=cat(1,A(1:10,1:40),A(11:20,1:40)*2);
   A=cat(1,ones(10,40),ones(10,40)*2);
   disp('La matriz A : ');
   disp(A);
   
   
% 2. Crear una matriz B la cual sea igual a una matriz A pero la diagonal principal es cero.
    A=ones(10,10);
    B=A;
    p=size(B);
    v=zeros(1,p(1:1));
    B(1:p(1:1)+1:end) = v;
    disp('La matriz B : ');
    disp(B); 
    
    
% 3. Dado un vector C aleatorio de 15 elementos. Hacer negativos los elementos mayores
%   a 0.5. La instrucción para generar los números aleatorios es adicional.  
  C=rand(1,15);
  C1=C;
  C1(find(C1>0.5))=C1(find(C1>0.5))*(-1);
  disp('El vector inicial C : ');
  disp(C);
  disp('El vector transformado C : ');
  disp(C1);
  
  
% 4. Sean dos vectores D=[2 4 5 3] y E=[6 8 7 9], calcular la distancia euclideana entre
% ellos.
 D=[2 4 5 3];
 E=[6 8 7 9];
 dist  = sqrt(sum((D - E) .^ 2));
 disp('la distancia euclideana entre D y E: ');
 disp(dist);
 
 
% 5. La trayectoria de una bala esta dada por las siguientes ecuaciones:

%                x_i = Vo*cos(theta)*ti              POSICION EN X
%                y_i = Vo*sin(theta)*ti-0.5*g*ti^2;  POSICION EN Y
%                T   = 2*Vo*sin(theta)/g;            TIEMPO TOTAL DE VUELO
% 
%                          donde g=9.8m/s^2
% 
%    calcule y grafíque la trayectoria para:
% 
%                                    Vo    = 100m/s
%                                    theta = 10 grados

Vo = 100;
theta = degtorad(10);
g=9.8;
T = 2*Vo*sin(theta)/g;

ti=[.0:.4:T];
x_i = ti.*(Vo*cos(theta));
y_i = ti.*(Vo*sin(theta))-ti.^2*0.5*g;

plot(x_i,y_i);

grid on;
axis([0 inf 0 inf]);
