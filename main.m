
% clear all
% 

dataruns = importdata('Dbig.txt');

n1=8192;
list1=[1:1:10000];
dataN1=dataruns(randperm(numel(list1),n1),:);

n2=2048;
list2=[1:1:n1];
dataN2=dataN1(randperm(numel(list2),n2),:);

n3=512;
list3=[1:1:n2];
dataN3=dataN2(randperm(numel(list3),n3),:);

n4=128;
list4=[1:1:n3];
dataN4=dataN3(randperm(numel(list4),n4),:);

n5=32;
list5=[1:1:n4];
dataN5=dataN4(randperm(numel(list5),n5),:);



X = dataN5(:, 1:2);  % Assuming the first two columns are features

y = dataN5(:, 3);   % Assuming the third column is the label

tree = DecisionTreeNode.build_decision_tree(X, y);


MdlDefault = fitctree(X,y,'CrossVal','on');
view(MdlDefault.Trained{1},'Mode','graph')

%%

numnodes=[80,30,15,4,3];
nerr=[98.2,96.4,94.5,88.3,81.2];
figure
plot(numnodes,nerr)
xlabel('number of nodes');
ylabel('successful rate (%)');

%%
xsin=[0:0.1:10];
ysin=sin(xsin);

figure
plot(xsin,ysin);



% view(tree);
% 
% 
% figure;
% histogram(tree)
% 
% 
% 
% 
% 
% 
% view(tree.Left,'Mode','graph')
% 
% figure
% treeplot(tree)
% 
% 
% view(tree) % text description
% 
% 
% e=min(tree.Left)
% figure
% treeplot(tree)