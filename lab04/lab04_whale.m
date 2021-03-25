%%Boat whale%%
clc; close all; clear all;

load('BoatWhale.mat');
% soundsc(y6,Fs);

y6_fft = abs(fftshift(fft(y6)));

N1 = length(y6);
x1 = -1/2 : 1/N1 : (1/2-1/N1); % "normalize" x-axis of y6_fft
figure(17);
plot(x1,y6_fft);
% plot(y6_fft);
title('Original Boat & Whale signal');

peaksInRadians = [0.0721513 0.108229 0.144578 0.179695 0.213037 0.00879647 0.0110625 0.0357209 0.105947 0.142255];
peaksInRadians = sort([-peaksInRadians peaksInRadians]);
whaleZeros = exp(1i*2*pi*peaksInRadians);
whaleNum = poly(whaleZeros); % determine coefficients for filter

r = 0.99; % for putting poles very close to zeros
whalePoles = r*exp(1i*2*pi*peaksInRadians);
whaleDen = poly(whalePoles); % determine coefficients for filter

sys = tf(whaleNum,whaleDen);
figure(18);
pzmap(sys);
figure;
freqz(whaleNum,whaleDen);
title('Filter');

y6_after = filter(whaleNum,whaleDen,y6);
y6_after_fft = abs(fftshift(fft(y6_after)));

N2 = length(y6_after);
x2 = -1/2 : 1/N2 : (1/2-1/N2); % "normalize" x-axis of y6_after_fft, though y6 & y6_after are same size
figure(19);
plot(x2,y6_after_fft);
title('Filtered Boat & Whale signal, noise sound is filtered');


% soundsc(y6_after,Fs);
