fs = 100; % Sampling frequency (samples per second) 
dt = 1/fs; % seconds per sample 
StopTime = 10; % seconds 
t = (0:dt:StopTime)';

sin1=sin(2*pi*5*t);
%plot(t,sin1);

sin2=sin(2*pi*15*t);
%plot(t,sin2);

sin3=sin(2*pi*30*t);
%plot(t,sin3);

signal=sin1+sin2+sin3;
%plot(t,signal);

%filteredsignal= filter(dsp1, signal);
plot(t,filter(Hd, signal));