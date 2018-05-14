function kNN(k)
load('datos_clasificacion');

med=ceil(k/2);
D=zeros(size(trn,1),1);
Dtst=zeros(size(tst,1),1);

for i=1:size(tst,1)
    
    for j=1:size(trn,1)
        D(j)=sqrt((trn(j,1)-tst(i,1))^2+(trn(j,2)-tst(i,2))^2);
    end    
    
    [sorted_x, index] = sort(D,'ascend');  
    
    for l=1:k
        if trn(index(l),3)==1
            Dtst(i)=Dtst(i)+1;
        end
    end
end

for j=1:size(tst,1)
    if Dtst(j)<med
    	Dtst(j)=2;
    else
        Dtst(j)=1;
    end
end
fprintf('Datos Predictos');fprintf('\n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
    tabulate(Dtst);
fprintf(repmat('-',1,30),'\n');fprintf('\n');fprintf('\n');

fprintf('Datos Reales(trn)');fprintf('\n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
    tabulate(trn(:,3));
fprintf(repmat('-',1,30),'\n');fprintf('\n');

figure
subplot(1,2,1)
scatter(trn(:,1),trn(:,2),7,trn(:,3),'filled');hold on;
plot(tst(:,1),tst(:,2),'g*');hold off;
title('Datos Originales')

subplot(1,2,2)
scatter(trn(:,1),trn(:,2),7,trn(:,3),'filled');hold on;
scatter(tst(:,1),tst(:,2),7,Dtst,'filled');hold off;
title('Datos Clasificados')

for j=1:size(tst,1)
    if Dtst(j)==tst(j,3)
    	Dtst(j)=1;
    else
        Dtst(j)=0;
    end
end
fprintf(repmat('-',1,30),'\n');fprintf('\n');
fmt = 'Error of prediction: %6.2f%%\n';
fprintf(fmt, 1-(sum(Dtst))/size(Dtst,1));

fprintf(repmat('-',1,30),'\n');fprintf('\n');
end
% figure(3)
% plot(tst(:,1),'b.-');hold on;
% plot(tst(:,2),'r.-');hold on;


