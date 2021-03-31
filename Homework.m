%% HOMEWORK
%% Data loading
load('Trainnumbers.mat')
%% Digit extraction and number representation
N = 28;
k = 3;
digit = zeros(N);
for m = 1:N
    for j = 1:N
        digit(m,j) = Trainnumbers.image((m-1)*N+j,k);
    end
end
number = Trainnumbers.label(k);
imshow(digit)
title(strcat('Number:',int2str(number)))
%% Extraction of a sample for data normalization
% Number of samples we extract from the same digit
num = 2;
% Extraction
n = 0:1:9;
cont = 0;
ind = 1;
n_medvar = zeros(1,num*10);
for i = 1:10
    for j = 1:length(Trainnumbers.label)
        if(Trainnumbers.label(j) == n(i))
            n_medvar(ind) = j;
            ind = ind + 1;
            cont = cont + 1;
            if cont == num
                cont = 0;
                break
            end
        end
    end
end
%% TASK 1 - Viability of PCA for reducing the dimensionality and further reconstruction
% Quantify the reconstruction MSE versus the number of dimensionality of
% the reduced data and display the reconstructed images.

% Mean and variance calculation
mean_digits = zeros(1,num*10);
std_digits = zeros(1,num*10);
for i = 1:num*10
    k = n_medvar(i);
    digit = zeros(N);
    for m = 1:N
        for j = 1:N
            digit(m,j) = Trainnumbers.image((m-1)*N+j,k);
        end
    end
    mean_digits(i) = mean(mean(digit)); % Muchas columnas con solo ceros, ¿recortar?
    std_digits(i) = mean(std(digit)); % mean or std
end
mean_data = mean(mean_digits);
std_data = std(std_digits);
% Data normalization
for i = 1:num*10 % Números usados
	% ¿Números para entrenamiento o todos?
    % Guardado de los números
    for m = 1:N
        for j = 1:N
            digit(m,j) = (Trainnumbers.image((m-1)*N+j,k) - mean_data)/std_data;
        end
    end
end
% Mean squared error
% MSE = N*immse(); % Mejor 
%% TASK 2 - Using k-NN
%% TASK 3 - Using Bayesian Classifiers
%% TASK 4 - Using MLP
%% TASK 5 - Using SOM
%% Optional tasks for obtaining top marks above 7
%% TASK 6 - Use Linear Fischer Discriminant for reducing the dimensionality
%% TASK 7 - Use K-means for clustering the images
%% TASK 8 - Use Autoencoder for dimensionality reduction (first reduce with PCA to an intermediate reduction level)
% Compare the results with task 1
%% TASK 9 - Build a visual map using SOM where the pattern image is at the position of every neuron in the 2D map
%% TASK 10 (NOTE)
% Please highlight any original improvement or combination of the above
% mentioned techniques that you have tried in order to improve the results