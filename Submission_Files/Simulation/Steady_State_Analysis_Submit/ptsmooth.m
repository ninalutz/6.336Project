function [x] =ptsmooth(t0,t,sigma)
a=-1*((t-t0)^2)/(2*(sigma^2));
x=1/(sqrt(2*pi)*sigma)*exp(a);
end
