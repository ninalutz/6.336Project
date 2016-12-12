function [X,Y]=forwardEulTransport(startFlow,startTime,T,dt,R,M,U)
iters=T/dt;
X=startTime;
Y=startFlow;
w=10;
for i=1:iters
    Timedt=Dtdt(Y(:,i),R,M,U(2:end,i+1));
    X(:,i+1)=X(:,i)+dt*Timedt;
    fhand=@(x) fjNodes(x,X(:,i+1),w,R,M);
    %disp('found new flows');
    %fprintf(1,'time now is %d \n',i);
    Y(:,i+1)=newtonNdTransport(fhand,Y(:,i),5,'off');   
end


end
