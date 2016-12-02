function flagVector = createFlagVector(kaiMat, boundary, freeflowMat)
%Returns the flagVector which needs to be plotted.
TtoGroundMat = kaiMat(boundary:end,:);
N = size(freeFlowMat,2);
flagVector = zeros(1,k);
for k=1:N
    currentRoad(freeflowMat(:,k));
    i = currentRoad(1,1);
    j = currentRoad(2,1);
    len = currentRoad(4,1);
    speed = currentRoad(5,1);
    Txy0(i,j) = len/speed;
    Txy(i,j) = abs(TtoGroundMat(i,1) - TtoGroundMat(j,1));
    if(Txy(i,j) >= 2*Txy0(i,j))
        flagVector(k) = 1;
    end
end

