clear all

dataruns = importdata('D2z.txt');

x=dataruns(:,1);
y=dataruns(:,2);
N=dataruns(:,3);


% newpoint = [1 1];
% line(newpoint(1),newpoint(2),'marker','x','color','k',...
% %    'markersize',10,'linewidth',2)
% 
% Mdl=KDTreeSearcher([x,y]);
% 
% [n,d]=knnsearch(Mdl,newpoint,'k',1);

axisd=zeros(0);
for i = 1:41
    for k= 1:41
        [n, d] = knnsearch (Mdl,0.1*[i-21,k-21],'k',1);
        axisd=[axisd; 0.1*(i-21),0.1*(k-21),N(n)];
    end
end



gscatter(x,y,N,'br','xo')
legend('Location','best')
hold on
gscatter(axisd(:,1),axisd(:,2),axisd(:,3))




% line( axisd(),'color',[.5 .5 .5],'marker','o',...
%     'linestyle','none','markersize',10)