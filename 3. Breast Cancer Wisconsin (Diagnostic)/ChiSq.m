function ChiSq(datos)
    datosor=datos;
    datos=sort(datos);

    media = mean(datos,1);
    mcov=cov(datos);
    sigma=datos - ones(size(datos, 1), size(media, 1)) * media;

    dii=sigma*inv(mcov)*sigma';
    di=diag(dii);
    di=sort(diag(dii));
    
    vcr=ncx2inv(0.975,size(datos,2)-1,0);
    
    
    x=1:size(datos,1);
    xx=zeros(size(datos,1),size(datos,2));
    for i=1:size(datos,2);
      xx(:,i)=x;
    end

    outl=datos((di>vcr),:);
    xx=xx((di>vcr),:);

    figure; 
    axor = subplot(2,2,1);
    plot(datosor,'b.');grid on;
    title(axor,'Datos originales');

    axor = subplot(2,2,2);
    plot(sigma,'b.');grid on;
    title(axor,'Datos ordenados (X-media)');

    axor = subplot(2,2,[3,4]);
    plot(datos,'g.');grid on;hold on;
    plot(xx,outl,'r.');
    title(axor,'Outliers');
    suptitle('Método de 97.5% Q-Quartil Chi^2');
end