function [error] = QDC(trn,trnY,tst,tstY)
        datos=trn;
        Cc=trnY(:,1);
        m = mean(datos);

        DC0 = (datos(Cc==0,:));
        mDC0 = mean(DC0);
        DC0 = DC0 - ones(size(DC0, 1), size(mDC0, 1)) * mDC0;
        covDC0=cov(DC0);

        DC1=(datos(Cc==1,:));
        mDC1=mean(DC1);
        DC1 = DC1 - ones(size(DC1, 1), size(mDC1, 1)) * mDC1;
        covDC1=cov(DC1);

        s0=size(DC0,1); 
        s1=size(DC1,1); 
        sp0=s0/(s0+s1); 
        sp1=s1/(s0+s1);

        Cp=(s0*covDC0+s1*covDC1)/(s0+s1);
        Cp=inv(Cp);

        t = tst - ones(size(tst, 1), size(m, 1)) * m;

        CtstQ=zeros(size(t,1),1);

        for ii=1:size(tst,1)
            t = tst(ii,:) - ones(size(tst(ii,:), 1), size(mDC0, 1)) * mDC0;
            f0(ii,1) = sum([-0.5*t*diag(inv(covDC0))*t mDC0*inv(covDC0).*t -0.5*mDC0*inv(covDC0)*mDC0' -0.5*diag(log(abs(covDC0)))' log(sp0)]);

            t = tst(ii,:) - ones(size(tst(ii,:), 1), size(mDC1, 1)) * mDC1;
            f1(ii,1) = sum([-0.5*t*diag(inv(covDC1))*t mDC1*inv(covDC1).*t -0.5*mDC1*inv(covDC1)*mDC1' -0.5*diag(log(abs(covDC1)))' log(sp1)]);

            if f0(ii,1)<=f1(ii,1);
                CtstQ(ii,1)=1;
            else
                CtstQ(ii,1)=0;
            end
        end
        
        for jj=1:size(tst,1)
            if CtstQ(jj)==tstY(jj,1)
                CtstQ(jj)=1;
            else
                CtstQ(jj)=0;
            end
        end

        error = 1-(sum(CtstQ))/size(CtstQ,1);

end