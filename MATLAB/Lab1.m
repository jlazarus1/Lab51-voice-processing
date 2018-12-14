
%% Question 1 simple signal processing

F1=256;
F2=250;
Fs=8*10^3;
Ts=1/Fs;
t=(0:1:255)*Ts;

sine1 = sin(2*pi*F1*t);
sine2 = sin(2*pi*F2*t);

Fourier1 = fftshift(fft(sine1));
Fourier2 = fftshift(fft(sine2));

figure(1);
subplot(2,1,1);
stem(abs(Fourier1));
title("stems of sine with freq of 256Hz");
xlabel("freq[Hz]");
ylabel("DFT");

subplot(2,1,2);
stem(abs(Fourier2));
title("stems of sine with freq of 250Hz");
xlabel("freq[Hz]");
ylabel("DFT");

%Plot the DFT of the sines in DB
y = linspace(-Fs/2,Fs/2,256);

figure(2);

subplot(2,1,1);
plot(y,20*log(abs(Fourier1)));
title("sine with freq of 256Hz");
xlabel("freq[Hz]");
ylabel("DFT [dB]");
xlim([0 Fs/2]);

subplot(2,1,2);
plot(y,20*log(abs(Fourier2)));
title("sine with freq of 250Hz");
xlabel("freq[Hz]");
ylabel("DFT [dB]");
xlim([0 Fs/2]);

%% 1.2 Random vector and Periodogram
n =1000;
RandomVec = randn(1,n);
y_auto = linspace(-Fs/2,Fs/2 ,3000);
R_s=xcorr(RandomVec);
R_s_fft= fftshift(fft(R_s,3000));
figure(3);
subplot(2,1,1);
plot(y_auto,20*log(abs(R_s_fft)));
title("autocorrelation of white noise(log scale)");
xlabel("freq [Hz]");
ylabel("X_d[S(f)] [dB]");

load('FIR_co.mat');
filter_noise = filter(Num,1,RandomVec);

periodogram_spec = (abs(fftshift(fft(filter_noise,3000)))).^2/length(filter_noise);

figure(3);
subplot(2,1,2);
y_Periodogram=linspace(-4000,4000,3000);
plot(y_Periodogram,20*log(periodogram_spec));
title("White noise through LPF");
xlabel("freq [Hz]");
ylabel("X_d[S(f)] [dB]");


%% 2 speech signal and it's qualities
audio_freq=8*10^3;
T_audio=1/audio_freq;
audio=audioread('Speech2.wav');
soundsc(audio);

%%2.2 Zero padding

c= ceil(length(audio)/256)*256-length(audio);
padded_audio = [audio ; zeros(c,1)];

%2.3 - the signal in time 

figure(4);
t=0:T_audio:(length(padded_audio)*T_audio)-T_audio;
plot(t,padded_audio);
title("Speech2.wav graphed by time");
xlabel('t[sec]');
ylabel('amp');

%2.4 - splitting the signal into windows and choosing voiced and unvoiced

frames = reshape(padded_audio',256,length(padded_audio)/256)';


figure(5)

%Unvoice 
unvoiced=frames(36,:);
subplot(2,1,1);
plot(unvoiced);
title('Unvoiced frame (frame 36)');
xlabel('t[sec]');
ylabel('amp');

%voiced

subplot(2,1,2);
voiced=frames(31,:);
plot(voiced);
title('Voiced frame (frame 31)');
xlabel('t[sec]');
ylabel('amp');

%2.5 - Revluation of Voiced frame in freq domain
figure(6);

%single cicle dft
DFT_voiced_single=fftshift(fft(voiced(80:121)));
y_single=linspace(0,256,42);
subplot(2,1,1);
hold all;
plot(y_single,abs(DFT_voiced_single));
title("DFT of a single cicle of the voiced frame")
xlabel("freq[Hz]")
ylabel("X_d[\theta]")



%DFT of the whole frame
y_single_voiced=linspace(0,256,256);
DFT_voiced = fftshift(fft(voiced));
subplot(2,1,1);
plot(y_single_voiced,abs(DFT_voiced/max(DFT_voiced_single)));
title("DFT of the voiced frame with the enveloped drawn ")
xlabel("K")
ylabel('X_D[K]')
subplot(2,1,2);
plot(abs(DFT_voiced));
title("DFT of the voiced frame ")
xlabel("K")
ylabel('X_D[K]')

