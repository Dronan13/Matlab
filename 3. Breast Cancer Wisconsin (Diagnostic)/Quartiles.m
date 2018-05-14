function Quartiles(datos,k)
    datosor = datos;
    datos = sort(datos);

    Q1=quantile(datos,0.25);
    Q3=quantile(datos,0.75);
    IQR=Q3-Q1;

    
    LIF=Q1-k*IQR;
    UIF=Q3+k*IQR;

    moreThanThreshold = datos > UIF;
    lessThanThreshold = datos < LIF; 
    inThreshold = (datos > LIF) & (datos < UIF);

    outUIF=datos(moreThanThreshold);
    outLIF=datos(lessThanThreshold);
    
    d=datos(inThreshold);
    
    x = 1 : length(datos);
    xUIF = x(moreThanThreshold);
    xLIF = x(lessThanThreshold);
    
    figure; 
    axor = subplot(2,2,1);
    plot(datosor,'b.');
    title(axor,'Datos originales');

    axor = subplot(2,2,2);
    plot(datos,'b.');
    title(axor,'Datos ordenados');

    axor = subplot(2,2,3);
    plot(datos,0,'g.');
    hold on;
    
    if(length(outUIF')>0)
        plot(outUIF',0,'r.');
    end;
        if(length(outLIF')>0)
        plot(outLIF',0,'r.');
    end;
    
    y=get(gca,'ylim');
    line([LIF;LIF],y.');
    line([UIF;UIF],y.');
    title(axor,'Outliers');


    axor = subplot(2,2,4);
    plot(x, datos, 'g.');
    hold on;
    plot(xUIF, outUIF, 'r.');
    plot(xLIF, outLIF, 'r.');
    title(axor,'Outliers');
    line([0,length(datos)],[UIF,UIF]);
    line([0,length(datos)],[LIF,LIF]);
    y=get(gca,'ylim');
    k = find(datos==d(1));
    k=k(1);
    k2 = find(datos==d(length(d)));
    k2=k2(1);
    line([k2;k2],y.');
    line([k;k],y.');    
    
	suptitle('Método de Quartiles');
end
