close all
clear all
clc

%problem 2a: plot signal in time domain

Fs = 25000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 2500;             % Length of signal in samples index
t = (0:L-1)*T;        % Time vector

X = 150*sin(2*pi*60*t);

figure;
plot(t,X);
axis([0 0.1 -200 200]);
title('Signal with time unit')
xlabel('t (seconds)')
ylabel('X(t)')


%problem 2b: plot signal in frequency domain

figure;
Y = fft(X);
% P2 = 20*log10(abs(Y/L)); %for y-axis to be dB
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1)
axis([0 500 -10 200]);  %for fix the x-axis limit to view 60Hz value, comment this out if y-axis in dB
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
