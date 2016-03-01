load ./ml-100k/u.data;
addpath ./nmfv1_4;

Rmat = zeros(943,1682);
for i=1:100000
    Rmat(u(i,1),u(i,2)) = u(i,3);
end
%set weight matrix
w = zeros(943,1682);
w(find(Rmat > 0)) = 1;

option = struct();
option.dis = false;

% Randomize 1 to 100000
random_vector = randperm(100000);
start_index = [1,10001,20001,30001,40001,50001,60001,70001,80001,90001];

% 10 rows and 10000 columns. Total 3 matrix
errL = zeros(10,10000,3);
k = [10,50,100];

for itr=1:length(k)
    for k_cross_validate = 1:10
        tmp = Rmat;

        for index_vector = start_index(k_cross_validate):start_index(k_cross_validate)+10000-1
            random_index_vector = random_vector(index_vector);
            tmp(u(random_index_vector,1),u(random_index_vector,2)) = nan;
        end

        [U_1,V_1] = wnmfrule(tmp,k(itr),option);
        UV_1 = U_1*V_1;
        test_ind = 1;
        for index_vector = start_index(k_cross_validate):start_index(k_cross_validate)+10000-1
            random_index_vector = random_vector(index_vector);
            i = u(random_index_vector,1);
            j = u(random_index_vector,2);
            errL(k_cross_validate,test_ind,itr) = abs(Rmat(i,j) - UV_1(i,j));
            test_ind = test_ind + 1;
        end
    end

end

mean_err = mean(mean(errL,2),1);
for itr=1:length(k)
    ['Error for training using part 1 for k = ' num2str(k(itr)) ' is ' num2str(mean_err(1,1,itr))]
end
