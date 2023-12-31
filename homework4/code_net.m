clear all;
close all;
clc;

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
            a{ii} = 1.7159*tanh(2/3.*(a{ii - 1} * W{ii - 1}'));   
            a{ii} = [ones(mm,1) a{ii}];
        end
        
        a{n} = 1./(1+exp(-(a{n - 1} * W{n - 1}')));
        e = batch_y - a{n};
        L(ll) = 1/2 * sum(sum(e.^2)) / mm; 
        ll=ll+1;
       %% 反向传播
        d{n} = -e.*(a{n}.*(1 - a{n}));
        for ii = (n - 1) : -1 : 2  %2
            d_act = 1.7159 * 2/3 * (1 - 1/(1.7159)^2 * a{ii}.^2);
            
            if ii+1==n    
                d{ii} = (d{ii + 1} * W{ii}) .* d_act; 
            else 
                d{ii} = (d{ii + 1}(:,2:end) * W{ii}).* d_act;
            end          
        end
         
        for ii = 1 : n-1    % 1
            if ii + 1 == n
                dW{ii} = (d{ii + 1}' * a{ii}) / size(d{ii + 1}, 1);
            else
                dW{ii} = (d{ii + 1}(:,2:end)' * a{ii}) / size(d{ii + 1}, 1);      
            end
        end
         
       %% 更新参数
        for ii = 1 : n - 1       
            W{ii} = W{ii} - learningRate*dW{ii};
        end
              
    end
end

%% 测试，相当于把正向传播再走一遍
mm = size(test_x,1);
x = [ones(mm,1) test_x];
a{1} = x;
for ii = 2 : n-1    
    a{ii} = 1.7159 * tanh( 2/3 .* (a{ii - 1} * W{ii - 1}'));  
    a{ii} = [ones(mm,1) a{ii}];
end
a{n} = 1./(1+exp(-(a{n - 1} * W{n - 1}')));

[~, i] = max(a{end},[],2);
labels = i;                         %识别后打的标签
[~, expected] = max(test_y,[],2);
bad = find(labels ~= expected);     %有哪些识别错了
er = numel(bad) / size(x, 1)       %错误率

plot(L);