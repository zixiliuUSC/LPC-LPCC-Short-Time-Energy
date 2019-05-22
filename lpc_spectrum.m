%{
Copyright: Zixi Liu, USCID: 2219403275, Email: zixiliu@usc.edu
discription: 
*The function being called: hamming_length.m, which is used to caculatethe window length according to the window length in msec. 
%}
close all
[y,fs] = audioread('cats_and_dogs.wav');
[frame_s, E] = short_time_energy(y, fs, 30, 0.3);
s = frame_s(:, 32);
x = s.*hamming(hamming_length(30,fs));%caculate the length of 30msec window in fs sampling rate 
[a,g] = lpc(x,12);%the sampling rate is 8kHz, so the poles number would be 8+4(source excitation and the radiation load)
x_est = filter([0 -a(2:length(a))],1,x);
e = x-x_est;
G = sum(e.^2);
Ew = fft(e, 1024);
Ew = fftshift(Ew);
w = -pi:2*pi/1024:pi;
plot(w(1:end-1),20*log10(abs(Ew)));

[a1,g1] = lpc(x,120);%the sampling rate is 8kHz, so the poles number would be 8+4(source excitation and the radiation load)
x_est1 = filter([0 -a1(2:length(a1))],1,x);
e1 = x-x_est1;
G1 = sum(e1.^2);
Ew1 = fft(e1, 1024);
Ew1 = fftshift(Ew1);
w = -pi:2*pi/1024:pi;
hold on
plot(w(1:end-1),20*log10(abs(Ew1)));
legend('p = 12','p = 120');
title('spectrum of e[n]')
xlabel('freq/(rad/s)'),ylabel('amptitude/dB');grid

figure
plot(1:length(e),e,1:length(e1),e1)
legend('p = 12','p = 120');
title('plot of e[n]')
xlabel('n'),ylabel('e[n]');grid
%{
Xw = fftshift(fft(x,1024));
figure
plot(w(1:end-1),Xw)
%}

[H, w0] = freqz(G,a,-pi:2*pi/1024:pi);
[H1,w1] = freqz(G,a1,-pi:2*pi/1024:pi);
Xw = fftshift(fft(x,1024));
figure
plot(w0,20*log10(abs(H)),w1,20*log10(abs(H1)),w0(1:end-1),20*log10(abs(Xw)))
title('spectrum of LPC models and x[n]')
legend('LPC model p = 12','LPC model p = 120','x[n]''s spectrum')
xlabel('freq/(rad/s)'),ylabel('amptitude/dB');grid

