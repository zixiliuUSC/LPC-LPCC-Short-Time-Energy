%{
discription: 
***The function being called: 
hamming_length.m, which is used to caculatethe window length according to the window length in msec. 
short-time energy: find out the voiced frame
***
%}
close all
[y,fs] = audioread('cats_and_dogs.wav');
[frame_s, E] = short_time_energy(y, fs, 30, 0.3);%this function returns the frame_s which is framing y in 30msec with  overlapping
n = 1:length(E);
figure;plot(n,E);title('short-time energy');xlabel('frame order');ylabel('short-time energy/J')

%according to the figure, we choose the 32th frame as s[n]
s = frame_s(:, 32);
figure;plot(0:1/fs:0.03-1/fs,s);title('original signal s[n]');xlabel('t');ylabel('normalized amptitude')
x = s.*hamming(hamming_length(30,fs));%caculate the length of 30msec window in fs sampling rate 
figure;plot(0:1/fs:0.03-1/fs,x);title('windowed signal x[n]');xlabel('t');ylabel('normalized amptitude')
X = fft(x,1024);
log_X = log(X);
c = ifft(log_X)';
c = fftshift(c);
cn = -0.064:1/fs:0.064-1/fs;%the signal length changes since we pad 0s to x[n]
figure;plot(cn,20*log10(abs(c)));title('cepstrum c-hat[n]');xlabel('t/s');ylabel('dB');axis([-40*10^(-3) 40*10^(-3) -inf inf]);

%{
Using the function in matlab to calculate complex cepstrum 
%figure;plot(cn,c);title('cepstrum c-hat[n]');xlabel('t/s');ylabel('dB');axis([-40*10^(-3) 40*10^(-3) -inf inf]);
%c_hat = cceps(s,1024);
%c_hat = fftshift(c_hat);
%figure;plot(cn,20*log10(abs(c_hat)));axis([-40*10^(-3) 40*10^(-3) -inf inf]);
%}

wc = [zeros(1,20) ones(1,200) zeros(1,20)];
wc1 = [zeros(1,(length(c)-length(wc))/2) wc zeros(1,(length(c)-length(wc))/2)];
figure;plot(-0.064:1/fs:0.064-1/fs,wc1);title('cepstrum window w_c with N'' = 200');xlabel('t/s');ylabel('dB');axis([-40*10^(-3) 40*10^(-3) -inf inf]);
cw0 = c.*[zeros(1,(length(c)-length(wc))/2) wc zeros(1,(length(c)-length(wc))/2)];
cw = cw0((length(c)-length(wc))/2+1:(length(c)-length(wc))/2+length(wc));
cw1 = fft(cw);
cw2 = exp(cw1);
y = ifft(cw2);
Y = fftshift(fft(y,1024));
X = fftshift(fft(x,1024));
w = -pi:2*pi/1024:pi;
figure;plot(w(1:end-1),20*log10(abs(Y)),w(1:end-1),20*log10(abs(X)));
legend('Y(w)','X(w)')
title('Y(w) with N'' = 200 and X(w)');
xlabel('rad/s');ylabel('normalized amptitude');

wc = [zeros(1,30) ones(1,180) zeros(1,30)];
%figure;plot(-0.015:1/fs:0.015-1/fs,wc);title('cepstrum window w_c with N'' = 200');xlabel('t/s');ylabel('dB');%axis([-40*10^(-3) 40*10^(-3) -inf inf]);
cw0 = c.*[zeros(1,(length(c)-length(wc))/2) wc zeros(1,(length(c)-length(wc))/2)];
cw = cw0((length(c)-length(wc))/2+1:(length(c)-length(wc))/2+length(wc));
cw1 = fft(cw);
cw2 = exp(cw1);
y = ifft(cw2);
Y = fftshift(fft(y,1024));
X = fftshift(fft(x,1024));
w = -pi:2*pi/1024:pi;
figure;plot(w(1:end-1),20*log10(abs(Y)),w(1:end-1),20*log10(abs(X)));
legend('Y(w)','X(w)')
title('Y(w) with N'' = 180 and X(w)');
xlabel('rad/s');ylabel('normalized amptitude');

wc = [zeros(1,60) ones(1,120) zeros(1,60)];
%figure;plot(-0.015:1/fs:0.015-1/fs,wc);title('cepstrum window w_c with N'' = 200');xlabel('t/s');ylabel('dB');%axis([-40*10^(-3) 40*10^(-3) -inf inf]);
cw0 = c.*[zeros(1,(length(c)-length(wc))/2) wc zeros(1,(length(c)-length(wc))/2)];
cw = cw0((length(c)-length(wc))/2+1:(length(c)-length(wc))/2+length(wc));
cw1 = fft(cw);
cw2 = exp(cw1);
y = ifft(cw2);
Y = fftshift(fft(y,1024));
X = fftshift(fft(x,1024));
w = -pi:2*pi/1024:pi;
figure;plot(w(1:end-1),20*log10(abs(Y)),w(1:end-1),20*log10(abs(X)));
legend('Y(w)','X(w)')
title('Y(w) with N'' = 120 and X(w)');
xlabel('rad/s');ylabel('normalized amptitude');