clear all

dataruns = xlsread('emails.csv');

dataruns2=dataruns(2:end,:);

num=dataruns2(:,1:3000);
label=dataruns2(:,end);

%% exp1



num=dataruns2(1001:5000,1:end-1);
label=dataruns2(1001:5000,end);


testnum=dataruns2(1:1000,1:end-1);
testlabel=dataruns2(1:1000,end);

Mdl=KDTreeSearcher(num);

[n,d]=knnsearch(Mdl,testnum,'k',5);


testresult=(sum(label(n),2)/5);

ratiosss=testresult./testlabel;
TP=sum(ratiosss(find(ratiosss==1)));
FP=sum(testlabel)-TP;

ratioaaa=testresult+testlabel;
TN=size(ratioaaa(find(ratioaaa==0)),1);
FN=sum(1-testlabel)-TN;

recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);



% Compute the ROC curve
[fpr1, tpr1, thresholds] = perfcurve(testlabel,testresult, 1);

% Plot the ROC curve
figure;
plot(fpr, tpr);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve');
grid on;



%%


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
   
    
% Compute the ROC curve
[fpr2, tpr2, thresholds] = perfcurve(testlabel, predictions, 1);

% Plot the ROC curve
figure;
plot(fpr2, tpr2);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve');
grid on;


%%

figure;
plot(fpr1, tpr1,'r', fpr2, tpr2,'b');
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve');
grid on;
legend('5NN', 'regression')

