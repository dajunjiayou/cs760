%%
% Define the file paths and parameters
data_folder = 'A:\学习\Madison\ECE760 Machine Learning\HW4\languageID'; % Update with the path to the extracted dataset folder
alpha = 0.5;

% Initialize data structures
class_counts = containers.Map;
feature_counts = containers.Map;
vocab = containers.Map;

% Function to preprocess the text data
preprocess_text = @(text) lower(text);

% Read and process the training data
files = dir(fullfile(data_folder, '*.txt'));
for i = 1:length(files)
    filename = files(i).name;
    fullpath = fullfile(data_folder, filename);
    fileID = fopen(fullpath, 'r','n', 'utf-8');
    text = preprocess_text(fscanf(fileID, '%c'));
    fclose(fileID);
    label = filename(1);

    if ~isKey(class_counts, label)
        class_counts(label) = alpha;
        feature_counts(label) = containers.Map;
    end

    class_counts(label) = class_counts(label) + 1;

    for j = 1:length(text)
        char = text(j);
        if ~isKey(feature_counts(label), char)
            feature_counts2=feature_counts(label);
            feature_counts2(char) = alpha;
            feature_counts(label)=feature_counts2;
            vocab(char) = true;
        end
        feature_counts3=feature_counts(label);
        feature_counts3(char) = feature_counts3(char)+1;
        feature_counts(label) = feature_counts3;
    end
end

% Calculate priors
total_count = sum(cell2mat(values(class_counts)));
priors = containers.Map;
for key = keys(class_counts)
    label = key{1};
    priors(label) = class_counts(label) / total_count;
end

% Display priors
disp('Prior Probabilities:');
for key = keys(priors)
    label = key{1};
    fprintf('p(y=%s) = %.4f\n', label, priors(label));
end

%%%  


%%

% Initialize the parameter vector for English
theta_e = zeros(1, 27);
chart=['abcdefghijklmnopqrstuvwxyz',' '];
% Calculate class conditional probabilities using additive smoothing
for i = 1:27
    char = chart(0 + i);  % Convert index to character (a-z, space)
    if isKey(feature_counts('e'), char)
        feature_counts4=feature_counts('e');
        numerator = feature_counts4(char) + alpha;
    else
        numerator = alpha;
    end
    denominator = sum(cell2mat(values(feature_counts('e')))) + alpha * length(vocab);
    theta_e(i) = numerator / denominator;
end

% Display the estimated parameters for English
disp('Estimated Class Conditional Probability (English):');
disp(theta_e);

%%

theta_j = zeros(1, 27);
% Calculate class conditional probabilities using additive smoothing
for i = 1:27
    char = chart(0 + i);  % Convert index to character (a-z, space)
    if isKey(feature_counts('j'), char)
        feature_counts4=feature_counts('j');
        numerator = feature_counts4(char) + alpha;
    else
        numerator = alpha;
    end
    denominator = sum(cell2mat(values(feature_counts('j')))) + alpha * length(vocab);
    theta_j(i) = numerator / denominator;
end

% Display the estimated parameters for English
disp('Estimated Class Conditional Probability (Japanese):');
disp(theta_j);



theta_s = zeros(1, 27);
chart=['abcdefghijklmnopqrstuvwxyz',' '];
% Calculate class conditional probabilities using additive smoothing
for i = 1:27
    char = chart(0 + i);  % Convert index to character (a-z, space)
    if isKey(feature_counts('s'), char)
        feature_counts4=feature_counts('s');
        numerator = feature_counts4(char) + alpha;
    else
        numerator = alpha;
    end
    denominator = sum(cell2mat(values(feature_counts('s')))) + alpha * length(vocab);
    theta_s(i) = numerator / denominator;
end

% Display the estimated parameters for English
disp('Estimated Class Conditional Probability (Spanish):');
disp(theta_s);

%%

% Define the file path for the test document
test_file = 'A:\学习\Madison\ECE760 Machine Learning\HW4\languageID\j14.txt'; % Update with the path to the test document

% Initialize the bag-of-words count vector for the test document
x = zeros(1, 27);

% Function to preprocess the text data
preprocess_text = @(text) lower(text);

% Read and preprocess the test document
fileID = fopen(test_file, 'r','n', 'utf-8');
text = preprocess_text(fscanf(fileID, '%c'));
fclose(fileID);

% Count the occurrences of each character in the text
for j = 1:length(text)
    char = text(j);
    if char == ' '
        char_idx = 27; % Index 27 corresponds to space
        x(char_idx) = x(char_idx) + 1;
    else
        char_idx = double(char) - 96; % Convert character to index (a-z)
        if char_idx<27 & char_idx>0 
                x(char_idx) = x(char_idx) + 1;
        end
    end
%     x(char_idx) = x(char_idx) + 1;
end

% Display the bag-of-words count vector for the test document
disp('Bag-of-Words Count Vector for e10.txt:');
disp(x);



%%

% Define the class-conditional probabilities for English, Japanese, and Spanish
theta_e = theta_e; % Assign the values computed earlier
theta_j = theta_j; % Assign the values for Japanese (if available)
theta_s = theta_s; % Assign the values for Spanish (if available)


% for k=1:27
%     
% 
% xi=feature_counts(label)
% 

x01=(x/sum(x));
% Compute p(x | y) for y = e, j, s
p_x_given_e = prod(theta_e .^ x01);
p_x_given_j = prod(theta_j .^ x01);
p_x_given_s = prod(theta_s .^ x01);

% Display the values
disp('Estimated p(x | y = e):');
disp(p_x_given_e);

disp('Estimated p(x | y = j):');
disp(p_x_given_j);

disp('Estimated p(x | y = s):');
disp(p_x_given_s);

%%
% Compute the evidence (sum of the products of likelihood and prior over all classes)
evidence = p_x_given_e * priors('e') + p_x_given_j * priors('j') + p_x_given_s * priors('s');

% Compute the posterior p(y | x) for y = e, j, s
p_y_given_x_e = (p_x_given_e * priors('e')) / evidence;
p_y_given_x_j = (p_x_given_j * priors('j')) / evidence;
p_y_given_x_s = (p_x_given_s * priors('s')) / evidence;

% Display the values of p(y | x) for y = e, j, s
disp('Estimated p(y = e | x):');
disp(p_y_given_x_e);

disp('Estimated p(y = j | x):');
disp(p_y_given_x_j);

disp('Estimated p(y = s | x):');
disp(p_y_given_x_s);

% Predict the class label of x
[~, predicted_label] = max([p_y_given_x_e, p_y_given_x_j, p_y_given_x_s]);
classes = ['e', 'j', 's'];
predicted_class_label = classes(predicted_label);
disp('Predicted class label of x:');
disp(predicted_class_label);

%%



