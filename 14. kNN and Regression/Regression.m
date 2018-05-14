function Regression(k, n)            

load('datos_regresion');

D=zeros(n,1);
Dtst=zeros(n,1);

for i=1:n
    for j=1:size(trn, 1)
        D(j)=sqrt(sum((trn(j,1:8)-tst(i,1:8)).^2));
    end    
    
    [sorted_x, index] = sort(D,'ascend');  
    
    for l=1:k
        Dtst(i)=Dtst(i)+trn(index(l),9);
    end
    Dtst(i)=Dtst(i)/k;
end

err = mean(minus(Dtst,tst(1:n,9)).^2);

plot(tst(1:n,9),'b.-');
hold on
plot(Dtst,'r.-');
hold off;
legend(strcat(int2str(n),' Vecinos observados'),strcat(int2str(n),' Vecinos predictos'))
title(strcat('Regresion con k=',int2str(k),' Mean squares Error = ',strcat(int2str(err))))
end
