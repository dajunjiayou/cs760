clear all

dataruns = xlsread('emails.csv');

dataruns2=dataruns(2:end,:);

num=dataruns2(:,1:end-1);
label=dataruns2(:,end);

%% exp1


num=dataruns2(1001:5000,1:end-1);
label=dataruns2(1001:5000,end);


testnum=dataruns2(1:1000,1:end-1);
testlabel=dataruns2(1:1000,end);

X_train=num;
y_train=label;


% features (X) and labels (y)
 
    % Define your logistic regression model
    % You can adjust the learning rate and other hyperparameters as needed
    theta = zeros(size(X_train, 2), 1); % Initialize parameters
    
    % Set hyperparameters
    learning_rate = 0.1;
    num_iterations = 1000;
    
    % Implement gradient descent to find optimal parameters
    for iteration = 1:num_iterations
        % Calculate predictions
        predictions =  1 ./ (1 + exp(-X_train * theta));
        
%         sigmoid(X_train * theta);  1 ./ (1 + exp(-x));

        % Calculate gradient
        gradient = X_train' * (predictions - y_train) / length(y_train);
        
        % Update parameters using gradient descent
        theta = theta - learning_rate * gradient;
    end

   predictions =  1 ./ (1 + exp(-testnum * theta));
   
    
    % Calculate evaluation metrics
    TP = sum(predictions >= 0.5 & testlabel == 1);
    FP = sum(predictions >= 0.5 & testlabel == 0);
    TN = sum(predictions < 0.5 & testlabel == 0);
    FN = sum(predictions < 0.5 & testlabel == 1);


recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);

%% exp2

num=dataruns2([1:1000,2001:5000],1:end-1);
label=dataruns2([1:1000,2001:5000],end);


testnum=dataruns2(1001:2000,1:end-1);
testlabel=dataruns2(1001:2000,end);


X_train=num;
y_train=label;


% features (X) and labels (y)
 
    % Define your logistic regression model
    % You can adjust the learning rate and other hyperparameters as needed
    theta = zeros(size(X_train, 2), 1); % Initialize parameters
    
    % Set hyperparameters
    learning_rate = 0.1;
    num_iterations = 1000;
    
    % Implement gradient descent to find optimal parameters
    for iteration = 1:num_iterations
        % Calculate predictions
        predictions =  1 ./ (1 + exp(-X_train * theta));
        
%         sigmoid(X_train * theta);  1 ./ (1 + exp(-x));

        % Calculate gradient
        gradient = X_train' * (predictions - y_train) / length(y_train);
        
        % Update parameters using gradient descent
        theta = theta - learning_rate * gradient;
    end

   predictions =  1 ./ (1 + exp(-testnum * theta));
   
    
    % Calculate evaluation metrics
    TP = sum(predictions >= 0.5 & testlabel == 1);
    FP = sum(predictions >= 0.5 & testlabel == 0);
    TN = sum(predictions < 0.5 & testlabel == 0);
    FN = sum(predictions < 0.5 & testlabel == 1);


recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);


%% exp3

num=dataruns2([1:2000,3001:5000],1:end-1);
label=dataruns2([1:2000,3001:5000],end);


testnum=dataruns2(2001:3000,1:end-1);
testlabel=dataruns2(2001:3000,end);



X_train=num;
y_train=label;


% features (X) and labels (y)
 
    % Define your logistic regression model
    % You can adjust the learning rate and other hyperparameters as needed
    theta = zeros(size(X_train, 2), 1); % Initialize parameters
    
    % Set hyperparameters
    learning_rate = 0.1;
    num_iterations = 1000;
    
    % Implement gradient descent to find optimal parameters
    for iteration = 1:num_iterations
        % Calculate predictions
        predictions =  1 ./ (1 + exp(-X_train * theta));
        
%         sigmoid(X_train * theta);  1 ./ (1 + exp(-x));

        % Calculate gradient
        gradient = X_train' * (predictions - y_train) / length(y_train);
        
        % Update parameters using gradient descent
        theta = theta - learning_rate * gradient;
    end

   predictions =  1 ./ (1 + exp(-testnum * theta));
   
    
    % Calculate evaluation metrics
    TP = sum(predictions >= 0.5 & testlabel == 1);
    FP = sum(predictions >= 0.5 & testlabel == 0);
    TN = sum(predictions < 0.5 & testlabel == 0);
    FN = sum(predictions < 0.5 & testlabel == 1);


recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);


%% exp4

num=dataruns2([1:3000,4001:5000],1:end-1);
label=dataruns2([1:3000,4001:5000],end);


testnum=dataruns2(3001:4000,1:end-1);
testlabel=dataruns2(3001:4000,end);



X_train=num;
y_train=label;


% features (X) and labels (y)
 
    % Define your logistic regression model
    % You can adjust the learning rate and other hyperparameters as needed
    theta = zeros(size(X_train, 2), 1); % Initialize parameters
    
    % Set hyperparameters
    learning_rate = 0.1;
    num_iterations = 1000;
    
    % Implement gradient descent to find optimal parameters
    for iteration = 1:num_iterations
        % Calculate predictions
        predictions =  1 ./ (1 + exp(-X_train * theta));
        
%         sigmoid(X_train * theta);  1 ./ (1 + exp(-x));

        % Calculate gradient
        gradient = X_train' * (predictions - y_train) / length(y_train);
        
        % Update parameters using gradient descent
        theta = theta - learning_rate * gradient;
    end

   predictions =  1 ./ (1 + exp(-testnum * theta));
   
    
    % Calculate evaluation metrics
    TP = sum(predictions >= 0.5 & testlabel == 1);
    FP = sum(predictions >= 0.5 & testlabel == 0);
    TN = sum(predictions < 0.5 & testlabel == 0);
    FN = sum(predictions < 0.5 & testlabel == 1);


recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);

%% exp5

num=dataruns2([1:4000],1:end-1);
label=dataruns2([1:4000],end);


testnum=dataruns2(4001:5000,1:end-1);
testlabel=dataruns2(4001:5000,end);



X_train=num;
y_train=label;


% features (X) and labels (y)
 
    % Define your logistic regression model
    % You can adjust the learning rate and other hyperparameters as needed
    theta = zeros(size(X_train, 2), 1); % Initialize parameters
    
    % Set hyperparameters
    learning_rate = 0.1;
    num_iterations = 1000;
    
    % Implement gradient descent to find optimal parameters
    for iteration = 1:num_iterations
        % Calculate predictions
        predictions =  1 ./ (1 + exp(-X_train * theta));
        
%         sigmoid(X_train * theta);  1 ./ (1 + exp(-x));

        % Calculate gradient
        gradient = X_train' * (predictions - y_train) / length(y_train);
        
        % Update parameters using gradient descent
        theta = theta - learning_rate * gradient;
    end

   predictions =  1 ./ (1 + exp(-testnum * theta));
   
    
    % Calculate evaluation metrics
    TP = sum(predictions >= 0.5 & testlabel == 1);
    FP = sum(predictions >= 0.5 & testlabel == 0);
    TN = sum(predictions < 0.5 & testlabel == 0);
    FN = sum(predictions < 0.5 & testlabel == 1);


recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);



