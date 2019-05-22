function [ frame_sig] = framing_and_windowing( sig, fs, winlength, overlap, normalize, windowtype)
%{
Copyright: Zixi Liu, Email: zixiliu@usc.edu
discription: 
~sig: sig should be the voice signal reading by audioread
~fs: the sampling rate of the signal 
~winlength: window length, the window length is given in msec.
~overlap: the overlapping number in ratio, 0.xxxx
~normalize: give 1 to normalize signal, give 0 to use original signal to
process
~windowtype: 'hamming', 'retangular', 'hanning'
**The window type used in this function is hamming window. 
***The function being called: hamming_length.m, which is used to caculate
window length
%}
male_neu = sig;

if normalize == 1
    m_mean = mean(male_neu);
    m_std = std(male_neu);
    male_neu = (male_neu - m_mean)/m_std;
end

hamm_len = hamming_length(winlength,fs);
frame_m = buffer(male_neu,hamm_len,overlap*hamm_len,'nodelay');%framing according to the length of hamming window

if windowtype == 'hamming'
    hamm_w = hamming(hamm_len);%create hamming window
elseif windowtype == 'retangular'
    hamm_w = ones(hamm_len,1);
elseif windowtype == 'hanning'
    hamm_w = hann(hamm_len);
end

for i = 1:size(frame_m(1,:))
    frame_m(:,i) = frame_m(:,i).*hamm_w;
end
frame_sig = frame_m;
end 
