function [F]=Dtdt(flows,R,M,Isource)
[nodes]=size(M,2);
nodes=nodes-1;
for i=1:nodes
    F(i,1)=flows.'*M(:,i+1);
end
F=F-Isource;
F=-5*F;
end
