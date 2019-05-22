function [y,a_,k_] = lpccoff( R, p )
%{
Copyright: Zixi Liu, Email: zixiliu@usc.edu
%this fuction is to use Levinson-Durbin method to compute LPC cofficiences
a[n]
%the input R should be a 1*n row vector,and R is autocorelation of the
signal
%p is the order of the the predictor
%}
r = R(1:p+1);
a = zeros(p,p);
e = [r(1),zeros(1,p)];
a(1,1) = r(2)/r(1);
k = [a(1,1),zeros(1,p-1)];
e(2) = e(1)*(1 - k(1)^2);
for i = 2:p
    r1 = flip(r(2:i));
    k(i) = (r(i+1) - sum(a(i-1,1:i-1).*r1))/e(i);
    a(i,i) = k(i);
    for j = 1:i-1
        a(i,j) = a(i-1,j) - k(i)*a(i-1,i-j);
    end
    e(i+1) = (1 - k(i)^2)*e(i);
end
y = a(p,:);
a_=a;
k_=k;
end

