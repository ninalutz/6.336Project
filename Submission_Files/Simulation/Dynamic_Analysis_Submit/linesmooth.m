function [u]=linesmooth(start,T,dt,t0,sigma)

timeArray=start:dt:T;
u=zeros(1,size(timeArray,2));
counter=1;
for t=timeArray
    u(counter)=ptsmooth(t0,t,sigma);
    counter=counter+1;
end

end
