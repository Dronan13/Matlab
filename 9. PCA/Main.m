clc, clear all  
datos = [1.716 -0.567 0.991; 
         1.76 -0.48 1.016;
         1.933 -0.134 1.116;
         2.366 0.732 1.366;
         2.582 1.165 1.491;
         3.015 2.031 1.741;
         3.232 2.464 1.866;
         1.616 1.232 0.933;
         1.991 0.982 1.15;
         2.741 0.482 1.582;
         3.116 0.232 1.799];
     
fprintf('Datos Originales\n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fprintf('     X1         X2        X3   \n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fmt = '   %7.4f   %7.4f   %7.4f   \n';
fprintf(fmt, [datos].' );
fprintf(repmat('-',1,35),'\n');fprintf('\n');fprintf('\n'); 

n = size(datos,1);

%MEDIAS DE DADOS
mns = mean(datos,1);
fprintf('Mediana \n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
fmt = '   %6.4f   %6.4f   %6.4f \n';
fprintf(fmt, [mns]);
fprintf(repmat('-',1,30),'\n');fprintf('\n');fprintf('\n');

%DATOS MENOS MEDIA
datos = datos - ones(size(datos, 1), size(mns, 1)) * mns;

%MATRICE DE COVARIANCE
cv = cov(datos);
fprintf('Matrice de covariance \n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
fmt = '   %6.4f   %6.4f   %6.4f \n';
fprintf(fmt, [cv].' );
fprintf(repmat('-',1,30),'\n');fprintf('\n');fprintf('\n');

[V,L] = eig(cv);
[L order] = sort(diag(L), 'descend');

V = V(:,order);
fprintf('Eigen Vectores Ordenados\n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fprintf('     1CP      2CP       3CP   \n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fmt = '   %7.4f   %7.4f   %7.4f   \n';
fprintf(fmt, [V].' );
fprintf(repmat('-',1,35),'\n');fprintf('\n');fprintf('\n');

fprintf('Eigen Values \n');
fprintf(repmat('-',1,30),'\n');fprintf('\n');
fmt = '   %6.4f   %6.4f   %6.4f \n';
fprintf(fmt, [L].' );
fprintf(repmat('-',1,30),'\n');fprintf('\n');fprintf('\n');

fprintf('Ecuacion para el primer compomemte principal \n');
fmt = 'Y1 = %6.4fX1 + %6.4fX2 + %6.4fX3 \n';
fprintf(fmt, [V(:,1)].' );fprintf('\n');

fprintf('Ecuacion para el segundo compomemte principal \n');
fmt = 'Y2 = %6.4fX1 + %6.4fX2 + %6.4fX3 \n';
fprintf(fmt, [V(:,2)].' );fprintf('\n');

fprintf('Ecuacion para el tercer compomemte principal \n');
fmt = 'Y3 = %6.4fX1 + %6.4fX2 + %6.4fX3 \n';
fprintf(fmt, [V(:,3)].' );fprintf('\n');

Xnew = datos*V;

fprintf('Datos proyectados\n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fprintf('     X1CP      X2CP      X3CP   \n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fmt = '   %7.4f   %7.4f   %7.4f   \n';
fprintf(fmt, [Xnew].' );
fprintf(repmat('-',1,35),'\n');fprintf('\n');fprintf('\n'); 


fmt = 'Produvto de punto X1*X2 = %7.4f\n';
fprintf(fmt, [datos(1,:)*datos(2,:)'] );
fmt = 'Produvto de punto X1*X3 = %7.4f\n';
fprintf(fmt, [datos(1,:)*datos(3,:)'] );
fmt = 'Produvto de punto X2*X3 = %7.4f\n';
fprintf(fmt, [datos(2,:)*datos(3,:)'] );

fprintf('\n');fprintf('\n');

fmt = 'Produvto de punto PC1*PC2 = %7.4f\n';
fprintf(fmt, [V(1,:)*V(2,:)'].' );
fmt = 'Produvto de punto PC1*PC3 = %7.4f\n';
fprintf(fmt, [V(1,:)*V(3,:)'].' );
fmt = 'Produvto de punto PC2*PC3 = %7.4f\n';
fprintf(fmt, [V(2,:)*V(3,:)'].' );

figure(2);
scatter3(datos(:,1),datos(:,2),datos(:,3),27,'filled')
xlabel('X1'); ylabel('X2'); zlabel('X3')
suptitle('Datos Originales');

figure(3);
scatter3(Xnew(:,1),Xnew(:,2),Xnew(:,3),27,'filled')
xlabel('PC1'); ylabel('PC2'); zlabel('PC3');
suptitle('Datos PCA');
