load ./ml-100k/u.data;
addpath ./nmfv1_4;

Rmat = zeros(943,1682);
for i=1:100000
    Rmat(u(i,1),u(i,2)) = u(i,3);
end

Wmat = zeros(943,1682);
Wmat(find(Rmat > 0)) = 1;

% First part
% In the First part, we need to swap the value between Rmat and Wmat. This has been down in wnmfrule_modified_part4_1.m.

tempRmat = Rmat;
tempRmat(find(Rmat == 0)) = nan;

option = struct();
option.dis = false;

k = [10,50,100];
LSE = zeros(length(k),1);
LSE2 = zeros(length(k),1);
finalResidual = zeros(length(k),1);

for itr=1:length(k)

    [U,V,numIter,tElapsed,finalResidual(itr)] = wnmfrule_modified_part4_1(tempRmat,k(itr),option);
    UV = U*V;

    LSE(itr) = sqrt(sum(sum((Rmat .* (Wmat - UV)).^2)))
    LSE2(itr) = sqrt(sum(sum(Rmat .* (Wmat - UV).^2)))

end

% Second part

[num_user num_movie] = size(Rmat);

lambda = [0.01,0.1,1];

option.dis = true;

err = zeros(length(k),length(lambda));

Rmat_2 = Rmat;
Rmat_2(find(Rmat == 0)) = nan;
Wmat_2 = Wmat;

err_2 = zeros(length(k),length(lambda));

for lb = 1:length(lambda)

    for itr=1:length(k)

        [U,V] = wnmfrule_modified_part4_2(Rmat_2,k(itr),lambda(lb),option);
        UV = U*V;

        err(itr,lb) = sqrt(sum(sum((Wmat .* (Rmat - UV)).^2)));
    end

    % Third part

    for itr=1:length(k)

        [U,V] = wnmfrule_modified_part4_3(Rmat_2,k(itr),lambda(lb),option);
        UV = U*V;

        err_2(itr,lb) = sqrt(sum(sum(Rmat .* (Wmat - UV).^2)));
    end
end
