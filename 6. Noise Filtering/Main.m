clc;
load('data_w_noise.mat');

W=13;

datos=FiltroMedia(x1, W);

figure
axs=subplot(4,1,1);
plot(x1, '-b*');
hold on;
graph1 = plot(datos, '-r');
set(graph1,'LineWidth',2);
grid on;
title('Ejemplo x1')

datos=FiltroMedia(x2, W);

axs=subplot(4,1,2);
plot(x2, '-b*');
hold on;
graph1 = plot(datos, '-r');
set(graph1,'LineWidth',2);
grid on;
title('Ejemplo x2')

datos=FiltroMedia(x3, W);

axs=subplot(4,1,3);
plot(x3, '-b*');
hold on;
graph1 = plot(datos, '-r');
set(graph1,'LineWidth',2);
grid on;
title('Ejemplo x3')

datos=FiltroMedia(x4, W);

axs=subplot(4,1,4);
plot(x4, '-b*');
hold on;
graph1 = plot(datos, '-r');
set(graph1,'LineWidth',2);
grid on;
title('Ejemplo x4');
suptitle('Filtro de la media/mediana');