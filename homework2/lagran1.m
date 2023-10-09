function [y,R] = lagran1(X,Y,x,M)
n=length(X);
m=length(x);
for i=1:m
    z=x(i);
    s=0;
    for k=1:n
        p=1,q1=1;c1=1;
        for j=1:n
            if j~=k
                p=p*(z-X(j))/(X(k)-X(j));
            end
            q1=abs(q1*(z-X(j)));
            c1=c1*j;
     end
     s=p*Y(k)+s;
    end
    y(i)=s;
    R(i)=M*q1/c1;
end
