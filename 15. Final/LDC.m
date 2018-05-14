function [error] = LDC(trn,trnY,tst,tstY)
    zz=size(trn,2);
            datos=trn(:,1:zz);

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

            s0=size(DC0,1); s1=size(DC1,1); sp0=s0/(s0+s1); sp1=s1/(s0+s1);

            Cp=(s0*covDC0+s1*covDC1)/(s0+s1);
            Cp=inv(Cp);

            d0 =[mDC0*Cp -0.5*mDC0*Cp*mDC0'+log(sp0)];
            d1 =[mDC1*Cp -0.5*mDC1*Cp*mDC1'+log(sp1)];
            dz=d0-d1;    

            t = tst(:,1:zz) - ones(size(tst(:,1:zz), 1), size(m, 1)) * m;
            Ctst=zeros(size(t,1),1);

            f0=zeros(size(t,1),1);
            f1=zeros(size(t,1),1);

            for ii=1:size(tst,1)
                f0(ii,1) = sum(d0(1,1:zz).*t(ii,1:zz));
                f1(ii,1) = sum(d1(1,1:zz).*t(ii,1:zz));
                if f0(ii,1)<=f1(ii,1);
                    Ctst(ii,1)=1;
                else
                    Ctst(ii,1)=0;
                end
            end
            error=1-(sum(Ctst))/size(Ctst,1);
end