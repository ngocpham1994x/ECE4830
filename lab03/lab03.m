clc; close all; clear all;

R = 1000;
C = 0.01e-6;
fs = 40000;
Ts = 1/fs;

%H(z) = 5/(7-(2*z^-1)) = 5z/(7z-2)
%H(z) = Ts / (-RCz^-1 + RC + Ts)
b = Ts;  %nominator
a = [Ts+R*C -R*C]; %denominator

%part 1: construct the "system"/the "filter" H(z)
[h,w]=freqz(b,a,256);
figure(1);
plot(fs*w/(2*pi),abs(h));
title('"System" - Absolute value of H(z)');
xlabel('frequency (Hz)');ylabel('|H(z)|');

%part 2: noisy signal (Matlab generated) goes through the "system" H(z)
x = normrnd(0,1,512,30);  %30 realizations/samples of 512 Gaussian distributed 
y = filter(b,a,x); %output y(t) is understood as:  x(t) -> "system" a,b -> y(t)
y_fft = abs(fft(y)); %two-sided spectrum
y_mean = mean(y_fft,2);
ymean = y_mean(1:256); %single-sided
y_normal = ymean/max(ymean); %"normalize" range 0-1


figure(2);
plot(fs*w/(2*pi),y_normal);
title('noisy Y(z) with 30 samples');
xlabel('frequency');ylabel('|Y(z)|');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x1 = normrnd(0,1,512,200);  %200 samples
y1 = filter(b,a,x1); %output y(t) is understood as:  x(t) -> "system" a,b -> y(t)
y1_fft = abs(fft(y1)); %two-sided spectrum
y1_mean = mean(y1_fft,2);
y1mean = y1_mean(1:256); %single-sided
y1_normal = y1mean/max(y1mean); %"normalize" range 0-1


figure(3);
plot(fs*w/(2*pi),y1_normal);
title('noisy Y(z) with 200 samples');
xlabel('frequency');ylabel('|Y(z)|');


%part 3: chirp signal goes through the "system" H(z)
n = 0:512;
t = n*Ts;
f0 = 0.01; %unit: Hz, any small value that > 0 
IF = 20000; %assume IF = 20kHz

maxtime = 512.*Ts;
% IF = f0*(1+K*2*(512*Ts)); %instantaneous freq
% find K:
K = ((IF/f0)-1)/(2.*maxtime);

chirp = sin(2*pi*f0*(t+K*t.^2));
chirp_filter = filter(b,a,chirp);
chirp_fft = abs(fft(chirp_filter));   %~flat
chirp_single = chirp_fft(1:256);  % single-sided


figure(4);
plot(fs*w/(2*pi),chirp_single);
title('chirp signal');
xlabel('frequency');ylabel('|Chirp(z)|');

%part 4: iddata & arx (can't run due to no Matlab Toolbox in UofM computer)
data = iddata(abs(h),chirp_single,Ts);
sys = arx(data,[1 1 0]);

