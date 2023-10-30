
clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% % Parameters
% d = 10; % Dimension of the input
% d1 = 5; % Dimension of the first layer
% k = 3; % Dimension of the output
% 
% % Define the sigmoid and softmax functions
% sigmoid = @(z) 1./(1 + exp(-z));
% softmax = @(z) exp(z) / sum(exp(z));
% 
% % Randomly initialize the weight matrices
% W1 = randn(d1, d); % Initialize as needed
% W2 = randn(k, d1); % Initialize as needed
% 
% % Define the input data
% x = randn(d, 1); % Replace with your input data
% 
% % Forward pass
% z1 = W1 * x;
% a1 = sigmoid(z1);
% z2 = W2 * a1;
% y_hat = softmax(z2);
% 
% % Display the output
% disp('Output:');
% disp(y_hat);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load mnist_uint8;

train_x = double(train_x) / 255;
test_x  = double(test_x)  / 255;
train_y = double(train_y);
test_y  = double(test_y);

mu=mean(train_x);    
sigma=max(std(train_x),eps);
train_x=bsxfun(@minus,train_x,mu);          %每个样本分别减去平均值
train_x=bsxfun(@rdivide,train_x,sigma);     %分别除以标准差

test_x=bsxfun(@minus,test_x,mu);
test_x=bsxfun(@rdivide,test_x,sigma);



arc = [784 100 10]; %输入784，隐含层100,输出10
n=numel(arc);

W = cell(1,n-1);    %权重矩阵

for i=2:n
    W{i-1} = (rand(arc(i),arc(i-1)+1)-0.5) * 8 *sqrt(6 / (arc(i)+arc(i-1)));
end

learningRate = 2;   %训练速度
numepochs = 5;      %训练5遍
batchsize = 100;    %一次训练100个数据

m = size(train_x, 1);       %数据总量
numbatches = m / batchsize;    %一共有numbatches这么多组

% %%
% 
sigmoid = @(z) 1./(1 + exp(-z));
softmax = @(z) exp(z) / sum(exp(z));


%% 训练
L = zeros(numepochs*numbatches,1);
ll=1;
for i = 1 : numepochs
    kk = randperm(m);
    for l = 1 : numbatches
        batch_x = train_x(kk((l - 1) * batchsize + 1 : l * batchsize), :);
        batch_y = train_y(kk((l - 1) * batchsize + 1 : l * batchsize), :);

       %% 正向传播
        mm = size(batch_x,1);
        x = [ones(mm,1) batch_x];
        a{1} = x;
        for ii = 2 : n-1
%             a{ii} = 1.7159*tanh(2/3.*(a{ii - 1} * W{ii - 1}'));   
%             a{ii} =(a{ii - 1} * W{ii - 1}');  
              a{ii} = 1./(1+exp(-(a{ii - 1} * W{ii - 1}')));
              a{ii} = [ones(mm,1) a{ii}];
        end
%                 a{n} = 1./(1+exp(-(a{n - 1} * W{n - 1}')));
        a{n} = exp((a{n - 1} * W{n - 1}'))./sum( exp((a{n - 1} * W{n - 1}')));

        e = batch_y - a{n};   % 差异值
   

        L(ll) = 1/2 * sum(sum(e.^2)) / mm; 

        ll=ll+1;
       %% 反向传播

% X：m*p输入矩阵，m为案例个数，p为加上常数项之后的属性个数
% label：m*1标签向量（数值型）
% lambda：权重衰减参数weight decay parameter
% theta：p*k系数矩阵，k为标签类别数
% cost：总代价函数值
% thetagrad：梯度矩阵
% P：m*k分类概率矩阵，P（i，j）表示第i个样本被判别为第j类的概率

 X= a{2}(:,2:end);
 label=[1:10] ;
theta=a{3};
mm = size(X,1);
lambda= learningRate;

label_extend = [full(sparse(label,1:length(label),1))]';

%  label_extend = [full(sparse(1:length(label),1:length(label),1))]';
% 计算预测概率矩阵
P = zeros(mm,size(label_extend,2));
for smp = 1:mm
    P(smp,:) = exp(X(smp,:)*theta)/sum(exp(X(smp,:)*theta));
end
% 计算代价函数值
cost = -1/m*[label_extend(:,:)]*log(P(:,:)')+lambda/2*sum((theta(:,:).^2)');
% cost = -1/m*[label_extend(:)]*log(P(:)')+lambda/2*sum(theta(:).^2);
% 计算梯度
costnew=[zeros(10,1),cost];

% thetagrad = -1/m*X'*(label_extend-P)+lambda*theta;

        for ii = 1 : n-1
            if ii + 1 == n
                dW{ii} = (d{ii + 1}' * a{ii}) / size(d{ii + 1}, 1);
            else
                dW{ii} = (d{ii + 1}(:,2:end)' * a{ii}) / size(d{ii + 1}, 1);      
            end
        end
         
       %% 更新参数
        for ii = 1 : n - 1       
            W{ii} = W{ii}(:,2:end) - learningRate*;
        end
              
    end
end

%% 测试，相当于把正向传播再走一遍
mm = size(test_x,1);
x = [ones(mm,1) test_x];
a{1} = x;
for ii = 2 : n-1    
%     a{ii} = 1.7159 * tanh( 2/3 .* (a{ii - 1} * W{ii - 1}'));  
                a{ii} =(a{ii - 1} * W{ii - 1}');  
    a{ii} = [ones(mm,1) a{ii}];
end
a{n} = 1./(1+exp(-(a{n - 1} * W{n - 1}')));

[~, i] = max(a{end},[],2);
labels = i;                         %识别后打的标签
[~, expected] = max(test_y,[],2);
bad = find(labels ~= expected);     %有哪些识别错了
er = numel(bad) / size(x, 1)       %错误率

plot(L);