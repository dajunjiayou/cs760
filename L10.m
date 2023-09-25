clear all

xsin=[0:pi/200:pi/2];
ysin=sin(xsin);
xx=linspace(0,pi,50);
figure
plot(xsin,ysin);

M=1;

[y,R]=lagran1(xsin,ysin,xx,M);

y1=sin(xx);
errorbar(xx,y,R,'.g')
hold on 
plot(xsin,ysin, 'or',xx,y,'.k',xx,y1,'-b');
legend('error','sample','lagrange','sin(x)')


% vpa(L,5)