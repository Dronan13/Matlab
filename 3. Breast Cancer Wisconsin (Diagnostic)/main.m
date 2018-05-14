clc;
clear;

load('datos_wdbc.mat');

col=1;
row=1;

datos=trn.xc(:,col);
% 
k=0.5;
Quartiles(datos,k);
% 
datos=trn.xc(:,col);
TauThompson(datos);
 
datos=trn.xc;
ChiSq(datos);
