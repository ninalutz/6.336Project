
%Get the matrices that represent the network
[R,M]=getMatrices('C');
[branches,nodes]=size(M);

%read CSV to get the flow demand at each origin at each time
[X]=readSourceCSV('NC');

%get smoothen input across all times
sigma=0.5;
start=4;
T=13;
dt=0.0001;
[U]=getSmoothInput(start,X,T,dt,sigma,nodes);

%we first solve for steady state at t=0 to be used as our starting state
InitialS=U(:,1);
InitialS(1)=-sum(InitialS);
InitialS=InitialS(2:end,1);
w=15;
x0=zeros(branches+nodes-1,1);
for i=1:size(x0,1)
    x0(i)=1;
end
fhand=@(g) fjTransport(R,M,InitialS,g,w);

%[counter,flag]=checkDisconnect(M);

[f,J]=fhand(x0);
f=sparse(f);
J=sparse(J);
-J\f;
initialClose=newtonNdTransport(fhand,x0,7,'on');

%%%%%%%%%%%%%dynamic analysis%%%%%%%%
startTime=initialClose(branches+1:end,1);
startFlow=initialClose(1:branches,1);

tic
[TimeTraj,FlowTraj]=forwardEulTransport(startFlow,startTime,6,dt,R,M,U);
toc


%%%%%%%%%%%
%plotting
timeArray=0:dt:(9);
output=FlowTraj(1,:);
figure(1);
plot(timeArray(1:end),output,'.');
xlabel('Time (s) '); ylabel('Flow'); title('Start Horizontal Flow vs time');

%take sample in intervals of 10 for visualization
new=sampleTraj(FlowTraj);
dlmwrite('PM_carpooling_solution.csv', new,'delimiter',',');
