function [R]=readSourceCSV(type)
if type=='NC'
    M1 = csvread('C5noncarpool.csv',1,0);
    M1(:,3)=5;
    M2= csvread('C9noncarpool.csv',1,0);
    M2(:,3)=9;
    M3= csvread('C10noncarpool.csv',1,0);
    M3(:,3)=10;
    M4= csvread('C11noncarpool.csv',1,0);
    M4(:,3)=11;
    R=[M1;M2;M3;M4];

elseif type=='C'
    M1 = csvread('C5carpool.csv',1,0);
    M1(:,3)=5;
    M2= csvread('C9carpool.csv',1,0);
    M2(:,3)=9;
    M3= csvread('C10carpool.csv',1,0);
    M3(:,3)=10;
    M4= csvread('C11carpool.csv',1,0);
    M4(:,3)=11;
    R=[M1;M2;M3;M4];
end

end