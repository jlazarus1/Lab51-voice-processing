
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
filter_noise = filter(FIR_LAB,1,RandomVec);

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

%% 2.2 Zero padding

c= ceil(length(audio)/256)*256-length(audio);
padded_audio = [audio ; zeros(c,1)];


%% 2.3 - the signal in time 

figure(4);
t=0:T_audio:(length(padded_audio)*T_audio)-T_audio;
plot(t,padded_audio);
title("Speech2.wav graphed by time");
xlabel('t[sec]');
ylabel('amp');
%% 2.4 - splitting the signal into windows and choosing voiced and unvoiced

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


%% 2.5 - Revluation of Voiced frame in freq domain
figure(6);

%single cicle dft
DFT_voiced_single=fftshift(fft(voiced(80:121)));
y_single=linspace(0,256,42);
subplot(3,1,1);
hold all;
plot(y_single,abs(DFT_voiced_single));
title("DFT of a single cicle of the voiced frame")
xlabel("freq[Hz]")
ylabel("X_d[\theta]")


%DFT of the whole frame
y_single_voiced=linspace(0,256,256);
DFT_voiced = fftshift(fft(voiced));
subplot(3,1,1);
plot(y_single_voiced,abs(DFT_voiced/max(DFT_voiced_single)));
title("DFT of the voiced frame with the enveloped drawn ")
xlabel("K")
ylabel('X_D[K]')
subplot(3,1,2);
plot(abs(DFT_voiced));
title("DFT of the voiced frame ")
xlabel("K")
ylabel('X_D[K]')

%DFT of windowed voiced
voiced_padded = [voiced zeros(1,200)];
voiced_W = voiced_padded.*hamming(length(voiced));
voiced_W_F = fftshift(fft(voiced_padded));

subplot(3,1,3)
plot(abs(voiced_W_F));
title("DFT of the voiced frame with zero padding ")
xlabel("K")
ylabel('X_D[K]')

%% 2.6 preprocessing
figure(7);

filter_audio = filter(FIR_LAB,1,audio);

c1= ceil(length(filter_audio)/256)*256-length(filter_audio);
padded_filtered = [filter_audio ; zeros(c1,1)];
frames_filtered = reshape(padded_filtered',256,length(padded_filtered)/256)';
voiced_filtered=frames_filtered(31,:);
voiced_Pre = clip(voiced_filtered);
subplot(3,1,1)
plot(voiced_Pre);
title("the voiced frame with pre filter")
xlabel("K")
ylabel('X_D[K]')


voiced_Pre_padded = [voiced_Pre zeros(1,200)];
voiced_pre_F = fftshift(fft(voiced_Pre_padded));
subplot(3,1,2);
plot(abs(voiced_pre_F))
title("DFT of the pre filtered audio")
xlabel("K")
ylabel('X_D[K]')



%% 2.7 Revaluation of unvoiced parameters in freq domain
figure(8)

unvoiced_F = fftshift(fft(unvoiced));
subplot(2,1,2);
plot(abs(unvoiced_F));
title("DFT of the unvoiced signal")
xlabel("k")
ylabel('X_d[k]')

subplot(2,1,1);
t1 = (0:1:255)*Ts;
plot(t1,unvoiced);
title("unvoiced signal in time")
xlabel("t[sec]")
ylabel('x')

%% 2.8 revaluation of the pitch for the voiced frame in time domain
figure (9)
subplot(3,1,1)
plot(xcorr(voiced))
title("Voiced autocorrelation")
xlabel("K")
ylabel('autocorrelation')

pitch_voiced = pitch_detect_corr(voiced);

filtered_voiced = filter(FIR_LAB,1,voiced);
voiced_win = filtered_voiced.*hamming(1,256);
subplot(3,1,2)
plot(abs(voiced_win))
title("Voiced autocorrelation after filtering and window")
xlabel("K")
ylabel('autocorrelation')


pitch_voiced_filtered = pitch_detect_corr(filtered_voiced);


%again with function pitch_detect_ceps;

pitch_voiced_ceps = pitch_detect_ceps(filtered_voiced);

Sf=20*log(abs(fftshift(fft(filtered_voiced))));
Cn=real(ifft(abs(Sf)));
[pks,locs,~,~] = findpeaks(Cn,8*10^3);
subplot(3,1,3);
plot(locs,pks);
title("Voiced cepstrum")
xlabel("quefrency")
ylabel('Cepstrum')

%% 2.9 - autocorrelation of the Unvoiced frame

figure (10)
plot(xcorr(unvoiced))
title("Unvoiced autocorrelation")
xlabel("K")
ylabel('autocorrelation')

%% 3.2


E_voiced=sum(voiced.^2)/256;
E_unvoiced=sum(unvoiced.^2)/256;

voiced_zero_crossing = zero_cross(voiced);
unvoiced_zero_crossing = zero_cross(unvoiced);

unvoiced_filtered=frames_filtered(36,:);
unvoiced_Pre = clip(unvoiced_filtered);
 
vu_voiced = vu_classify(voiced,voiced_Pre);
vu_unvoiced  = vu_classify(unvoiced,unvoiced_Pre);





