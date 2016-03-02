load ./ml-100k/u.data;
addpath ./nmfv1_4;

num_per_vali = 10000;
Rmat = zeros(943,1682);
%w = zeros(943,1682);
for i=1:100000
    Rmat(u(i,1),u(i,2)) = u(i,3);
end

%w(find(Rmat > 0)) = 1;

option = struct();
option.dis = false;

% Randomize 1 to 100000
random_vector = randperm(100000);

precision = zeros(10,24,3);
recall = zeros(10,24,3);

Rmat_thresholded = Rmat;
Rmat_thresholded(find(Rmat <= 3)) = -1;
Rmat_thresholded(find(Rmat > 3)) = 1;

% 10 rows and 10000 columns. Total 3 matrix
k = [10,50,100];

for itr=1:length(k)
    for k_cross_validate = 1:10
        tmp = Rmat;
        for vector_index = 1:num_per_vali
            random_index_vector = random_vector(vector_index+(k_cross_validate-1)*num_per_vali);
            tmp(u(random_index_vector,1),u(random_index_vector,2)) = nan;
        end

        [U,V] = wnmfrule(tmp,k(itr),option);
        UV = U*V;

        th = 1;
        for index_threshold = 0.2:0.2:4.8
            UV_1_thresholded = UV;
            UV_1_thresholded(find(UV <= index_threshold)) = -1;
            UV_1_thresholded(find(UV > index_threshold)) = 1;

            gt = [];
            dt = [];
            for vector_index = 1:num_per_vali
                random_index_vector = random_vector(vector_index+(k_cross_validate-1)*num_per_vali);
                i = u(random_index_vector,1);
                j = u(random_index_vector,2);
                gt = [gt Rmat_thresholded(i,j)];
                dt = [dt UV_1_thresholded(i,j)];
            end

            temp1 = dt-gt;
            temp2 = dt+gt;
            tp = length(find(temp2 == 2));
            tn = length(find(temp2 == -2));
            fp = length(find(temp1 == 2));
            fn = length(find(temp1 == -2));

            precision(k_cross_validate,th,itr) = tp/(tp+fp);
            recall(k_cross_validate,th,itr) = tp/(tp+fn);
            th = th+1;

        end

    end
end
mean_precision = mean(precision,1);
mean_recall = mean(recall,1);
save('part3_full.mat');
