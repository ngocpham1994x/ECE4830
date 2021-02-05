clear all 
close all 
sig = zeros(181,1); 
i = 0:50; 
sig(1:51)=i; %first 50 signals
sig(52:100) = 50; %next 49 signals
sig(101:125) = 100; %next 25 signals
sig(126:130) = 0; %next 5 signals
for i = 1:50; %next 50 signals
    sig(130+i) = 50+5*randn(1); %is from 130 to 180, random num + 50 offset (total 100 offset for this segment)
end
n = 0:50; 
s1 = 50+5*sin(2*pi*0.1*n); 
s2 = 50+5*sin(2*pi*0.2*n); 
sig = [sig' s1 s2]; 
sig = sig+50; %offset entire signal
sig(55:57) = 150; 
sig(59:62)=125; 
xx=1:283; 
sign = sig+normrnd(0,5,size(sig)); % add noise 
plot(xx,uint8(sign),'--',xx,uint8(sig),'LineWidth',2), 
axis([0 283 30 170]) 
legend('noisy','original')