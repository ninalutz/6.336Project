function [Jx]=atv(x0,b,fhand,r)
    ep=1e-9;
    newF=fhand(x0+(r*ep));
    Jx = (1/ep)*(newF +b);
end
