function EqualFrequency(datos,F)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fprintf('Método 2: Equal-frequency \n');
fprintf('---------------------------------- \n');
fprintf('Orden = %d;\n', F);
datos = sort(datos);
N=floor(size(datos,1)/F)+1;
datos_desc = zeros(size(datos,1),1);
for i = 1:1:F-1;
    for j = 1+(i-1)*N:1:i*N
            datos_desc(j) = i;
    end;
end;
    for j = ((F-1)*N+1):1:(size(datos,1))
            datos_desc(j) = F;
    end;

figure;
xbins2 = 1:1:F;
[counts,centers] = hist(datos_desc,xbins2);
bar(centers,counts);
for i = 1:1:F
    barstrings = num2str(counts(i));
    text(centers(i),counts(i),barstrings,'horizontalalignment','center','verticalalignment','bottom');
end
title('Método 2: Equal-frequency');
xlabel('1 < x < F');
ylabel('Candidat de datos');
legend('Datos wdbc');

end

