function EqualWidth(datos,N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mx=max(datos);
mn=min(datos);
fprintf('Método 1: Equal-width \n');
fprintf('---------------------------------- \n');
fprintf('Orden = %d;\n', N);
fprintf('min = %f;\n', mn);
fprintf('max = %f;\n', mx);

b=(mx-mn)/N;%trashold size
fprintf('Trashold size = %f;\n', b);
datos_desc = zeros(size(datos,1),1);
for i = 1:1:N
    edge_l=mn+(i-1)*b;
    edge_r=mn+i*b;
    for j = 1:1:size(datos,1)
        if((datos(j)>=edge_l)&(datos(j)<=edge_r))
            datos_desc(j) = i;
        end;
    end;
end
figure;
xbins2 = 1:1:N;
[counts,centers] = hist(datos_desc,xbins2);
bar(centers,counts);
for i = 1:1:N
    barstrings = num2str(counts(i));
    text(centers(i),counts(i),barstrings,'horizontalalignment','center','verticalalignment','bottom');
end
title('Método 1: Equal-width');
xlabel('1 < x < N');
ylabel('Candidat de datos');
legend('Datos wdbc');

end

