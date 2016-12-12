function [R,M]=getMatrices(inpt)
if inpt=='O'
    filename='OpeningRoads_Final.csv';
elseif inpt=='C'
    filename='ClosingRoads_Final.csv';
end

Y= csvread(filename,1,0);
N=size(Y,1);
for i =1:N
    R(1,i)=Y(i,4)/Y(i,3); %t0
    R(2,i)=Y(i,5); %ka
    R(3,i)=Y(i,1); %start
    R(4,i)=Y(i,2); %end
end

maxNode=max(max(R(3:4,:)));
maxComp=size(R,2);
M=zeros(maxComp,maxNode);
for i=1:maxComp
    start=R(3,i);
    ed=R(4,i);
    M(i,start)=1;
    M(i,ed)=-1;
end
M=sparse(M);




end
