clc;
clear all;
Data2=load("saving_to_mat.mat")
Data1=load("learn_to_loa.txt");
Column1=Data1(:,1);
Element=Data1(3,2);
%Plotting
x1=[0 1 2 3 4 5 ];
y1=cos(x1);
figure(1);
hold on %to keep both plots
plot(x1,y1,'o-g');
%o marker type - line type g color
x2=linspace(0,2*pi);%for evenly spaced linspace generate 100 points
y2=sin(x2);

plot(x2,y2,'*-r')
xlabel ('Time')
ylabel('Voltage')