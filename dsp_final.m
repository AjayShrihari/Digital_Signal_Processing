clear;

%take inputs to make interactive
prompt4=('1.Lowpass\n2.Highpass\n3.Bandpass\n');
filt=input(prompt4);

prompt1=('Enter odd value of n=');
N=input(prompt1);

prompt5=('Enter Sidelobe attenuation=');
alpha=input(prompt5);

prompt3=('Enter fs=');
fs=input(prompt3);

prompt2=('Enter fp=');
fp=input(prompt2);



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
figure(1);
subplot(2, 1, 1);
plot(signal);
xlabel('Time');
ylabel('Magnitude');
title('Input signal');

subplot(2, 1, 2);
plot(20*log10(abs(fftshift(fft(signal, 1000)))));
xlabel('Frequency');
ylabel('Magnitude');
title('FFT of input');


% Filter order
L=N;


%findng dynamic kaiser window parameter beta
if alpha > 50
    beta=0.1102*(alpha-8.7);
elseif alpha < 21
    beta=0;
else
    beta=0.5842*power((alpha-21),0.4)+0.07866*(alpha-21);
end

wp=(2*pi*fp)/fs;

if filt==1
    %lowpass
    
    n=1:N;
   
    %creating a lowpass filter for given input conditions
    for n = 1:N
        hk(n)=sin(wp*(n-(N-1)/2))/(pi*(n-(N-1)/2));
    end
    
    hk((N - 1) / 2) = wp / pi;
    
    figure(2);
    
    plot(20*log10(abs(fftshift(fft(hk)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR filter');
    
    %create kaiser window using bessel function of first kind
    wn5=besseli(0,beta*sqrt(1-(((0:L-1)-(L-1)/2)/((L-1)/2)).^2))/besseli(0,beta);
    
    for n = 1:L
        %rectangular
        wn0(n)=1;
       %wn1=1-(abs(n)/(L-1));
       %hanning
       wn2(n)=0.5-0.5*cos((2*pi*n)/(L));
       %hamming
       wn3(n)=0.54-0.46*(cos(2*pi*n)/(L));
       %blackmann
       wn4(n)=0.42-0.5*(cos(2*pi*n)/(L))+0.08*(cos(4*pi*n)/(L));
    end

    
    %plotting frequency response 
    figure(3);
    h5= hk.*wn5;
    subplot(3,2,1);
    plot(20*log10(abs(fftshift(fft(h5,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Kaiser Window');

    h2= hk.*wn2;
    subplot(3,2,2);
    plot(20*log10(abs(fftshift(fft(h2,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Hanning Window');
    
    
    h3= hk.*wn3;
    subplot(3,2,3);
    plot(20*log10(abs(fftshift(fft(h3,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Hamming Window');
    
    h4= hk.*wn4;
    subplot(3,2,4);
    plot(20*log10(abs(fftshift(fft(h4,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Blackmann Window');
       
    h0= hk.*wn0;
    subplot(3,2,5);
    plot(20*log10(abs(fftshift(fft(h0,1000)))));
    xlabel('Frequency');
    ylabel('Phase response(dB)');
    title('FIR-Rectangular Window');

    %plotting angle response in different figure
    figure(4);
    subplot(3,2,1);
    plot(angle(fftshift(fft(h5,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Kaiser Window');
    
    subplot(3,2,2);
    plot(angle(fftshift(fft(h2,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Hanning Window');
    
    subplot(3,2,3);
    plot(angle(fftshift(fft(h3,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Hamming Window');
    
    subplot(3,2,4);
    plot(angle(fftshift(fft(h4,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Blackmann Window');
    
    subplot(3,2,5);
    plot(angle(fftshift(fft(h0,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Rectangular Window');
    
    %plotting fft of output signal
    figure(5);
    o5 = conv(h5, signal);
    subplot(3,2,1);
    plot(20*log10(abs(fftshift(fft(o5,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Kaiser Window');

    o2 = conv(h2, signal);
    subplot(3,2,2);
    plot(20*log10(abs(fftshift(fft(o2,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Hanning Window');

    o3 = conv(h3, signal);
    subplot(3,2,3);
    plot(20*log10(abs(fftshift(fft(o3,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Hamming Window');
   
    o4 = conv(h4, signal);
    subplot(3,2,4);
    plot(20*log10(abs(fftshift(fft(o4,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Blackmann Window');
    
    o0 = conv(h0, signal);
    subplot(3,2,5);
    plot(20*log10(abs(fftshift(fft(o0,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Rectangular Window');
    
  
elseif filt==2
    %highpass
        
    n=1:N;
   
    %creating a highpass filter for given input conditions
    for n = 1:N
        hk(n)=(sin(pi*(n-(N-1)/2)) - sin(wp*(n-(N-1)/2)))/(pi*(n-(N-1)/2));
    end
    
    hk((N - 1) / 2) = (pi - wp) / pi;
    
    figure(2);
    
    plot(20*log10(abs(fftshift(fft(hk)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR filter');
    
    %create kaiser window using bessel function of first kind
    wn5=besseli(0,beta*sqrt(1-(((0:L-1)-(L-1)/2)/((L-1)/2)).^2))/besseli(0,beta);
    h5= hk.*wn5;
    figure(3);
    subplot(3,2,1);
    plot(20*log10(abs(fftshift(fft(h5,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Kaiser Window');
    
    for n = 1:L
        %rectangular
        wn0(n)=1;
       %wn1=1-(abs(n)/(L-1));
       %hanning
       wn2(n)=0.5-0.5*cos((2*pi*n)/(L));
       %hamming
       wn3(n)=0.54-0.46*(cos(2*pi*n)/(L));
       %blackmann
       wn4(n)=0.42-0.5*(cos(2*pi*n)/(L))+0.08*(cos(4*pi*n)/(L));
    end

    
    %plotting frequency response 
    h2= hk.*wn2;
    subplot(3,2,2);
    plot(20*log10(abs(fftshift(fft(h2,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Hanning Window');
    
    
    h3= hk.*wn3;
    subplot(3,2,3);
    plot(20*log10(abs(fftshift(fft(h3,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Hamming Window');
    
    h4= hk.*wn4;
    subplot(3,2,4);
    plot(20*log10(abs(fftshift(fft(h4,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Blackmann Window');
       
    h0= hk.*wn0;
    subplot(3,2,5);
    plot(20*log10(abs(fftshift(fft(h0,1000)))));
    xlabel('Frequency');
    ylabel('Phase response(dB)');
    title('FIR-Rectangular Window');

    %plotting angle response in different figure
    figure(4);
    subplot(3,2,1);
    plot(angle(fftshift(fft(h5,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Kaiser Window');
    
    subplot(3,2,2);
    plot(angle(fftshift(fft(h2,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Hanning Window');
    
    subplot(3,2,3);
    plot(angle(fftshift(fft(h3,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Hamming Window');
    
    subplot(3,2,4);
    plot(angle(fftshift(fft(h4,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Blackmann Window');
    
    subplot(3,2,5);
    plot(angle(fftshift(fft(h0,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Rectangular Window');

    %plotting fft of output signal
    figure(5);
    o5 = conv(h5, signal);
    subplot(3,2,1);
    plot(20*log10(abs(fftshift(fft(o5,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Kaiser Window');

    o2 = conv(h2, signal);
    subplot(3,2,2);
    plot(20*log10(abs(fftshift(fft(o2,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Hanning Window');

    o3 = conv(h3, signal);
    subplot(3,2,3);
    plot(20*log10(abs(fftshift(fft(o3,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Hamming Window');
   
    o4 = conv(h4, signal);
    subplot(3,2,4);
    plot(20*log10(abs(fftshift(fft(o4,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Blackmann Window');
    
    o0 = conv(h0, signal);
    subplot(3,2,5);
    plot(20*log10(abs(fftshift(fft(o0,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Rectangular Window');
    
elseif filt==3
    %bandpass
        
    n=1:N;
    
    prompt7=('Enter fp1=');
    fp1=input(prompt7);
    
    wp1=(2*pi*fp1)/fs;
   
    
    %creating a bandpass filter for given input conditions
    for n = 1:N
        hk(n)=(sin(wp1*(n-(N-1)/2)) - sin(wp*(n-(N-1)/2)))/(pi*(n-(N-1)/2));
    end
    
    hk((N - 1) / 2) = (wp1 - wp) / pi;
    
    figure(2);
    
    plot(20*log10(abs(fftshift(fft(hk)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR filter');
    
    %create kaiser window using bessel function of first kind
    wn5=besseli(0,beta*sqrt(1-(((0:L-1)-(L-1)/2)/((L-1)/2)).^2))/besseli(0,beta);
    h5= hk.*wn5;
    figure(3);
    subplot(3,2,1);
    plot(20*log10(abs(fftshift(fft(h5,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Kaiser Window');
    
    for n = 1:L
        %rectangular
        wn0(n)=1;
       %wn1=1-(abs(n)/(L-1));
       %hanning
       wn2(n)=0.5-0.5*cos((2*pi*n)/(L));
       %hamming
       wn3(n)=0.54-0.46*(cos(2*pi*n)/(L));
       %blackmann
       wn4(n)=0.42-0.5*(cos(2*pi*n)/(L))+0.08*(cos(4*pi*n)/(L));
    end

    
    %plotting frequency response 
    h2= hk.*wn2;
    subplot(3,2,2);
    plot(20*log10(abs(fftshift(fft(h2,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Hanning Window');
    
    
    h3= hk.*wn3;
    subplot(3,2,3);
    plot(20*log10(abs(fftshift(fft(h3,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Hamming Window');
    
    h4= hk.*wn4;
    subplot(3,2,4);
    plot(20*log10(abs(fftshift(fft(h4,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('FIR-Blackmann Window');
       
    h0= hk.*wn0;
    subplot(3,2,5);
    plot(20*log10(abs(fftshift(fft(h0,1000)))));
    xlabel('Frequency');
    ylabel('Phase response(dB)');
    title('FIR-Rectangular Window');

    %plotting angle response in different figure
    figure(4);
    subplot(3,2,1);
    plot(angle(fftshift(fft(h5,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Kaiser Window');
    
    subplot(3,2,2);
    plot(angle(fftshift(fft(h2,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Hanning Window');
    
    subplot(3,2,3);
    plot(angle(fftshift(fft(h3,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Hamming Window');
    
    subplot(3,2,4);
    plot(angle(fftshift(fft(h4,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Blackmann Window');
    
    subplot(3,2,5);
    plot(angle(fftshift(fft(h0,1000))));
    xlabel('Frequency');
    ylabel('Angle response');
    title('FIR-Rectangular Window');
    
    %plotting fft of output signal
    figure(5);
    o5 = conv(h5, signal);
    subplot(3,2,1);
    plot(20*log10(abs(fftshift(fft(o5,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Kaiser Window');

    o2 = conv(h2, signal);
    subplot(3,2,2);
    plot(20*log10(abs(fftshift(fft(o2,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Hanning Window');

    o3 = conv(h3, signal);
    subplot(3,2,3);
    plot(20*log10(abs(fftshift(fft(o3,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Hamming Window');
   
    o4 = conv(h4, signal);
    subplot(3,2,4);
    plot(20*log10(abs(fftshift(fft(o4,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Blackmann Window');
    
    o0 = conv(h0, signal);
    subplot(3,2,5);
    plot(20*log10(abs(fftshift(fft(o0,1000)))));
    xlabel('Frequency');
    ylabel('Magnitude response(dB)');
    title('Result of using Rectangular Window');
end
