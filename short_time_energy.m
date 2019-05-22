function [ frame_sig, E ] = short_time_energy( sig, fs, winlength, overlap)
%{
header: hw3@EE519, answer for question 4
Copyright: Zixi Liu, USCID: 2219403275, Email: zixiliu@usc.edu
discription: 
~sig: sig should be the voice signal reading by audioread
~fs: the sampling rate of the signal 
~winlength: window length
~overlap: the overlapping number in ratio, 0.xxxx
**The window used in this function is hamming window. 
***The function being called: hamming_length.m, which is used to caculate
the window length according to the window length in msec. 
%}
male_neu = sig;
m_mean = mean(male_neu);
m_std = std(male_neu);
male_neu = (male_neu - m_mean)/m_std;
hamm_len = hamming_length(winlength,fs);
frame_m = buffer(male_neu,hamm_len,overlap*hamm_len);%framing according to the length of hamming window
%n = 1:(1-overlap)*hamm_len:length(male_neu);%number of frames
hamm_w = hamming(hamm_len);%create hamming window
Ey = zeros(size(frame_m(1,:)));%Ey to store short-time energy
for j = 1:length(Ey)
    Ey(j) = sumsqr(frame_m(:,j).*hamm_w);%caculate short-time energy under hamming window
end
E = Ey;
frame_sig = frame_m;
end 

