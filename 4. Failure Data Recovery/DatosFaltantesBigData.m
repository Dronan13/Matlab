load('datos_wdbc.mat');
clc;

%AMOUNT OF CLOSEST VERTICES
cv=10;

%INPUT DATA 
x = trn.xc;

x(10,10)
x(10,10)=NaN;
x(20,11)
x(20,11)=NaN;
x(33,15)
x(33,15)=NaN;
x(56,30)
x(56,30)=NaN;
x(124,17)
x(124,17)=NaN;


xi=1:size(x,1);

%NaN ELEMENTS 
[row, col] = find(isnan(x));
x_nan = [row, col];
pi=1:size(x_nan,1);
x_nan=sortrows(x_nan,1);
fprintf('PUNTOS CON RUIDO:\n');
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
end


