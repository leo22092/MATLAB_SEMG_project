data = readtable('IRIS.csv');
X = data(:, 1:end-1);  % Features
y = data(:, end);   % Labels

X = normalize(X);


% Split data into training and testing sets
rng(42);  % Set seed for reproducibility
split_ratio = 0.8;  % 80% training, 20% testing
idx = randperm(size(X, 1));
X_train = X(idx(1:round(split_ratio * end)), :);
y_train = y(idx(1:round(split_ratio * end)));

X_test = X(idx(round(split_ratio * end) + 1:end), :);
y_test = y(idx(round(split_ratio * end) + 1:end));
