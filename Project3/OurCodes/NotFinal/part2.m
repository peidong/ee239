load ./ml-100k/u.data;
addpath ./nmfv1_4;

Rmat = zeros(943,1682);
for i=1:100000
    Rmat(u(i,1),u(i,2)) = u(i,3);
end

Wmat = zeros(943,1682);
Wmat(find(Rmat > 0)) = 1;

option = struct();
option.dis = false;

% Randomize 1 to 100000
random_vector = randperm(100000);
start_index = [1,10001,20001,30001,40001,50001,60001,70001,80001,90001];

% 10 rows and 10000 columns. Total 3 matrix
err_part1 = zeros(10,10000,3);
err_part2 = zeros(10,10000,3);

k = [10,50,100];

for itr=1:length(k)

    for k_cross_validate = 1:10

        Rmat_part2 = Rmat;
        Rmat_part1 = Rmat;

        for index_vector = start_index(k_cross_validate):start_index(k_cross_validate)+10000-1
            random_index_vector = random_vector(index_vector);
            Rmat_part2(u(random_index_vector,1),u(random_index_vector,2)) = nan;
            Rmat_part1(u(random_index_vector,1),u(random_index_vector,2)) = nan;
        end

        [U_1,V_1] = wnmfrule(Rmat_part1,k(itr),option);
        UV_1 = U_1*V_1;

        test_ind = 1;
        for index_vector = start_index(k_cross_validate):start_index(k_cross_validate)+10000-1
            random_index_vector = random_vector(index_vector);
            i = u(random_index_vector,1);
            j = u(random_index_vector,2);
            err_part1(k_cross_validate,test_ind,itr) = abs(Rmat(i,j) - UV_1(i,j));
            test_ind = test_ind + 1;
        end

        [U_2,V_2] = wnmfrule_modified_part2(Rmat_part2,k(itr),option);
        UV_2 = U_2*V_2;

        test_ind = 1;
        for index_vector = start_index(k_cross_validate):start_index(k_cross_validate)+10000-1
            random_index_vector = random_vector(index_vector);
            i = u(random_index_vector,1);
            j = u(random_index_vector,2);
            err_part2(k_cross_validate,test_ind,itr) = abs(Wmat(i,j) - UV_2(i,j));
            test_ind = test_ind + 1;
        end

    end

end

mean_err_part_1 = mean(mean(err_part1,2),1);
mean_err_part_2 = mean(mean(err_part2,2),1);

for itr=1:length(k)
    ['Error for training using part 1 for k = ' num2str(k(itr)) ' is ' num2str(mean_err_part_1(1,1,itr))]
end

for itr=1:length(k)
    ['Error for training using part 2 for k = ' num2str(k(itr)) ' is ' num2str(mean_err_part_2(1,1,itr))]
end
