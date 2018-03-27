function [C, sigma] = dataset3Params(X, y, Xval, yval)

C = 1;sigma = 0.3;

C_val = [0.01 0.03 0.1 0.3 1 3 10 30];
sigma_val = [0.01 0.03 0.1 0.3 1 3 10 30];
for i = 1:8
    for j = 1:8
	
	C = C_val(i);sigma = sigma_val(j);
	model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
	predictions = svmPredict(model , Xval);
	prediction_error(i,j) = mean(double(predictions ~= yval));
	
	
	end
	
end
minerr = min(min(prediction_error));
[i,j] = find(prediction_error == minerr);
C = C_val(i);sigma = sigma_val(j);


end
