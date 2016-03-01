% The full u data set, 100000 ratings by 943 users on 1682 items.
% user id | item id | rating | timestamp
% u is the matrix 100000x4
load ./ml-100k/u.data;
addpath ./nmfv1_4;

Rmat = zeros(943,1682);
for i=1:length(u)
    Rmat(u(i,1),u(i,2)) = u(i,3);
end
% set  weight matrix
w = zeros(943,1682);
w(find(Rmat > 0)) = 1;

tempRmat = Rmat;
tempRmat(find(Rmat == 0)) = NaN;
k = [10,50,100];

% LSE : Least Square Error
LSE = zeros(length(k),1);
finalResidual = zeros(length(k),1);
for i=1:length(k)
    [U,V,numIter,tElapsed,finalResidual(i)] = wnmfrule(tempRmat,k(i));
end