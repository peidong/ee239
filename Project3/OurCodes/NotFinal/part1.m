% The full u data set, 100000 ratings by 943 users on 1682 items.
% user id | item id | rating | timestamp
% u is the matrix 100000x4
load ./ml-100k/u.data;
addpath ./nmfv1_4;

Rmat = zeros(943,1682);
for i=1:100000
    Rmat(u(i,1),u(i,2)) = u(i,3);
end

% Wmat : weight matrix
Wmat = zeros(943,1682);
Wmat(find(Rmat > 0)) = 1;

% When Rmat[i][j] == 0, tempRmat[i][j] = nan
tempRmat = Rmat;
tempRmat(find(Rmat == 0)) = nan;% NAN : Not A Number

option = struct();
option.dis = false;% not display Information

k = [10,50,100];

% LSE : Least Square Error
LSE = zeros(length(k),1);
finalResidual = zeros(length(k),1);
for itr=1:length(k)

    [U,V,numIter,tElapsed,finalResidual(itr)] = wnmfrule(tempRmat,k(itr),option);
    UV = U*V;

    LSE(itr) = sqrt(sum(sum((Wmat .* (Rmat - UV)).^2)));
end
