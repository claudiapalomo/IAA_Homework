%% HOMEWORK
%% Data loading
load('Trainnumbers.mat')
%% Digit extraction and number representation
N = 28;
k = 3;
digit = zeros(N);
for m = 1:28
    for j = 1:28
        digit(m,j) = Trainnumbers.image((m-1)*28+j,k);
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
%% TASK 1 Procedure
% Mean and variance calculation
mean_digits = zeros(1,num*10);
std_digits = zeros(1,num*10);
for i = 1:20
    k = n_training(i);
    digit = zeros(28);
    for m = 1:28
        for j = 1:28
            digit(m,j) = Trainnumbers.image((m-1)*28+j,k);
        end
    end
    mean_digits(i) = mean(mean(digit)); % Muchas columnas con solo ceros, ¿recortar?
    std_digits(i) = std(std(digit)); % mean or std
end
mean_data = mean(mean_digits);
std_data = std(std_digits);
% Data normalization