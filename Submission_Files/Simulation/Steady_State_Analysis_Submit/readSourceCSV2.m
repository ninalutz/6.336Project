function [Isource]=readSourceCSV2(h,c,nodes)
if h==7
    if c==0
        R = csvread('O7noncarpool.csv',1,6);
    elseif c==1
        R = csvread('O7carpool.csv',1,6);
    end
    
elseif h==9
    if c==0
        R = csvread('O9noncarpool.csv',1,0);
    elseif c==1
        R = csvread('O9carpool.csv',1,0);
    end
    
elseif h=='dist'
    if c==0
        R = csvread('balanced_nc.csv',1,0);
    elseif c==1
        R = csvread('balanced_c.csv',1,0);
    end
    
elseif h==11
    if c==0
        R = csvread('O11noncarpool.csv',1,6);
    elseif c==1
        R = csvread('O11carpool.csv',1,6);
    end
else
    R = csvread('ClosetestOD.csv',1,6);
end
into=R(:,2);
Isource=zeros(nodes-1,1);
Isource(1)=sum(into,1);
for i=1:size(R,1)
    j=R(i,1);
    k=R(i,2);
    Isource(j)=Isource(j)-k;
end
Isource=Isource/60;
end