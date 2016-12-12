function ansr = newtonNdTransport(fhand,x0,itpause,varargin)

if nargin<3
    error('Must provide three input arguments.  Type ''help newton1d'' for details');
end
tol=1e-2;          % convergence tolerance
tol2=1e-1;
maxIters=50000;       % max # of iterations
x00=x0;             % initial guess
N=size(x0,1);
x=zeros(N,1);
% Newton loop
for iter=1:maxIters
    [f,J]=fhand(x0);            % evaluate function
    J=sparse(J);
    f=sparse(f);
    dx=-J\f;                    % solve linear system
    ndx(iter)=norm(dx,2);
    alpha=min(1,1/ndx(iter));
    dx=dx*alpha;
    nf(iter)=norm(f,2);            % norm of f at step k+1
             % norm of dx at step k+1
    x(:,iter)=x0+dx;              % solution x at step k+1
    x0=x(:,iter);                 % set value for next guess
    if nf(iter) < tol && ndx(iter)<tol2 % check for convergence
        % check for convergence
        %fprintf('Converged to F=%4.12e in %d iterations\n',nf(iter),iter);
        break; 
    end
end

if iter==maxIters, % check for non-convergence
    fprintf('Non-Convergence after %d iterations!!!\n',iter); 
end
if iter==1
    ansr=x(:,iter);
else
    
    ansr=x(:,iter-1);
end

% stuff for plotting
x=[x00,x];


% plot a few things
if ~isempty(varargin) && strcmp(varargin{1},'off')
else
    figure(2);
    finalF=fhand(x0);
    finalnorm=norm(finalF,2);
    nf=[nf,finalnorm];
%     nf=nf*(1/nf(1));
    iters=0:iter;
    semilogy(iters,nf,'*-'); grid on; 
    xlabel('iteration #'); ylabel('|f(x_k)|');
    title(' ||F(x)|| Covergence for Problem 4 ')
    
    figure(3);
    xs=[x00,x];
    for i=1:(iter+1)
        xs(:,i)=xs(:,i)-xs(:,end);
        norms(i)=norm(xs(:,i),2);
    end
    fprintf('%d al',norms(end));
    iters=0:iter;
    semilogy(iters,norms,'*-'); grid on; 
    xlabel('iteration #'); ylabel('||x - x*||');
    title('||x - x*||Covergence for Problem 4')
    
    
end
end
