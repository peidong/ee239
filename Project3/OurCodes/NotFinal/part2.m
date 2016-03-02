load ./ml-100k/u.data;
addpath ./nmfv1_4;

num_per_vali = 10000;
Rmat = zeros(943,1682);
w = zeros(943,1682);
errV = zeros(10,length(k));
for i=1:100000
    Rmat(u(i,1),u(i,2)) = u(i,3);
end

%set weight matrix
w(find(Rmat > 0)) = 1;

% Randomize 1 to 100000
random_vector = randperm(100000);

% 10 rows and 10000 columns. Total 3 matrix
k = [10,50,100];

option = struct();
option.dis = false;
for itr=1:length(k)
    for k_cross_validate = 1:10
        tmp = Rmat;
        for vector_index = 1:num_per_vali
            random_index_vector = random_vector(vector_index+(k_cross_validate-1)*num_per_vali);
            tmp(u(random_index_vector,1),u(random_index_vector,2)) = NaN;
        end

        [U,V] = wnmfrule(tmp,k(itr),option);
        UV = U*V;
        error = 0;
        for vector_index = 1:num_per_vali
            random_index_vector = random_vector(vector_index+(k_cross_validate-1)*num_per_vali);
            error = error+abs(Rmat(u(random_index_vector,1),u(random_index_vector,2)) - UV(u(random_index_vector,1),u(random_index_vector,2)));
        end
        error_average = error/num_per_vali;
        errV(k_cross_validate, itr) = error_average;
    end
end
err_per_k = mean(errV,2);
