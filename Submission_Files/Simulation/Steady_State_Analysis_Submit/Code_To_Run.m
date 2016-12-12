
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w=50;

%load network
[R,M]=getMatrices('O');
[branches,nodes]=size(M);

%load Isources
Isource=readSourceCSV2(7,1,nodes);
Isource(1)=Isource(1)+0.01;

x0=zeros(branches+nodes-1,1);
for i=1:size(x0,1)
    x0(i)=1;
end
fhand=@(g) fjTransport(R,M,Isource,g,w);

[f,J]=fhand(x0);
f=sparse(f);
J=sparse(J);
-J\f;
sol=newtonNdTransport(fhand,x0,'on');
sol_7c=sol;

% 
% dlmwrite('7nc.csv', sol_7nc,'delimiter',',');
% dlmwrite('7c.csv', sol_7c,'delimiter',',');
% 
% dlmwrite('9nc.csv', sol_9nc,'delimiter',',')
% dlmwrite('9c.csv', sol_9c,'delimiter',',')
% 
% dlmwrite('11nc.csv', sol_11nc,'delimiter',',')
% dlmwrite('11c.csv', sol_11c,'delimiter',',')
% 
% 
% dlmwrite('distributed_nc.csv', sol_balancednc,'delimiter',',')
% dlmwrite('distributed_c.csv', sol_balancedc,'delimiter',',')


