close all
clear all
clc

%setup signal, filter first time (eliminate DC offset)

load('scan.mat');
scan_signal1 = mean(scan_signal); 
scan_signal2 = mean(scan_signal) - mean(mean(scan_signal)); %avg 16 scans, eliminate/filter the DC offset by subtraction

figure;
subplot(211);
plot(scan_signal1);
title('average signal from 16 ultrasound scans ');
xlabel('time');
axis([1 800 -3000 5000]);

subplot(212);
plot(scan_signal2);
title('mean signal of 16 scans, no DC offset');
xlabel('time');
axis([1 800 -4000 4000]);


% Finding what type of filter

L = 800;
Y = fft(scan_signal2);
P2 = abs(Y/L);  %two-sided spectrum, able to see 2 peaks of freq
% P1 = P2(1:L/2+1);    %one-sided spectrum
% P1(2:end-1) = 2*P1(2:end-1);

figure;
plot(P2);
title('fft of mean signal in frequency domain');
xlabel('Frequency index');
%Notice the peaks at 138 and 664


% Manually create bandpass filter
figure;
x = zeros(1,800);
x(138) = 1;
x(664) = 1;
y = gausswin(100,0.5);  %width and alpha values of the window amplitude = 1

result = conv(x,y,'same');
filter = 1 - result;  % to have proper bandpass filter shape, pass signal within band (138,664)

plot(filter);
title('Man-made Bandpass filter');
xlabel('Frequency index');


% apply filter on mean signal (no DC, DC already filtered out) 
figure;
subplot(211);
plot(scan_signal2);
title('mean signal of 16 scans, no DC offset (already filtered out)');
xlabel('time');
axis([1 800 -4000 4000]);

subplot(212);
scan_signal_filtered = Y.*filter;
scan_signal_filtered_1 = real(ifft(scan_signal_filtered));
plot(scan_signal_filtered_1);
title('Final filtered signal');
xlabel('time');
axis([1 800 -4000 4000]);

