clc, clear all
load('fisheriris.mat')

datos = meas(:,1:4);

for i=1:size(species)
    if strcmp(species(i),'setosa')
        spec(i)=0;
    end;
	if strcmp(species(i),'versicolor')
        spec(i)=1;
    end;
	if strcmp(species(i),'virginica')
        spec(i)=2;
    end;
end

figure(1)
for i=1:4
  for j=1:i-1
     subplot(3,3,(i-1)+3*(j-1))
     scatter(datos(:,i),datos(:,j),7,spec,'filled')
     xlabel(sprintf('x%g',i)); ylabel(sprintf('x%g',j))
  end
end
suptitle('Plots para todos los combinaciones');
n = size(datos,1);

%MEDIAS DE DADOS
mns = mean(datos,1);
fprintf('Mediana \n');
fprintf(repmat('-',1,45),'\n');fprintf('\n');
fmt = '   %6.2f   %6.2f   %6.2f   %6.2f \n';
fprintf(fmt, [mns]);
fprintf(repmat('-',1,45),'\n');fprintf('\n');fprintf('\n');

%DATOS MENOS MEDIA
datos = datos - ones(size(datos, 1), size(mns, 1)) * mns;

%MATRICE DE COVARIANCE
cv = cov(datos);
fprintf('Matrice de covariance \n');
fprintf(repmat('-',1,45),'\n');fprintf('\n');
fmt = '   %6.2f   %6.2f   %6.2f   %6.2f \n';
fprintf(fmt, [cv].' );
fprintf(repmat('-',1,45),'\n');fprintf('\n');fprintf('\n');

[V,L] = eig(cv);
[L order] = sort(diag(L), 'descend');

fprintf('Eigen Values \n');
fprintf(repmat('-',1,45),'\n');fprintf('\n');
fmt = '   %6.3f   %6.3f   %6.3f   %6.3f \n';
fprintf(fmt, [L].' );
fprintf(repmat('-',1,45),'\n');fprintf('\n');fprintf('\n');

V = V(:,order);
fprintf('Eigen Vectores Ordenados\n');
fprintf(repmat('-',1,45),'\n');fprintf('\n');
fmt = '   %6.3f   %6.3f   %6.3f   %6.3f \n';
fprintf(fmt, [V].' );
fprintf(repmat('-',1,45),'\n');fprintf('\n');fprintf('\n');

Xnew = datos*V;

figure(2);
scatter(Xnew(:,1),Xnew(:,2),17,spec,'filled')
xlabel('PC1'); ylabel('PC2')

figure(3);
scatter3(Xnew(:,1),Xnew(:,2),Xnew(:,3),27,spec,'filled')
xlabel('PC1'); ylabel('PC2'); zlabel('PC3')

