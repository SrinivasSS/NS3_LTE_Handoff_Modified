clc
clear all
close all

x=[25 50 75 100 125 150 200 400 800 1000 1200];


%For trialhanodff: mean packet delay
y=[17.2186666667 17.6180333333 17.0384	17.0196666667 17.8782666667 17.7105333333 17.7356666667 17.7877	17.7509666667 17.7208333333	17.7675];
mean_delay_modified=mean(y)
figure();
plot(x,y,'-s')
hold on
%For A3:mean packet delay
y=[22.7549333333 22.7549333333 22.7549333333 21.8169666667 21.7764666667 21.7551 21.7551 21.7549333333 21.6766666667 21.7870333333	21.8896 ];
mean_delay_native=mean(y)
plot(x,y,'-s')
hold on
y=15;
plot(x,y)
hold off
xlabel('Simulation Time->');ylabel('Mean packet delay in ms->');
title('Mean paacket delay: NS3');legend('Modified handover','Native handover');

%For trialhanodff: packet jitter
y=[22.67 23.67 22.33 22.33 23.77 22.14 21.01 22.88 22.56 22.56 22.56];
mean_jitter_modified=mean(y)
figure();
plot(x,y,'-s')
hold on
%For A3:packet jitter
y=[30.27 32.4 31.13 31.45 31.82 33.14 30.01 30.88 31.57 31.56 31.57];
mean_jitter_modified=mean(y)
plot(x,y,'-s')
hold off
xlabel('Simulation Time->');ylabel('Sum packet jitter in secs->');
title('Packet jitter sum: NS3');legend('Modified handover','Native handover');

%For trialhanodff: packet loss ratio
y=[0.4 0.44 0.4	0.4	0.36 0.4 0.4 0.4 0.4 0.3979166967 0.4022222567]/100;
mean_loss_modified=mean(y)
figure();
plot(x,y,'-s')
hold on
%For A3:packet loss ratio
y=[0.495501	0.594571 0.55169 0.5670586667 0.554941 0.54245 0.515269	0.5608496667 0.5646696667 0.5646696667 0.559224]/100;
mean_loss_modified=mean(y)
plot(x,y,'-s')
hold off
% Convert y-axis values to percentage values by multiplication
a=[cellstr(num2str(get(gca,'ytick')'*100))]; 
% Create a vector of '%' signs
pct = char(ones(size(a,1),1)*'%'); 
% Append the '%' signs after the percentage values
new_yticks = [char(a),pct];
% 'Reflect the changes on the plot
set(gca,'yticklabel',new_yticks) 
xlabel('Simulation Time->');ylabel('Percent of packet losses->');
title('Percent of packet losses: NS3'); legend('Modified handover','Native handover');