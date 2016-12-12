infoMat = csvread('OpeningRoads_Working_Final_With_solution.csv',1,0);
TtoGroundMat = csvread('Solution_NodeValues.csv', 1,0);
N = 261; %number of road links. Hardcoded since can't be derived from num rows.
warningScaleFactor = 1.2;
flagMatrix7am = zeros(N,N);
flagMatrix7amCarpool = zeros(N,N);
flagMatrix9am = zeros(N,N);
flagMatrix9amCarpool = zeros(N,N);
flagMatrix11am = zeros(N,N);
flagMatrix11amCarpool = zeros(N,N);
%index determines row we are examining. We'll look at all rows in sequence.
for row=1:N
    %First col of OpeningRoads has start node.
    i = infoMat(row,1);
    %Second col of OpeningRoads has end node.
    j = infoMat(row,2);
    %Sixth col of OpeningRoads has freeflow between nodes. True for all
    %times, since freeflow is time-indep.
    Txy0(i,j) = infoMat(row,6);
    %We need TtoGroundMat now. Row indicates node.
    %First column is node num, ignore. 
    %Second col is 7am time no carpool.
    %Third coll is 7am time with carpool.
    %4 = 9 am no, 5 = 9 am with, 
    %6 = 11am no, 7 = 11am with. 
    Txy7am(i,j) = abs(TtoGroundMat(i,2) - TtoGroundMat(j,2));
    Txy7amPool(i,j) = abs(TtoGroundMat(i,3) - TtoGroundMat(j,3));
    Txy9am(i,j) = abs(TtoGroundMat(i,4) - TtoGroundMat(j,4));
    Txy9amPool(i,j) = abs(TtoGroundMat(i,5) - TtoGroundMat(j,5));
    Txy11am(i,j) = abs(TtoGroundMat(i,6) - TtoGroundMat(j,6));
    Txy11amPool(i,j) = abs(TtoGroundMat(i,7) - TtoGroundMat(j,7));
    baseline = Txy0(i,j);
    threshold = warningScaleFactor*baseline;
    if(Txy7am(i,j) >= threshold)
        flagMatrix7am(i, j) = 1;
    end
    if(Txy7amPool(i,j) >= threshold)
        flagMatrix7amCarpool(i,j) = 1;
    end
    if(Txy9am(i,j) >= threshold)
        flagMatrix9am(i, j) = 1;
    end
    if(Txy9amPool(i,j) >= threshold)
        flagMatrix9amCarpool(i,j) = 1;
    end
    if(Txy11am(i,j) >= threshold)
        flagMatrix11am(i, j) = 1;
    end
    if(Txy11amPool(i,j) >= threshold)
        flagMatrix11amCarpool(i,j) = 1;
    end
end
figure('Name', '7am image rep, no carpool')
plot(flagMatrix7am, 'Color', [0.5,0.2,0.2])
figure('Name', '7am image rep, with carpool')
plot(flagMatrix7amCarpool, 'Color', [0.5,0.2,0.2])
figure('Name', '9am image rep, no carpool')
plot(flagMatrix9am, 'Color', [0.5,0.2,0.2])
figure('Name', '9am image rep, with carpool')
plot(flagMatrix9amCarpool, 'Color', [0.5,0.2,0.2])
figure('Name', '11am image rep, no carpool')
plot(flagMatrix11am, 'Color', [0.5,0.2,0.2])
figure('Name', '11am image rep, with carpool')
plot(flagMatrix11amCarpool, 'Color', [0.5,0.2,0.2])