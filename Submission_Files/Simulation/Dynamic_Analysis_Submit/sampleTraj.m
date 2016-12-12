function new=sampleTraj(FlowTraj)

new=zeros(349,1);
counter=1;
for i=1:10:90001
    new(:,counter)=FlowTraj(:,i);
    counter=counter+1;
end

end
