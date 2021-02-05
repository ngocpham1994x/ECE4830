close all
clear all
clc



load("ACsig.mat");

Fs = 25000;           % Sampling frequency           
T = 1/Fs;             % Sampling period       
L = 2500;             % Length of signal in samples index
t = (0:L-1)/Fs;        % Time vector


Y = fft(x);
P2 =(abs(Y/L));
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

Yn = fft(xn);
P2n = (abs(Yn/L));
P1n = P2n(1:L/2+1);
P1n(2:end-1) = 2*P1n(2:end-1);


figure;
f = Fs*(0:(L/2))/L;
plot(f,P1)
hold on
plot(f,P1n)
hold off
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')