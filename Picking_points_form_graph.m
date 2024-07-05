clc;
clear all;
a=linspace(0,2*pi)
b=sin(a)
figure(1)
clf%clear old data on figure
hold on%keep the figure 1 
plot(a,b)
[x,y]=ginput(2)%giving graph as input
plot(x,y,'*')
%finding slope
slope=(y(2)-y(1))/(x(2)-x(1))
