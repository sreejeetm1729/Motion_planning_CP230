% Daikstra's algorithm
%Q2
function N = findnearestneighbour(i,D)
N = find(D(i,:) > 0 & D(i,:) < Inf);
end