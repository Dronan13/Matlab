function [datos, score, index] = FisherScore(datos,clases,l)
    clases=(clases==1);
    mu_c1 = zeros(1,l);
    mu_c2 = zeros(1,l);

    sigma_c1 = zeros(1,l);
    sigma_c2 = zeros(1,l);

    fisherScore = zeros(1,l);

    for i=1:l
        dc1=datos((clases==1),i);
        dc2=datos((clases==0),i);    
        mu_c1(i)=mean(dc1);
        sigma_c1(i)=std(dc1);    
        mu_c2(i)=mean(dc2);
        sigma_c2(i)=std(dc2);         
        fisherScore(i)=((mu_c1(i)-mu_c2(i))^2)/(sigma_c1(i)^2+sigma_c2(i)^2);
    end

    [score,index] = sort(fisherScore,'descend');
    datos=datos(:,index);
end
