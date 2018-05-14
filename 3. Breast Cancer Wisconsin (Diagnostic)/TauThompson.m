function TauThompson(datos)

datosor=datos;
datos = sort(datos);

n=length(datos);
outl=0;
alpha=0.05;
d=datos;

    while (length(outl)~=0)        
        media = mean(d);
        sigma=d - ones(size(d, 1), size(media, 1)) * media;
        sigma=abs(sigma);
        S = std(d);
        l=length(d);
        t = tinv(1-(alpha/2),l-2);
        tau =  (t*(l-1))/ (sqrt(l)*sqrt(l-2+(t^2)));
       
        tS = tau*S;
        
        outl=d(sigma>tS);        
        if (length(outl)==0)
        	break;
        end
            
        maxSigma=max(sigma(sigma>tS));
        I=find(sigma==maxSigma);
        d(I)=[];  
        
       
%         %Uncoment to see iterations   
%        figure;
%        hold on;
%         plot(datos,0,'r.');  
%         plot(d,0,'b.');    
%         y=get(gca,'ylim');  
%         k = find(datos==d(1));
%         k=k(1);
%         line([d(length(d));d(length(d))],y.');
%         line([datos(k);datos(k)],y.');
%         title('DATOS');
%         axis([-max(datos)/2 max(datos) -1 1]);
%         pause(0.2);
%         close(intersect(findall(0,'type','figure'),1))
    end
    
    k = find(datos==d(1));
    k=k(1);
    k2 = find(datos==d(length(d)));
    k2=k2(1);
    
    figure; 
    axor = subplot(2,2,1);
    plot(datosor,'b.')
    title(axor,'Datos originales');

    axor = subplot(2,2,2);
    plot(datos,'b.')
    title(axor,'Datos ordenados');

    axor = subplot(2,2,3);
    plot(datos,0,'r.')
    hold on;
    plot(d,0,'g.');
    
    y=get(gca,'ylim');        
    line([d(length(d));d(length(d))],y.');
    line([datos(k);datos(k)],y.');
    
    title(axor,'Outliers');

    axor = subplot(2,2,4);
    plot(datos,'r.')
    hold on;
    x=1:length(d);
    plot(x+k-1,d,'g.'); 
    y=get(gca,'ylim'); 
    line([k2;k2],y.');
    line([k;k],y.');    
	line([0,n],[datos(k2),datos(k2)]);
	line([0,n],[datos(k),datos(k)]);
    
    title(axor,'Outliers');  
	suptitle('Método de Tau-Thompson modificado');
end 
        