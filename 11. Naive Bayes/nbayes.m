function [P, tY, pc] = nbayes(type,prs)
    if strcmp(type,'dscr')
        load('datos_discretos.mat');
        n=50;
    else
        load('datos_continuos.mat');
        n=15;
    end

    szd=floor(size(X,1)*prs);
    sz=size(X,1);
    D=X(1:szd,1:n);
    C=Y(1:szd,1);
    C=(C==1);
    Cy=(Y==1);

    test=X(szd+1:sz,1:n);
    tY=Cy(szd+1:sz,1);

    szt=size(test,1);
    P1=zeros(1,n);
    P0=zeros(1,n);
    P=zeros(1,szt);

    PCS1=size(C(C==1),1);
    PCS0=size(C(C==0),1);
    PCA1=size(C(C==1),1)/size(C,1);
    PCA0=size(C(C==0),1)/size(C,1);
    PC1=D(C==1,:);
    PC0=D(C==0,:);

    fprintf(repmat('-',1,30),'\n');fprintf('\n');
    tabulate(Cy);
    fprintf(repmat('-',1,30),'\n');fprintf('\n');

    if strcmp(type,'dscr')
        for j = 1:szt
            ds=test(j,:);
            for i = 1:n
                P1(1,i)=log10(sum(PC1(:,i)==ds(1,i))/(PCS1));
                P0(1,i)=log10(sum(PC0(:,i)==ds(1,i))/(PCS0));
            end
            Ps1=sum(P1)+log10(PCA1);
            Ps0=sum(P0)+log10(PCA0);
            if Ps1 < Ps0
                P(1,j)=0;
            else
                P(1,j)=1;
            end;
        end;
    else  
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
    end

    count=0;
    for j = 1:szt
        if P(j)==tY(j)
          count=count+1;
        end;
    end;
    pc=(count/size(P,2))*100;
end

