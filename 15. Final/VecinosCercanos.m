function [error] = VecinosCercanos(k,trn,tst,trnY,tstY)
med=ceil(k/2);
D=zeros(size(trn,1),1);
Dtst=zeros(size(tst,1),1);

for i=1:size(tst,1)  
    for j=1:size(trn,1)
        D(j)=sqrt(sum((trn(j,:)-tst(i,:)).^2));
    end    
    
    [sorted_x, index] = sort(D,'ascend');  
    
    for l=1:k
        if trnY(index(l),1)==1
            Dtst(i)=Dtst(i)+1;
        end
    end
end

for j=1:size(tst,1)
    if Dtst(j)<med
    	Dtst(j)=0;
    else
        Dtst(j)=1;
    end
end

% fprintf('Datos Predictos ');fprintf('\n');
% fprintf(repmat('-',1,30),'\n');fprintf('\n');
%     tabulate(Dtst);
% fprintf(repmat('-',1,30),'\n');fprintf('\n');fprintf('\n');
% 
% fprintf('Datos Predictos (originales)');fprintf('\n');
% fprintf(repmat('-',1,30),'\n');fprintf('\n');
%     tabulate(tstY);
% fprintf(repmat('-',1,30),'\n');fprintf('\n');fprintf('\n');
% 
% fprintf('Datos Reales(traning)');fprintf('\n');
% fprintf(repmat('-',1,30),'\n');fprintf('\n');
%     tabulate(trnY(:,1));
% fprintf(repmat('-',1,30),'\n');fprintf('\n');

% figure
% subplot(1,2,1)
% scatter(trn(:,1),trn(:,2),7,trnY(:,1),'filled');hold on;
% plot(tst(:,1),tst(:,2),'g*');hold off;
% title('Datos Originales')
% 
% subplot(1,2,2)
% scatter(trn(:,1),trn(:,2),7,trnY(:,1),'filled');hold on;
% scatter(tst(:,1),tst(:,2),7,Dtst,'filled');hold off;
% title('Datos Clasificados')

for j=1:size(tst,1)
    if Dtst(j)==tstY(j,1)
    	Dtst(j)=1;
    else
        Dtst(j)=0;
    end
end
error=1-(sum(Dtst))/size(Dtst,1);
% fprintf(repmat('-',1,30),'\n');fprintf('\n');
% fmt = 'Error de prediccion: %6.2f\n';
% 
% fprintf(fmt, error);
% fprintf(repmat('-',1,30),'\n');fprintf('\n');
end


