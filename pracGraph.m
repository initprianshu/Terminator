clc
clear all

A=[1 2; 1 1; 1 -2];
B=[10; 6; 1];

n=3;

y=0:1:10;

x11=(B(1)-(y*A(1,2)))/A(1,1);
x21=(B(2)-(y*A(2,2)))/A(2,1);
x31=(B(3)-(y*A(3,2)))/A(3,1);

plot(y,x11,'r',y,x21,'b',y,x31,'g')
xlim([0 10]);
ylim([0 10]);

c2=find(y==0);
c21=find(x21==0);
Line2=[y(:,[c2 c21]);x21(:,[c2 c21])]';

c3=find(y==0);
c31=find(x11==0);
Line3=[y(:,[c3 c31]);x31(:,[c3 c31])]';

c1=find(y==0);
c11=find(x11==0);
Line1=[y(:,[c1 c11]);x11(:,[c1 c11])]';

cornerpts=unique([Line1;Line2;Line2],'rows');

pts=[];
for i=1:n
   for j=i+1:n
      p=[A(i,:);A(j,:)];
      q=[B(i);B(j)];
      x=inv(p)*q;
      pts=[pts x];
   end
end

pts=pts';

allpts=unique([cornerpts;pts],'rows');

PT=constraint(allpts);
pt=unique(PT,'rows');

maxvalue=-inf;
maxind=0;

for i=1:size(pt,1)
   x1=pt(i,1);
   x2=pt(i,2);
   fn=2*x1+x2;
   if fn>maxvalue
       maxvalue=fn;
       maxind=i;
   end
end

sol=[pt(maxind,1) pt(maxind,2)]
disp(maxvalue);