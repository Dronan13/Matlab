clc;
load('datos_wdbc.mat');
datos = trn.xc(:,1);

%M�todo 1: Equal-width
N=10;
EqualWidth(datos,N);
fprintf('\n\n\n');

%M�todo 2: Equal-frequency
F=23;
EqualFrequency(datos,F)