clc, clear all;
load('datos_clustering.mat');

ax=subplot(2,2,1);
plot(datos(:,1),datos(:,2),'.');
title('Datos originales');

c_size=3;

a = min(datos(:,1));
b = max(datos(:,1));
c(:,1) = (b-a).*rand(c_size,1) + a;
a = min(datos(:,2));
b = max(datos(:,2));
c(:,2) = (b-a).*rand(c_size,1) + a;

fprintf('Centroides originales\n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fprintf('     C1         C2        C3   \n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fmt = 'X   %7.4f   %7.4f   %7.4f   \n';
fprintf(fmt, [c(:,1)].' );
fmt = 'Y   %7.4f   %7.4f   %7.4f   \n';
fprintf(fmt, [c(:,2)].' );
fprintf(repmat('-',1,35),'\n');fprintf('\n');fprintf('\n'); 

class=zeros(size(datos,1),1);
counter=0;
while 1
    counter=counter+1;
    for i = 1:size(datos,1)
        m=zeros(1,c_size);
        for j = 1:c_size
            m(j)=sqrt((c(j,1)-datos(i,1))^2+(c(j,2)-datos(i,2))^2);
        end
        [M,I] = min(m);
        class(i)=I;
    end
    if counter==1
        ax=subplot(2,2,2);
        scatter(datos(:,1),datos(:,2),7,class,'filled')
        hold on;
        plot(c(:,1),c(:,2),'rX','linewidth',4);
        hold off;
        title('Iteraion #1');
    end
    if counter==2
        ax=subplot(2,2,3);
        scatter(datos(:,1),datos(:,2),7,class,'filled')
        hold on;
        plot(c(:,1),c(:,2),'rX','linewidth',4);
        hold off;
        title('Iteraion #2');
    end
    c_new=zeros(c_size,2);
    for j = 1:c_size
        z=(datos(class==j,:));
    	c_new(j,1)=mean(z(:,1));
        c_new(j,2)=mean(z(:,2));
    end
    if c == c_new
        break;
    end
    c=c_new;
end

fprintf('Centroides ultimos\n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fprintf('     C1         C2        C3   \n');
fprintf(repmat('-',1,35),'\n');fprintf('\n');
fmt = 'X   %7.4f   %7.4f   %7.4f   \n';
fprintf(fmt, [c(:,1)].' );
fmt = 'Y   %7.4f   %7.4f   %7.4f   \n';
fprintf(fmt, [c(:,2)].' );
fprintf(repmat('-',1,35),'\n');fprintf('\n');fprintf('\n'); 

ax=subplot(2,2,4);
scatter(datos(:,1),datos(:,2),7,class,'filled')
hold on;
plot(c(:,1),c(:,2),'rX','linewidth',4);
hold off;
title(strcat('Iteraion #',num2str(counter)));

