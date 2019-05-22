function y = hamming_length( l,fs )
%{
header: hw2@EE519, answer for question 5
Copyright: Zixi Liu, USCID: 2219403275, Email: zixiliu@usc.edu
Disctiption: function hamming_length(l,fs) is used to create hamming window 
according to the sampling rate fs, and the time length l in msec. It will return 
a the same size vector as l which contain the hamming windows length under 
sampling rate fs. This function can also be used to caculate other kinds of 
window length.
%}
y = zeros(size(l));
for i = 1:length(l)
    y(i) = floor(l(i)*10^(-3)/(fs^(-1)));
end
end

