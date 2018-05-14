clc, clear all;
load('datos_lqc_qdc.mat')
 
figure(1)
for i=1:3
  for j=1:i-1
     subplot(2,2,(i-1)+2*(j-1))
     scatter(trn.x(:,i),trn.x(:,j),7,trn.y(:,1),'filled')
     xlabel(sprintf('x%g',i)); ylabel(sprintf('x%g',j))
  end
end
suptitle('Plots para todos los combinaciones')
subplot(2,2,3); xlabel('x'); ylabel('y'); zlabel('z');
subplot(2,2,3)
scatter3(trn.x(:,1),trn.x(:,2),trn.x(:,3),7,trn.y(:,1),'filled')
zz=5;
datos=trn.x(:,1:zz);

C=trn.y(:,1);

fprintf('\n');fprintf('Datos training');fprintf('\n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
tabulate(C);
fprintf(repmat('-',1,30),'\n');fprintf('\n');

m = mean(datos);

DC0 = (datos(C==0,:));
mDC0 = mean(DC0);
DC0 = DC0 - ones(size(DC0, 1), size(mDC0, 1)) * mDC0;
covDC0=cov(DC0);

DC1=(datos(C==1,:));
mDC1=mean(DC1);
DC1 = DC1 - ones(size(DC1, 1), size(mDC1, 1)) * mDC1;
covDC1=cov(DC1);

s0=size(DC0,1); s1=size(DC1,1); sp0=s0/(s0+s1); sp1=s1/(s0+s1);

Cp=(s0*covDC0+s1*covDC1)/(s0+s1);
Cp=inv(Cp);

d0 =[mDC0*Cp -0.5*mDC0*Cp*mDC0'+log(sp0)];
d1 =[mDC1*Cp -0.5*mDC1*Cp*mDC1'+log(sp1)];
dz=d0-d1;

fprintf(repmat('*',1,70),'\n');fprintf('\n');
fmt = 'Funcion descriminante LDA 1: z1 = %6.3fx %6.3fy %6.3fz %6.3f \n';
fprintf(fmt, d0);
fmt = 'Funcion descriminante LDA 2: z2 = %6.3fx %6.3fy %6.3fz %6.3f \n';
fprintf(fmt, d1);
fmt = 'Hiperplano LDA z1-z2=0     : z  = %6.3fx %6.3fy %6.3fz %6.3f \n';
fprintf(fmt, dz);
fprintf(repmat('*',1,70),'\n');fprintf('\n');

t = tst.x(:,1:zz) - ones(size(tst.x(:,1:zz), 1), size(m, 1)) * m;
Ctst=zeros(size(t,1),1);

f0=zeros(size(t,1),1);
f1=zeros(size(t,1),1);

for i=1:size(tst.x,1)
    f0(i,1) = sum(d0(1,1:zz).*t(i,1:zz));
    f1(i,1) = sum(d1(1,1:zz).*t(i,1:zz));
    if f0(i,1)<=f1(i,1);
        Ctst(i,1)=1;
    else
        Ctst(i,1)=0;
    end
end

syms x y z
figure(2)
subplot(1,3,1)
scatter(f0(:,1),f1(:,1),25,Ctst(:,1),'filled'); hold on
title('Datos nuevos')

subplot(1,3,2)
scatter(tst.x(:,1),tst.x(:,2),25, Ctst(:,1),'filled'); hold on
f(x, y) = dz(1,1)*x+dz(1,2)*y;
ezplot(f,[-1, 1]); hold off
title('Datos test')

subplot(1,3,3)
scatter(trn.x(:,1),trn.x(:,2),25,trn.y(:,1),'filled');hold on
ezplot(f,[-1, 1]);hold off
title('Datos traning')
suptitle('Plots para resultos')

CtstQ=zeros(size(t,1),1);

for i=1:size(tst.x,1)
    t = tst.x(i,1:zz) - ones(size(tst.x(i,1:zz), 1), size(mDC0, 1)) * mDC0;
    f0(i,1) = sum([-0.5*t*diag(inv(covDC0))*t mDC0*inv(covDC0).*t -0.5*mDC0*inv(covDC0)*mDC0' -0.5*diag(log(abs(covDC0)))' log(sp0)]);
    
    t = tst.x(i,1:zz) - ones(size(tst.x(i,1:zz), 1), size(mDC1, 1)) * mDC1;
    f1(i,1) = sum([-0.5*t*diag(inv(covDC1))*t mDC1*inv(covDC1).*t -0.5*mDC1*inv(covDC1)*mDC1' -0.5*diag(log(abs(covDC1)))' log(sp1)]);
    
    if f0(i,1)<=f1(i,1);
        CtstQ(i,1)=1;
    else
        CtstQ(i,1)=0;
    end
end

fprintf('\n');fprintf('Clasificando dattos de test con LDA');fprintf('\n');
fprintf('        x         y        z        d1       d2    Class\n');
fprintf(repmat('-',1,65),'\n');fprintf('\n');
fmt = '      %6.3f   %6.3f   %6.3f   %6.3f   %6.3f    C%1.0f\n';
fprintf(fmt, [tst.x Ctst].' );
fprintf(repmat('-',1,65),'\n');fprintf('\n');

fprintf('\n');fprintf('Clasificando dattos de test con QDA');fprintf('\n');
fprintf('        x         y        z        d1       d2    Class\n');
fprintf(repmat('-',1,65),'\n');fprintf('\n');
fmt = '      %6.3f   %6.3f   %6.3f   %6.3f   %6.3f    C%1.0f\n';
fprintf(fmt, [tst.x CtstQ].' );
fprintf(repmat('-',1,65),'\n');fprintf('\n');

fprintf('\n');fprintf('Datos predictos(LDA)');fprintf('\n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
tabulate(Ctst);
fprintf(repmat('-',1,30),'\n');fprintf('\n');

fprintf('\n');fprintf('Datos predictos(QDA)');fprintf('\n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
tabulate(CtstQ);
fprintf(repmat('-',1,30),'\n');fprintf('\n');

fprintf('\n');fprintf('Datos predictos (Reales)');fprintf('\n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
tabulate(tst.y);
fprintf(repmat('-',1,30),'\n');fprintf('\n');


