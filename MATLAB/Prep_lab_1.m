%clear;
%clc;
%% Question 1 Part 1

Fs=10*10^3;
Ts=1/Fs;
t=(0:1:255)*Ts;
f=linspace(-Fs/2,Fs/2,256);
Freq=[ 3*10^3 2*10^3 1*10^3 ];

x = sin(2*pi*Freq(1)*t)+sin(2*pi*Freq(2)*t)+sin(2*pi*Freq(3)*t);

x = x'.*hamming(256);

X_fourier =fftshift( fft(x'));

figure(1)

subplot (2,1,1);
plot(f,abs(X_fourier));
title("Frequency domain of the sine function with freq 3k,2k,1k");
xlabel('\theta[Hz]');
ylabel('|(H(f)|');

%% Question 1 Part 2

Freq2=[ 1*10^3 2*10^3 9*10^3 ];
x = sin(2*pi*Freq2(1)*t)+sin(2*pi*Freq2(2)*t)+sin(2*pi*Freq2(3)*t);
x = x'.*hamming(256);

X_fourier2 = fftshift(fft(x'));

subplot (2,1,2);

plot (f,abs(X_fourier2));
title ("Frequency domain for sine function with freq 1k,2k,9k");
xlabel('\theta[Hz]');
ylabel('|(H(f)|');

%% Question 7
Fc=60;
y=linspace(0,100,1000);
sine=sin(2*pi*Fc*y);
figure(2);
plot(y,sine);
hold all;
cliped=clip(sine);
plot(y,cliped);
title("sine wave clipped and not clipped on the same graph");
xlabel("x");
ylabel("sine");
legend('unclipped','clipped');

%% Question 8

[h w] = freqz(Num,256);
figure(5);

plot(linspace(0,8000,512),20*log(abs(h')));
title("FIR lowPass filter");
grid on;