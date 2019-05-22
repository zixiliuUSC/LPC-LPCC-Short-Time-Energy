%{
discription: 
**Proof rx = [0.1327;0.1145;0.0687;0.0119;-0.0392;-0.0710;-0.0786;-0.0672;
-0.0460;-0.0220]'is also a definite sequence.
**calculate 9 order linear predictor for rx
Function being called: lpccoof.m, which is use to calculate the LPC
coefficient. 
%}
rx = [0.1327;0.1145;0.0687;0.0119;-0.0392;-0.0710;-0.0786;-0.0672; -0.0460;-0.0220]'
R = [rx;flip(rx(1:2)) rx(2:end-1);flip(rx(1:3)) rx(2:end-2);
    flip(rx(1:4)) rx(2:end-3);flip(rx(1:5)) rx(2:end-4);
    flip(rx(1:6)) rx(2:end-5);flip(rx(1:7)) rx(2:end-6);
    flip(rx(1:8)) rx(2:end-7);flip(rx(1:9)) rx(2:end-8);
    flip(rx(1:10))]
if R==R'
    fprintf('rx is a definite sequence.\n')
else
    fprintf('rx is not a definite sequence.')
end
[y,a,k]=lpccoff(rx,9)