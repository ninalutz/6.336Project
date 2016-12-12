function [U]=getSmoothInput(start,R,T,dt,sigma,nodes)
origin=1;
U=sparse(nodes,((T-start)/dt)+1);
N=size(R,1);
for i=1:N
    nodeno=R(i,1);
    amp=R(i,2);
    t0=R(i,3);
    U(nodeno,:)=amp*linesmooth(start,T,dt,t0,sigma);
    
end

U=(1/10)*U;
end