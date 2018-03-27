function vocabList = getVocabList()

fid = fopen('vocab.txt');

n = 1899;  

vocabList = cell(n, 1);
for i = 1:n
    
    fscanf(fid, '%d', 1);
    
    vocabList{i} = fscanf(fid, '%s', 1);
end
fclose(fid);

end
