% DRIVER FUNCTION
clear ; close all; clc

%% ==================== Part 1: Email Preprocessing ====================

fprintf('\nPreprocessing sample email (sample.txt)\n');

% Extract Features
file_contents = readFile('sample.txt');
word_indices  = processEmail(file_contents);

% Print Stats
fprintf('Word Indices: \n');
fprintf(' %d', word_indices);
fprintf('\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

% ==================== Part 2: Feature Extraction ====================

fprintf('\nExtracting features from sample email (sample.txt)\n');

% Extract Features
file_contents = readFile('sample.txt');
word_indices  = processEmail(file_contents);
features      = emailFeatures(word_indices);

% Print Stats
fprintf('Length of feature vector: %d\n', length(features));
fprintf('Number of non-zero entries: %d\n', sum(features > 0));

fprintf('Program paused. Press enter to continue.\n');
pause;

% =========== Part 3: Train Linear SVM for Spam Classification ========

load('spamTrain.mat');


fprintf('\nTraining Gaussian SVM (Spam Classification)\n')
fprintf('(this may take 1 to 2 minutes) ...\n')

C=3;sigma=3;
model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));


p = svmPredict(model, X);

fprintf('Training Accuracy: %f\n', mean(double(p == y)) * 100);

% =================== Part 4: Test Spam Classification ================

load('spamTest.mat');

fprintf('\nEvaluating the trained gaussian SVM on a test set ...\n')

p = svmPredict(model, Xtest);

fprintf('Test Accuracy: %f\n', mean(double(p == ytest)) * 100);
pause;


% ================= Part 5: Top Predictors of Spam ====================

[weight, idx] = sort(model.w, 'descend');
vocabList = getVocabList();

fprintf('\nTop predictors of spam: \n');
for i = 1:15
    fprintf(' %-15s (%f) \n', vocabList{idx(i)}, weight(i));
end

fprintf('\n\n');
fprintf('\nProgram paused. Press enter to continue.\n');
pause;

% =================== Part 6: Try Sampple Emails =====================

filename = 'sample.txt';

% Read and predict
file_contents = readFile(filename);
word_indices  = processEmail(file_contents);
x             = emailFeatures(word_indices);
p = svmPredict(model, x);

fprintf('\nProcessed %s\n\nSpam Classification: %d\n', filename, p);
fprintf('(1 indicates spam, 0 indicates not spam)\n\n');

