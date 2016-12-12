function [F]=fjNodes2(timeValues,flowValues,gamma,dt,w,R,M,Isource)
%first, find flow values given timevalues
fhand=@(x) fjNodes(x,timeValues,w,R,M);
newFlows=newtonNdTransport(fhand,flowValues,5,'off');
%use flowvalues to compute DTdt
newTimedt=Dtdt(newFlows,R,M,Isource);
F=timeValues-(dt/2)*newTimedt-gamma;
end

