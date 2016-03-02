load ./ml-100k/u.data;
addpath ./nmfv1_4;

Rmat = zeros(943,1682);
w = zeros(943,1682);
for i=1:100000
    Rmat(u(i,1),u(i,2)) = u(i,3);
end

%set weight matrix
w(find(Rmat > 0)) = 1;

% Randomize 1 to 100000
random_vector = randperm(100000);

% 10 rows and 10000 columns. Total 3 matrix
k = [10,50,100];
errL = zeros(10,10000,length(k));
errV = zeros(10,length(k));

option = struct();
option.dis = false;
for itr=1:length(k)
    for k_cross_validate = 1:10
        tmp = Rmat;
        for vector_index = 1:10000
            random_index_vector = random_vector(vector_index+(k_cross_validate-1)*10000);
            tmp(u(random_index_vector,1),u(random_index_vector,2)) = NaN;
        end

        [U,V] = wnmfrule(tmp,k(itr),option);
        UV = U*V;
        test_ind = 1;
        error = 0;
        for vector_index = 1:10000
            random_index_vector = random_vector(vector_index+(k_cross_validate-1)*10000);
            errL(k_cross_validate,test_ind,itr) = abs(Rmat(u(random_index_vector,1),u(random_index_vector,2)) - UV(u(random_index_vector,1),u(random_index_vector,2)));
            error = error+abs(Rmat(u(random_index_vector,1),u(random_index_vector,2)) - UV(i,j));
            test_ind = test_ind + 1;
        end
        error_average = error/10000;
        errV(k_cross_validate, itr) = error_average;
    end
end

mean_err = mean(mean(errL,2),1);
for itr=1:length(k)
    ['Error for training using part 1 for k = ' num2str(k(itr)) ' is ' num2str(mean_err(1,1,itr))]
end
