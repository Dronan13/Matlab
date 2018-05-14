clear all;
Fs=1000;%samoling fr.
Ts=1/Fs;%stap of sampling
t=0:Ts:1-Ts;%time 
f=t*0;
noise=randn(size(f));%noise

y=f;
tx = 0:Ts:1/10;%time of signal
fsp = 3*sin(40*pi*tx);%signal sample

for j = 700:799
    y(j) =y(j)+0.4*fsp(j-699);
end

for j = 400:499
    y(j) =y(j)+0.8*fsp(j-399);
end
for j = 100:199
    y(j) =y(j)+fsp(j-99);
end

f=y;
y=y+noise/3;
figure;
ax1 = subplot(4,1,1);
ax2 = subplot(4,1,2);
ax3 = subplot(4,1,3);
ax4 = subplot(4,1,4);
%axis([ax1 ax2 ax3 ax4],[0 1000 0 1]);

subplot(4,1,1);
plot(t*1000,f);
subplot(4,1,2);
plot(t*1000,y);

RxxS=0; 
for jj = 1:100
        RxxS=RxxS+fsp(jj)*fsp(jj);    
end
jv(1)=0;
p(1)=0;
for j = 1:5:1000-100
	RxyS=0;
    RyyS=0;
   
    for jj = 1:100
        RxyS=RxyS+y(j-1+jj)*fsp(jj);        
        RyyS=RyyS+y(j-1+jj)*y(j-1+jj);      
    end
    
    x = 0+j:1:100+j;
    subplot(4,1,2);

    plot(t*1000,y,'-b',x,fsp,'-r','LineWidth',2);
    
    subplot(4,1,4)   
    plot(0,0,'-k',j:j+100,fsp.*y(j:j+100),'-b',1000,0,'-k');
    
    jv(end+1)=j;
    p(end+1)=RxyS/(sqrt(RxxS*RyyS)); 
    subplot(4,1,3); 
    
    
    %plot(j, p,'b');
    
    pause(0.001);
    %disp(length(jv));
    %disp(length(p));
    plot(0,0,'-k',jv, p,'-b',1000,0,'-k');

end
subplot(4,1,4); 
plot(0,0,'-k',100:100+100,fsp.*y(100:100+100),'-b',1000,0,'-k');
hold on
plot(0,0,'-k',400:400+100,fsp.*y(400:400+100),'-b',1000,0,'-k');
plot(0,0,'-k',700:700+100,fsp.*y(700:700+100),'-b',1000,0,'-k');


