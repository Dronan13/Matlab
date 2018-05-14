function [error] = nbayes(trn,tst,trnY,tstY)

    D=trn;    
    C=(trnY==1);
    Cy=C;
    test=tst;
    tY=tstY;
    
    n=size(D,2);
    szt=size(test,1);
    
    P1=zeros(1,n);
    P0=zeros(1,n);
    P=zeros(1,szt);

    PCA1=size(C(C==1),1)/size(C,1);
    PCA0=size(C(C==0),1)/size(C,1);
    PC1=D(C==1,:);
    PC0=D(C==0,:);
    
        m0=mean(PC0);
        s0=var(PC0);
        m1=mean(PC1);
        s1=var(PC1);
        for j = 1:szt
            ds=test(j,:);  
            for i = 1:n
                P0(1,i)=log10(sum(normpdf(ds(:,i),m0(i),s0(i))));
                P1(1,i)=log10(sum(normpdf(ds(:,i),m1(i),s1(i))));
            end
                Ps1=sum(P1)+log10(PCA1);
                Ps0=sum(P0)+log10(PCA0);        
            if Ps0 < Ps1
                P(1,j)=1;
            else
                P(1,j)=0;
            end;
        end; 
    count=0;
    for j = 1:szt
        if P(j)==tY(j)
          count=count+1;
        end;
    end;
    error=1-(count/size(P,2));
end

