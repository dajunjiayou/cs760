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

Mdl=KDTreeSearcher(num);

[n,d]=knnsearch(Mdl,testnum,'k',10);


testresult=round(sum(label(n),2)/10);

ratiosss=testresult./testlabel;
TP=sum(ratiosss(find(ratiosss==1)));
FP=sum(testlabel)-TP;

ratioaaa=testresult+testlabel;
TN=size(ratioaaa(find(ratioaaa==0)),1);
FN=sum(1-testlabel)-TN;

recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);

acuracy1=acuracy;
acuracy3=acuracy;
acuracy5=acuracy;
acuracy7=acuracy;
acuracy10=acuracy;

figure
plot([1,3,5,7,10],[acuracy1,acuracy3,acuracy5,acuracy7,acuracy10])


%% exp2


num=dataruns2([1:1000,2001:5000],1:end-1);
label=dataruns2([1:1000,2001:5000],end);


testnum=dataruns2(1001:2000,1:end-1);
testlabel=dataruns2(1001:2000,end);
Mdl=KDTreeSearcher(num);

[n,d]=knnsearch(Mdl,testnum,'k',10);


testresult=round(sum(label(n),2)/10);

ratiosss=testresult./testlabel;
TP=sum(ratiosss(find(ratiosss==1)));
FP=sum(testlabel)-TP;

ratioaaa=testresult+testlabel;
TN=size(ratioaaa(find(ratioaaa==0)),1);
FN=sum(1-testlabel)-TN;

recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);

acuracy1=acuracy;
acuracy3=acuracy;
acuracy5=acuracy;
acuracy7=acuracy;
acuracy10=acuracy;

figure
plot([1,3,5,7,10],[acuracy1,acuracy3,acuracy5,acuracy7,acuracy10])



%% exp3


num=dataruns2([1:2000,3001:5000],1:end-1);
label=dataruns2([1:2000,3001:5000],end);


testnum=dataruns2(2001:3000,1:end-1);
testlabel=dataruns2(2001:3000,end);


Mdl=KDTreeSearcher(num);

[n,d]=knnsearch(Mdl,testnum,'k',10);


testresult=round(sum(label(n),2)/10);

ratiosss=testresult./testlabel;
TP=sum(ratiosss(find(ratiosss==1)));
FP=sum(testlabel)-TP;

ratioaaa=testresult+testlabel;
TN=size(ratioaaa(find(ratioaaa==0)),1);
FN=sum(1-testlabel)-TN;

recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);

acuracy1=acuracy;
acuracy3=acuracy;
acuracy5=acuracy;
acuracy7=acuracy;
acuracy10=acuracy;

figure
plot([1,3,5,7,10],[acuracy1,acuracy3,acuracy5,acuracy7,acuracy10])




%% exp4


num=dataruns2([1:3000,4001:5000],1:end-1);
label=dataruns2([1:3000,4001:5000],end);


testnum=dataruns2(3001:4000,1:end-1);
testlabel=dataruns2(3001:4000,end);


Mdl=KDTreeSearcher(num);

[n,d]=knnsearch(Mdl,testnum,'k',1);


testresult=round(sum(label(n),2)/1);

ratiosss=testresult./testlabel;
TP=sum(ratiosss(find(ratiosss==1)));
FP=sum(testlabel)-TP;

ratioaaa=testresult+testlabel;
TN=size(ratioaaa(find(ratioaaa==0)),1);
FN=sum(1-testlabel)-TN;

recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);

acuracy1=acuracy;
acuracy3=acuracy;
acuracy5=acuracy;
acuracy7=acuracy;
acuracy10=acuracy;

figure
plot([1,3,5,7,10],[acuracy1,acuracy3,acuracy5,acuracy7,acuracy10])




%% exp5


num=dataruns2([1:4000],1:end-1);
label=dataruns2([1:4000],end);


testnum=dataruns2(4001:5000,1:end-1);
testlabel=dataruns2(4001:5000,end);

Mdl=KDTreeSearcher(num);

[n,d]=knnsearch(Mdl,testnum,'k',10);


testresult=round(sum(label(n),2)/10);

ratiosss=testresult./testlabel;
TP=sum(ratiosss(find(ratiosss==1)));
FP=sum(testlabel)-TP;

ratioaaa=testresult+testlabel;
TN=size(ratioaaa(find(ratioaaa==0)),1);
FN=sum(1-testlabel)-TN;

recall=TP/(TP+FN);
acuracy=(TP+TN)/(TP+FP+FN+TN);
precision=TP/(TP+FP);

acuracy1=acuracy;
acuracy3=acuracy;
acuracy5=acuracy;
acuracy7=acuracy;
acuracy10=acuracy;

figure
plot([1,3,5,7,10],[acuracy1,acuracy3,acuracy5,acuracy7,acuracy10])


