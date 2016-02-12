importfile_neural('neuralOutput_whole.csv');
min_nodes = min(data(:,1));
max_nodes = max(data(:,1));
min_layers = min(data(:,2));
max_layers = max(data(:,2));

result = [];

for i = 1:length(data)
	result(data(i,1),data(i,2)) = data(i,3);
end

surf(result);figure(gcf)