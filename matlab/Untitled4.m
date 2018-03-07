clc
clear all
close all
%Total mobile subscribers: 5.035 billion 
%(https://www.gsma.com/newsroom/press-release/number-mobile-subscribers-worldwide-hits-5-billion/)
names = {'Asia Pacific'; 'Europe'; 'Latin America'; 'Sub-sahara Africa'; 'Middle East and North-Africa';'North America';'CIS'};
y=[2765, 465, 459, 436, 391, 292, 227]; x=[1:7];
figure()
bar(x,y,'c')
set(gca,'xticklabel',names,'FontSize',8)
hTitle = title('Total global mobile subscribers: 5.035 billion in 2017 Q2');
set(hTitle,'FontSize',11)
ylabel('Subscribers in millions');

x=[2016 2021];
%Mobile Data Traffic per Month
y=[7.2 48.3];
figure()
subplot(1,3,1)
bar(x,y,'c');
title('Mobile Data Traffic per Month');ylabel('Data traffic per month in EB');
%Mobile Data Share of Total IP Traffic
y=[7 17]/100;
subplot(1,3,2)
bar(x,y,'c');
% Convert y-axis values to percentage values by multiplication
a=[cellstr(num2str(get(gca,'ytick')'*100))]; 
% Create a vector of '%' signs
pct = char(ones(size(a,1),1)*'%'); 
% Append the '%' signs after the percentage values
new_yticks = [char(a),pct];
% 'Reflect the changes on the plot
set(gca,'yticklabel',new_yticks) 
title('Mobile Data Share of Total IP Traffic');ylabel('Percentage');
%Average Mobile Connection Traffic Per Month
y=[1 5.4];
subplot(1,3,3)
bar(x,y,'c');
title('Average Mobile Connection Traffic Per Month');
ylabel('Data traffic in GB');