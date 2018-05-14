clc;
y=100*rand(1,20);

a=0;b=1;
y1=a+(y-min(y))*(b-a)/(max(y)-min(y));

a=-1;b=1;
y2=a+(y-min(y))*(b-a)/(max(y)-min(y));

a=0;b=10;
y3=a+(y-min(y))*(b-a)/(max(y)-min(y));

fprintf('         Xi      [0,1]   [-1,1]   [0,10]\n');

fprintf(repmat('-',1,45),'\n');fprintf('\n');

fmt = '      %6.2f   %6.2f   %6.2f   %6.2f \n';
fprintf(fmt, [y',y1',y2',y3'].' );

fprintf(repmat('-',1,45),'\n');fprintf('\n');

fmt = 'MAX   %6.2f   %6.2f   %6.2f   %6.2f \n';
fprintf(fmt,max(y),max(y1),max(y2),max(y3));
fmt = 'MIN   %6.2f   %6.2f   %6.2f   %6.2f \n';
fprintf(fmt,min(y),min(y1),min(y2),min(y3));

figure;
ax1 = subplot(2,1,1);
plot(y);
title(ax1,'Origin');

ax2 = subplot(2,1,2);
plot(y1,'r');
hold on;
plot(y2,'g');
hold on;
plot(y3,'b');
title(ax2,'Datos normalizados');
hold off;

mu=[-4 5];
sigma=[30 10 ; 10 60];
num=50;

Xor = mvnrnd(mu, sigma, num);
mx = mean(Xor);
sx = std(Xor);
cv=cov(Xor);

Xmedia = Xor - ones(size(Xor, 1), size(mx, 1)) * mx;
mxm = mean(Xmedia);
sxm = std(Xmedia);
cvm=cov(Xmedia);

Xms = bsxfun(@rdivide, Xmedia, sx);
mxs = mean(Xms);
sxs = std(Xms);
cvs=cov(Xms);

fmtm = 'Mediana    =   %12.4f   %12.4f   \n';
fmts = 'Varianza   =   %12.3f   %12.3f   \n';
fmtc = 'Covarianza =   \n               %6.3f   %6.3f   \n               %6.3f   %6.3f   \n';

fprintf('\n');fprintf('\n');
fprintf('Estandarization del datos');
fprintf('\n');fprintf(repmat('*',1,35),'\n');fprintf('\n');
fprintf('Datos originales');fprintf('\n');

fprintf(fmtm,mx);
fprintf(fmts,sx);
fprintf(fmtc,cv);

fmtm = 'Mediana    =   %12.4d   %12.4d   \n';
fmts = 'Varianza   =   %12.3f   %12.3f   \n';
fmtc = 'Covarianza =   \n               %6.3f   %6.3f   \n               %6.3f   %6.3f   \n';

fprintf('\n');fprintf(repmat('-',1,35),'\n');fprintf('\n');
fprintf('X-media');fprintf('\n');
fprintf(fmtm,mxm);
fprintf(fmts,sxm);
fprintf(fmtc,cvm);


fmtm = 'Mediana    =   %6.0f   %6.0f   \n';
fmts = 'Varianza   =   %6.0f   %6.0f   \n';
fmtc = 'Covarianza =   \n               %6.4f   %6.4f   \n               %6.4f   %6.4f   \n';
fprintf('\n');fprintf(repmat('-',1,35),'\n');fprintf('\n');
fprintf('(X-media)/sigma');fprintf('\n');
fprintf(fmtm,mxs);
fprintf(fmts,sxs);
fprintf(fmtc,cvs);

figure;
axor = subplot(3,1,1);
scatter(Xor(:,1),Xor(:,2));
title(axor,'Datos originales');
grid on;
axis equal;
axis([-30 30 -30 30]);

axor = subplot(3,1,2);
scatter(Xmedia(:,1),Xmedia(:,2));
title(axor,'X-media');
grid on;
axis equal;
axis([-30 30 -30 30]);

axor = subplot(3,1,3);
scatter(Xms(:,1),Xms(:,2));
title(axor,'(X-media)/sigma');
grid on;
axis equal;
axis([-30 30 -30 30]);
