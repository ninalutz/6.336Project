function [F,J]=fjTransport(R,X,Isource,om,w)

%setup and book-keeping
beta=0.15;

[branches,nodes]=size(X);
nodes=nodes-1;

flowValues=om(1:branches,1);
timeValues=om(branches+1:end);

F=zeros(branches+nodes,1);
J=zeros(branches+nodes,branches+nodes);

%generating F and J row-by-row

%For conservation equations at each node
for i=1:nodes
    F(i,1)=flowValues.'*X(:,i);
    J(i,1:branches)=X(:,i).';
end
F(1:nodes,1)=F(1:nodes,1)-Isource;

% Function value for constitutive equations at each branch
for i=nodes+1:branches+nodes
    start=R(3,i-nodes);
    ed=R(4,i-nodes);
    t0=R(1,i-nodes);
    ka=R(2,i-nodes);
    
    %only calculate exponentials if flow is lesser than 0.1 , if its larger
    %exponential terms tends to a constant.
    if abs((flowValues(i-nodes)))< 10
        signterm=2*(exp(w*flowValues(i-nodes))/(1+exp(w*flowValues(i-nodes)))-0.5);
    else
        signterm=sign((flowValues(i-nodes)));
    end
    
  
    %prevent computational singularity at flow=0 as a result of the 'sign function'
    if signterm~=0
        f=t0*(1+beta*((flowValues(i-nodes)/ka)^4))*signterm;
    else
        f=t0*(1+beta*((flowValues(i-nodes)/ka)^4));
    end
    
%     fprintf('Expo term is %d \n',signterm);
    %taking care of grounded node
    if ed==nodes+1
        F(i,1)=timeValues(start,1)-f; 
    elseif start==nodes+1
        F(i,1)=-timeValues(ed,1)-f; 
    else
        F(i,1)=timeValues(start,1)-timeValues(ed,1)-f; 
    end
    
    %Jacobian rows for constitutive equation
    
    if start==nodes+1
        continue
    else   
        J(i,start+branches)=1;
    end
    if ed==nodes+1
        continue
    else
    J(i,ed+branches)=-1;
    end
    
    if abs(flowValues(i-nodes)) < 10
        first=(1+beta*((flowValues(i-nodes)/ka)^4))*(w*exp(w*flowValues(i-nodes)))/((1+exp(w*flowValues(i-nodes)))^2);
        second=(exp(w*flowValues(i-nodes)))/(1+exp(w*flowValues(i-nodes)))-0.5;
        third=(4*beta/(ka^4))*(flowValues(i-nodes))^3;
    else
        first=0;
        third=(4*beta/(ka^4))*(flowValues(i-nodes))^3;
        if sign(flowValues(i-nodes))==1
            second=0.5;
        elseif sign(flowValues(i-nodes))==-1
            second=-0.5;
        else 
            fprintf('flow has diverged and exceeded. %d \n',(flowValues(i-nodes)));
        end
    end
    
    J(i,i-nodes)=-2*t0*(first+(second*third));
%     fprintf('the maxJ is %d \n ',min(min((J))));
    
end

end

