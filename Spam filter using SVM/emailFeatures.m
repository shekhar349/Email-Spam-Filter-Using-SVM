function x = emailFeatures(word_indices)

n = 1899;

x = zeros(n, 1);


    for iter = 1 : length(word_indices)
    x(word_indices(iter))=1;
	end	
    

end
