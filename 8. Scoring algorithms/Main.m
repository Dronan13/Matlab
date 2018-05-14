clc; clear all;
load('ma_mediast_01.mat');

datos = trn.xc;
clases = trn.y;

mu_c1 = zeros(1,trn.l);
mu_c2 = zeros(1,trn.l);

sigma_c1 = zeros(1,trn.l);
sigma_c2 = zeros(1,trn.l);

tTest = zeros(1,trn.l);
fisherScore = zeros(1,trn.l);
golubScore = zeros(1,trn.l);

for i=1:trn.l
    dc1=datos((clases==1),i);
    dc2=datos((clases==2),i);
    
    mu_c1(i)=mean(dc1);
    sigma_c1(i)=std(dc1);
    
    mu_c2(i)=mean(dc2);
    sigma_c2(i)=std(dc2);   
    
    tTest(i)=abs(mu_c1(i)-mu_c2(i))/sqrt(sigma_c1(i)^2/(size(dc1,1)-1)+sigma_c2(i)^2/(size(dc2,1)-1));    
    fisherScore(i)=((mu_c1(i)-mu_c2(i))^2)/(sigma_c1(i)^2+sigma_c2(i)^2);
    golubScore(i) = abs(mu_c1(i)-mu_c2(i))/(sigma_c1(i)+sigma_c2(i));
end

[B1,I1] = sort(tTest,'descend');
figure;
axs=subplot(4,1,1);
plot(B1,'-b','linewidth',2);
grid on;
title('t-Test Score');
fprintf('t-Test: ');
disp(I1(1:5));


[B2,I2] = sort(fisherScore,'descend');
axs=subplot(4,1,2);
plot(B2,'-r','linewidth',2);
grid on;
title('Fisher Score');
fprintf('Fisher Score: ');
disp(I2(1:5));

[B3,I3] = sort(golubScore,'descend');
axs=subplot(4,1,3);
plot(B3,'-g','linewidth',2);
grid on;
title('Golub Score');
fprintf('Golub Score: ');
disp(I3(1:5));

axs=subplot(4,1,4);
y=1:10;
p1=plot(normalab(B1(1,1:10),0,100),'-b*','linewidth',2,'DisplayName','t-Test Score');
hold on;
plot(normalab(B2(1,1:10),0,100),'-r*','linewidth',2,'DisplayName','Fisher Score');
hold on;
plot(normalab(B3(1,1:10),0,100),'-g*','linewidth',2,'DisplayName','Golub Score');
hold off;
grid on;
title('Normalized comparison (Best ten)');
suptitle('Filtro de la media/mediana');
xlabel({strcat('t-Test Score values: ',num2str(I1(1:10)));strcat('Fisher Score values: ',num2str(I2(1:10)));strcat('Golub Score values: ',num2str(I3(1:10)))})

legend('show','Location','northeast');
