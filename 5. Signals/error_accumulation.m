T=2*pi;
p=100;
x=0:T/p:T;

f=4*sin(x);
fn=4*sin(x);
fa=4*sin(x);
favg=4*sin(x);
N=100;
noise=1;
figure

for jj = 1:p
    favg(jj)=0;
    fa(jj)=0;
end   

for j = 1:N
	for jj = 1:p
        fn(jj) =randn(1, 1)/noise+f(jj);
        fa(jj)=fa(jj)+fn(jj);
        favg(jj)=fa(jj)/j;
    end
    subplot(2,1,1)
    hold on
    plot(x,fn,'.b');
    pause(0.0001);
    subplot(2,1,2)
    plot(x,f,'r');
    
    plot(x,favg,'b');
end