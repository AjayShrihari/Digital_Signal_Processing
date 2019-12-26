%n=20;
prompt1=('Enter n=');
n=input(prompt1);
prompt2=('Enter fp=');
fp=input(prompt2);
prompt3=('Enter fs=');
fs=input(prompt3);
%prompt4=('Enter f=');
%f=input(prompt4);

wp=2*(fp/f);
ws=2*(fs/f);
%wn=[wp,ws];
window1=boxcar(n+1); %rectangular
window2=bartlett(n+1);%triangular
window3=hamming(n+1);
window4=hanning(n+1);
window=kaiser(n+1);
wn=2*(fp/f);
b=fir1(n,wn,'high',window);
[H,w]= freqz(b,1);

figure(1);
subplot(2,1,1);
plot(w/pi,20*log(abs(H)));
xlabel('normalized frequency');
ylabel('magnitude (in dB)')
title('magnitude response');
subplot(2,1,2);
plot(w/pi,angle(H));
xlabel('normalized frequency');
ylabel('angle');
title('phase response');

b1=fir1(n,wn,'high',window1);
[H1,w]= freqz(b1,1);
figure(2);
subplot(2,1,1);
plot(w/pi,20*log(abs(H1)));
xlabel('normalized frequency');
ylabel('magnitude (in dB)')
title('magnitude response');
subplot(2,1,2);
plot(w/pi,angle(H1));
xlabel('normalized frequency');
ylabel('angle');
title('phase response');

b2=fir1(n,wn,'high',window2);
[H2,w]= freqz(b2,1);
figure(3);
subplot(2,1,1);
plot(w/pi,20*log(abs(H2)));
xlabel('normalized frequency');
ylabel('magnitude (in dB)')
title('magnitude response');
subplot(2,1,2);
plot(w/pi,angle(H2));
xlabel('normalized frequency');
ylabel('angle');
title('phase response');

b2=fir1(n,wn,'high',window2);
[H2,w]= freqz(b2,1);
figure(4);
subplot(2,1,1);
plot(w/pi,20*log(abs(H2)));
xlabel('normalized frequency');
ylabel('magnitude (in dB)')
title('magnitude response');
subplot(2,1,2);
plot(w/pi,angle(H2));
xlabel('normalized frequency');
ylabel('angle');
title('phase response');

b3=fir1(n,wn,'high',window3);
[H3,w]= freqz(b3,1);
figure(5);
subplot(2,1,1);
plot(w/pi,20*log(abs(H3)));
xlabel('normalized frequency');
ylabel('magnitude (in dB)')
title('magnitude response');
subplot(2,1,2);
plot(w/pi,angle(H3));
xlabel('normalized frequency');
ylabel('angle');
title('phase response');

b4=fir1(n,wn,'high',window4);
[H4,w]= freqz(b4,1);
figure(6);
subplot(2,1,1);
plot(w/pi,20*log(abs(H3)));
xlabel('normalized frequency');
ylabel('magnitude (in dB)')
title('magnitude response');
subplot(2,1,2);
plot(w/pi,angle(H4));
xlabel('normalized frequency');
ylabel('angle');
title('phase response');

b5=fir1(n,wn,'high',window5);
[H5,w]= freqz(b5,1);
figure(7);
subplot(2,1,1);
plot(w/pi,20*log(abs(H5)));
xlabel('normalized frequency');
ylabel('magnitude (in dB)')
title('magnitude response');
subplot(2,1,2);
plot(w/pi,angle(H5));
xlabel('normalized frequency');
ylabel('angle');
title('phase response');