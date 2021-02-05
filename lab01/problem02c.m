close all
clear all
clc


load("ACsig.mat");


%plot signal in dB domain for observation

Fs = 25000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 2500;             % Length of signal in samples index


Y = fft(x);
P2 = 20*log10(abs(Y/L));  %y-axis in dB
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


Yn = fft(xn);
P2n = 20*log10(abs(Yn/L));  %y-axis in dB
P1n = P2n(1:L/2+1);
P1n(2:end-1) = 2*P1n(2:end-1);


figure;
f = Fs*(0:(L/2))/L;
plot(f,P1,f,P1n);
title('Single-Sided Amplitude Spectrum in dB');
xlabel('f (Hz)');
ylabel('|P1(f)| & |P1n(f)|');
legend('Power tool OFF','Power tool ON');


%plot signal in frequency y-axis Hz value for finding dominant real freq

Y_freq = fft(x);
P2_freq = abs(Y_freq/L);  
P1_freq = P2_freq(1:L/2+1);
P1_freq(2:end-1) = 2*P1_freq(2:end-1);


figure;
plot(f,P1_freq);
title('Single-Sided Amplitude Spectrum in real frequency');
xlabel('f (Hz)');
ylabel('|P1(f)|');
legend('Power tool OFF');


% filtered signals

P1f = lowpass(P1,60,25000);
P1nf = lowpass(P1n,60,25000);


figure;
plot(f,P1f,f,P1nf);
title('Filtered Single-Sided Amplitude Spectrum');
xlabel('f (Hz)');
ylabel('Filtered |P1(f)| & |P1n(f)|');
legend('Power tool OFF','Power tool ON');