%% MLP Flood Risk Regression Model
%
% This script trains a multi-output MLP regression model to predict:
%  - Flood duration (duration_max, integer >= 0)
%  - Flood depth (RP100_depth, >= 0)
%
% Inputs (CSV columns):
%  - Column 3: Ground elevation (dtm)
%  - Column 4: Annual rainfall (mm)
%  - Column 5: Soil moisture (0–10 cm)
%
% Outputs (CSV columns):
%  - Column 6: Flood duration
%  - Column 7: Flood depth
%
% The workflow includes:
%  - Data cleaning
%  - Normalisation
%  - Train / validation / test split
%  - Post-processing constraints for physical realism
%

%% Clean previous run records
clearvars;              % Clear workspace variables
clc;                    % Clear command window
close all;              % Close all figure windows
bdclose('all');         % Close all Simulink models (safe even if unused)
clear functions;        % Clear loaded functions (avoid cached issues)
clear classes;          % Clear loaded classes
rehash toolboxcache;    % Refresh toolbox cache (optional but helpful)

%% 0) Input file
file = "BD.csv";
if ~isfile(file)
    error("File not found: %s (place the CSV in the working directory or update the path)", file);
end

%% 1) Read numeric matrix directly (avoid table-related issues)
A = readmatrix(file);

if isempty(A) || ~isnumeric(A)
    error("readmatrix did not return a numeric matrix. Please check that the first 7 columns are numeric.");
end
if size(A,2) < 7
    error("Insufficient columns: expected at least 7, but found %d.", size(A,2));
end

%% 2) Extract inputs (X) and outputs (Y) by fixed column index
X = A(:, 3:5);   % dtm, rainfall, soil moisture
Y = A(:, 6:7);   % duration_max, RP100_depth

% Remove rows containing NaN or Inf values
bad = any(~isfinite(X),2) | any(~isfinite(Y),2);
X = X(~bad,:);
Y = Y(~bad,:);

if size(X,1) < 10
    error("Too few valid samples (<10). Please check for excessive missing or invalid values.");
end

% Neural Network Toolbox convention: [features x samples]
X = X';
Y = Y';

%% 3) Normalisation (min-max scaling)
[Xn, psX] = mapminmax(X);
[Yn, psY] = mapminmax(Y);

%% 4) Build and train the MLP model
hiddenSizes = [30 20 10];          % Hidden layer configuration
net = fitnet(hiddenSizes, "trainlm");  % Levenberg–Marquardt training
% Alternative: "trainbr" for better regularisation

% Data split
net.divideParam.trainRatio = 0.70;
net.divideParam.valRatio   = 0.15;
net.divideParam.testRatio  = 0.15;

% Training parameters
net.trainParam.epochs   = 8000;    % Maximum number of training epochs
net.trainParam.max_fail = 50;      % Early stopping patience
net.trainParam.goal     = 1e-8;    % Performance goal (optional)

[net, tr] = train(net, Xn, Yn);

%% 5) Model evaluation on test set (with output constraints)
Yhat_n = net(Xn);
Yhat   = mapminmax("reverse", Yhat_n, psY);

testInd = tr.testInd;
Y_test  = Y(:,_
