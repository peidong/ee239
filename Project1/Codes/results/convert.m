importfile('depth4to64-ntree20to40-randomForestoutput.csv');
min_ntree = min(data(:,1));
max_ntree = max(data(:,1));
min_depth = min(data(:,2));
max_depth = max(data(:,2));

result = [];

for i = 1:length(data)
	result(data(i,1),data(i,2)) = data(i,3);
end

surf(result);figure(gcf)