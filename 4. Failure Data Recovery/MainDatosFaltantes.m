clc;

%AMOUNT OF CLOSEST VERTICES
cv=3;

%INPUT DATA 
x = [3 4 2 2;
    5 4 5 6;
    5 NaN 3 5;
    4.8 5.2 4.3 9;
    10 14 23 89;
    11.2 13.4 NaN 90;
    9.9 12.87 21.73 88.4;
    11.3 12.21 24.2 60.4];

figure
ax=subplot(2,1,1);
plot(x,'-*');
title('Datos Originales');

xi=1:size(x,1);

fprintf('DATOS ORIGINALES:\n');
fprintf('      Xi     X1       X2       X3       X4\n');
fprintf(repmat('-',1,45),'\n');fprintf('\n');

fmt = ' %6.0f   %6.2f   %6.2f   %6.2f   %6.2f \n';
fprintf(fmt, [xi', x(:,1),x(:,2),x(:,3),x(:,4)].' );
fprintf(repmat('-',1,45),'\n');fprintf('\n');fprintf('\n');


%NaN ELEMENTS 
[row, col] = find(isnan(x));
x_nan = [row, col];

x_nan=sortrows(x_nan,1);

pi=1:size(x_nan,1);
fprintf('PUNTOS CON VALORES FALTANTES:\n');
fprintf('     #       ROW       COL\n');
fmt = '%6.0f   %6.0f   %6.0f \n';
fprintf(fmt, [pi', x_nan].' );
fprintf('\n');
%MATRIX WITHOUT ROWS WITH NaN ELEMENTS
x_cleared_rows = x;

for i = 1:size(x_nan,1)
     x_cleared_rows(x_nan(i,1)-i+1, :) = [];    
end

%FOR EACH POINT
for ii = 1:size(x_nan,1)

    % 1. GETTING ROW WITH NaN
    vect_nan_i = x(x_nan(ii,1),:);
    vect_nan_i(find(isnan(vect_nan_i)))=[];

    % 2. DELETE COL WITH NaN FOR I-th POINT
    x_cleared_col = x_cleared_rows;
    x_cleared_col(:,x_nan(ii,2)) = [];

    % 3. CALCULATING DISTANCES 
    dist=[];
    for i = 1:size(x_cleared_col,1)
        dist = [dist norm(x_cleared_col(i,:) - vect_nan_i);];    
    end
    
    fprintf('DISTANSIA PARA PUNTO #');disp(ii);disp(dist);fprintf('\n');
    
    % 4.MINIMUM DIST ELEMENTS
    minIdx = zeros(cv,1);
    dist_=dist;
    for i=1:cv
      [val, idx] = min(dist_);
      minIdx(i)=find(dist==val);
      % remove for the next iteration the last smallest value:
      dist_(idx) = [];
    end

    % 5.CALCULATION OF NaN ELEMENT VALUE
    val_nan=0;
    for i=1:cv
      val_nan=val_nan+x_cleared_rows(minIdx(i),x_nan(ii,2));
    end
    val_nan=val_nan/cv;
    fprintf('NUEVO VALOR PARA PUNTO #');disp(ii);disp(val_nan);fprintf('\n');
        
    x(x_nan(ii,1),x_nan(ii,2))=val_nan;
end

ax=subplot(2,1,2);
plot(x,'-*');
title('Datos sin valores faltantes');
suptitle('Imputación de Datos');

fprintf('DATOS NUEVOS:\n');
fprintf('      Xi     X1       X2       X3       X4\n');
fprintf(repmat('-',1,45),'\n');fprintf('\n');

fmt = ' %6.0f   %6.2f   %6.2f   %6.2f   %6.2f \n';
fprintf(fmt, [xi', x(:,1),x(:,2),x(:,3),x(:,4)].' );
fprintf(repmat('-',1,45),'\n');fprintf('\n');



