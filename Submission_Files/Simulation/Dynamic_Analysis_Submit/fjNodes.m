function [F,J]=fjNodes(flowValues,timeValues,w,R,X)

%setup and book-keeping
beta=0.15;

[branches,nodes]=size(X);
nodes=nodes-1;

%generating F and J row-by-row

% Function value for constitutive equations at each branch
for i=1:branches
    start=R(3,i);
    ed=R(4,i);
    t0=R(1,i);
    ka=R(2,i);
    
    %only calculate exponentials if flow is lesser than 0.1 , if its larger
    %exponential terms tends to a constant.
    if abs(flowValues(i))< 5
        signterm=2*(exp(w*flowValues(i))/(1+exp(w*flowValues(i)))-0.5);
    else
        signterm=sign((flowValues(i)));
    end
    
    %prevent computational singularity at flow=0 as a result of the 'sign function'
    if signterm~=0
        f=t0*(1+beta*((flowValues(i)/ka)^4))*signterm;
    else
        f=t0*(1+beta*((flowValues(i)/ka)^4));
    end
    
%     fprintf('Expo term is %d \n',signterm);
    %taking care of grounded node
    if ed==1
        F(i,1)=timeValues(start-1,1)-f; 
    else
        F(i,1)=timeValues(start-1,1)-timeValues(ed-1,1)-f; 
    end
    
    %Jacobian rows for constitutive equation
    
    if abs(flowValues(i)) < 5
        first=(1+beta*((flowValues(i)/ka)^4))*(w*exp(w*flowValues(i)))/((1+exp(w*flowValues(i)))^2);
        second=(exp(w*flowValues(i)))/(1+exp(w*flowValues(i)))-0.5;
        third=(4*beta/(ka^4))*(flowValues(i))^3;
    else
        first=0;
        third=(4*beta/(ka^4))*(flowValues(i))^3;
        if sign(flowValues(i))==1
            second=0.5;
        elseif sign(flowValues(i))==-1
            second=-0.5;
        else 
            fprintf('flow has diverged and exceeded. %d \n',(flowValues(i)));
        end
    end
    
    J(i,i)=-2*t0*(first+(second*third));
%     fprintf('the maxJ is %d \n ',min(min((J))));
    
end

end

