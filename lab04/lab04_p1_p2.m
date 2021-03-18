clc; close all; clear all;

%%Problem 1%%
%H(z) = (z^2-1)/(z^2+z+2)
num1 = [1 -1 0];
den1 = [1 3 2];

[r1,p1,k1] = residue(num1,den1);

zero1 = roots(num1);
pole1 = roots(den1);

figure(1);
freqz(num1,den1);
title('Filter: H(z) = (z^2-1)/(z^2+z+2)');


%%Problem 2%%
%y[n] – 1.8cos(pi/16)y[n-1] + 0.81y[n-2] = x[n] + 0.5x[n-1]
num2 = [1 0.5 0];
den2 = [1 -1.8*cos(pi/16) 0.81];

n = -10:100;
x = zeros(111,1);
x(11) = 1;
y = filter(num2,den2,x); %output y(t) is understood as: x(t) -> "system" a,b -> y(t)

figure(2);
stem(n,y); %hold on;
title('y[n] – 1.8cos(pi/16)y[n-1] + 0.81y[n-2] = x[n] + 0.5x[n-1]', 'Impulse response from feeding Dirac to model H(z)');
xlabel('n');ylabel('h(n)');

figure(17);
hn = 7.938*(0.9).^n.*cos(pi/16.*n-1.444).*heaviside(n);
stem(n,hn);% hold off;
title('y[n] – 1.8cos(pi/16)y[n-1] + 0.81y[n-2] = x[n] + 0.5x[n-1]','Impulse response from manually deriving h(n)');
xlabel('n');ylabel('h(n)');


% roots(den2);
% [r2,p2,k2] = residue(num2,den2);


%%Problem 3%%

%%Graph2%%
figure(3);
sys2 = tf(num2,den2);
pzmap(sys2);
title('y[n] – 1.8cos(pi/16)y[n-1] + 0.81y[n-2] = x[n] + 0.5x[n-1]');

figure(4);
freqz(num2,den2);
title('y[n] – 1.8cos(pi/16)y[n-1] + 0.81y[n-2] = x[n] + 0.5x[n-1]');

%%Graph3%%
%y[n] + 0.13y[n-1] + 0.52y[n-2] + 0.3y[n-3] = 0.16x[n] - 0.48x[n-1] + 0.48x[n-2] 0.16x[n-3]
num3 = [0.16 -0.48 0.48 0.16];
den3 = [1 0.13 0.52 0.3];
sys3 = tf(num3,den3);
figure(5);
pzmap(sys3);
title('y[n] + 0.13y[n-1] + 0.52y[n-2] + 0.3y[n-3] = 0.16x[n] - 0.48x[n-1] + 0.48x[n-2] 0.16x[n-3]');
figure(6);
freqz(num3,den3);
title('y[n] + 0.13y[n-1] + 0.52y[n-2] + 0.3y[n-3] = 0.16x[n] - 0.48x[n-1] + 0.48x[n-2] 0.16x[n-3]');

%%Graph4%%
%y[n] - 0.268y[n-2] = 0.634x[n] – 0.634x[n-2]
num4 = [1 0 -0.268];
den4 = [0.634 0 -0.634];
sys4 = tf(num4,den4);
figure(7);
pzmap(sys4);
title('y[n] - 0.268y[n-2] = 0.634x[n] – 0.634x[n-2]');
figure(8);
freqz(num4,den4);
title('y[n] - 0.268y[n-2] = 0.634x[n] – 0.634x[n-2]');

%%Graph5%%
%y[n] + 0.268y[n-2] = 0.634x[n] + 0.634x[n-2]
num5 = [0.634 0 0.634];
den5 = [1 0 0.268];
sys5 = tf(num5,den5);
figure(9);
pzmap(sys5);
title('y[n] + 0.268y[n-2] = 0.634x[n] + 0.634x[n-2]');
figure(10);
freqz(num5,den5);
title('y[n] + 0.268y[n-2] = 0.634x[n] + 0.634x[n-2]');

%%Graph6%%
%10y[n] - 5y[n-1] + 2y[n-2] = x[n] - 5x[n-1] + 10x[n-2]
num6 = [1 -5 10];
den6 = [10 -5 2];
sys6 = tf(num6,den6);
figure(11);
pzmap(sys6);
title('10y[n] - 5y[n-1] + 2y[n-2] = x[n] - 5x[n-1] + 10x[n-2]');
figure(12);
freqz(num6,den6);
title('10y[n] - 5y[n-1] + 2y[n-2] = x[n] - 5x[n-1] + 10x[n-2]');

%%Low-pass filter%%
%H(z) = (z+1)/(z-3/4)

%testing%
% num7 = [1  3 3 1];
% den7 = conv([1 -1/5],[1 -1 9/16]);
num7 = [1 1];
den7 = [1 -3/4];
sys7 = tf(num7,den7);
figure(13);
pzmap(sys7);
title('Simplest Lowpass Filter: H(z) = (z+1)/(z-3/4)');
figure(14);
freqz(num7,den7);
title('Simplest Lowpass Filter', 'H(z) = (z+1)/(z-3/4)');

%%High-pass filter%%
%H(z) = (z-1)/(z+3/4)
num8 = [1 -1];
den8 = [1 3/4];
sys8 = tf(num8,den8);
figure(15);
pzmap(sys8);
title('Simplest Highpass Filter: H(z) = (z-1)/(z+3/4)');
figure(16);
freqz(num8,den8);
title('Simplest Highpass Filter', 'H(z) = (z-1)/(z+3/4)');



