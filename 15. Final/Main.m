clc; clear all;
load('datos_practica.mat');

[X,sF,iF] = FisherScore(trn.xc,trn.y,trn.l);
r=32;
X=X(:,1:r);

figure;
plot(sF(:,1:r),'b.-');
title('Fisher Score');

spec = (trn.y==1)';
n=trn.n;

[COEFF,SCORE,latent,tsquared,qe] = pca(X);
C = SCORE*COEFF';
C=C';

qe=qe./100; qe=qe';
qi=(1:n);

fprintf('Variation captured by first 31 components\n');
fprintf(repmat('-',1,20),'\n');fprintf('\n');
fprintf('|  N   |    Expl   |\n')
fprintf(repmat('-',1,20),'\n');fprintf('\n');
fmt = '|  %4.0f|   %6.3f  |\n';
fprintf(fmt,[qi(:,1:r-1)', qe(:,1:r-1)'].' );% part of variation captured by first n components, explained(:,1:20)'
fprintf(repmat('-',1,20),'\n');fprintf('\n');
fprintf(fmt,[10, sum(qe(:,1:10))].' );% part of variation captured by first n components
fprintf(repmat('-',1,20),'\n');fprintf('\n');fprintf('\n');

figure;
plot(qe,'b.-');
xlabel('N'); ylabel('X');
title('Part of variation captured by first n components');

figure;
scatter(C(1,:),C(2,:),17,spec,'filled')
xlabel('PC1'); ylabel('PC2')
title(sprintf('3 components, captures %.4g%% of total variation',100*sum(qe(:,1:3))))

figure;
scatter3(C(1,:),C(2,:),C(3,:),27,spec,'filled')
xlabel('PC1'); ylabel('PC2'); zlabel('PC3')
title(sprintf('3 components, captures %.4g%% of total variation',100*sum(qe(:,1:3))))


xval=20;

errResF=zeros(r,5);

for j=1:r
    errRes=zeros(xval,4);
    for i=1:xval
        [Train, Test] = crossvalind('HoldOut', n, 0.30);
        
        %trn=C(1:j,Train)';
        %tst=C(1:j,Test)';                
        trn=X(Train,1:j);
        tst=X(Test,1:j);
        
        trnY=spec(:,Train)';
        tstY=spec(:,Test)';

        en=nbayes(trn,tst,trnY,tstY);
        eknn=VecinosCercanos(5,trn,tst,trnY,tstY);                    
        eldc=LDC(trn,trnY,tst,tstY);
        eqdc=QDC(trn,trnY,tst,tstY);
        errRes(i,:)=[en, eknn, eldc, eqdc];
    end
    errResF(j,:)=[j, sum(errRes)./xval];
end

en=FiltroMedia(errResF(:,2)', 3);
eknn=FiltroMedia(errResF(:,3)', 3);
eldc=FiltroMedia(errResF(:,4)', 3);
eqdc=FiltroMedia(errResF(:,5)', 3);

fprintf('xValidation errors\n');
fprintf(repmat('-',1,60),'\n');fprintf('\n');
fprintf('|  N      |   nbyas   |     knn   |     ldc   |     qdc   |\n')
fprintf(repmat('-',1,60),'\n');fprintf('\n');
fmt = '|   %4.0f  |   %6.3f  |   %6.3f  |   %6.3f  |   %6.3f  |\n'; % %4.0f|   qi',
fprintf(fmt,[errResF(1:r,:)].');
fprintf(repmat('-',1,60),'\n');fprintf('\n');

figure;
subplot(4,1,1);
plot(errResF(:,2),'b-*'); hold on; plot(en,'r-'); hold off; title('Naive bayes ');
subplot(4,1,2);
plot(errResF(:,3),'b-*'); hold on; plot(eknn,'r-'); hold off; title('kNN ');
subplot(4,1,3);
plot(errResF(:,4),'b-*'); hold on; plot(eldc,'r-'); hold off; title('LDC ');
subplot(4,1,4);
plot(errResF(:,5),'b-*'); hold on; plot(eqdc,'r-'); hold off; title('QDC ');

gns=spc.gn(iF(:,1:3),:)

