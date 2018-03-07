clc
clear all
close all

x=[200 400 800 1000 1200];


%For trialhanodff: mean packet delay
y=[17.7356666667 17.7877	17.7509666667 17.7208333333	17.7675];
mean_delay_modified=mean(y)
figure();
plot(x,y,'-s')
hold on
%For A3:mean packet delay
y=[21.7551 21.7549333333 21.6766666667 21.7870333333 21.8896 ];
mean_delay_native=mean(y)
plot(x,y,'-o')
hold on
% y=15;
% plot(x,y)
% hold on
y=[17 17 17 17 17];
plot(x,y,'--s')
hold on
y=[17 17 17 17 17]+5.4;
plot(x,y,'--o')
hold off
xlabel('Simulation Time->');ylabel('Mean packet delay in ms->');
title('Mean packet delay: NS3');legend('Simulated MH','Simulated NH','Analytical MH','Analytical NH');

%For trialhanodff: packet jitter
y=[21.01 22.88 22.56 22.56 22.56];
mean_jitter_modified=mean(y)
figure();
plot(x,y,'-s')
hold on
%For A3:packet jitter
y=[30.01 30.88 31.57 31.56 31.57];
mean_jitter_modified=mean(y)
plot(x,y,'-s')
hold on
y=[22.4 22.4 22.4 22.4 22.4]*1.49*0.9;
plot(x,y,'--o')
hold on
y=[17 17 17 17 17]*1.49*0.9999;
plot(x,y,'--s')
hold off
xlabel('Simulation Time->');ylabel('Sum packet jitter in secs->');
title('Packet jitter sum: NS3');legend('Simulated MH','Simulated NH','Analytical MH','Analytical NH');

%For trialhanodff: packet loss ratio
y=[0.4 0.4 0.4 0.3979166967 0.4022222567]/100;
mean_loss_modified=mean(y)
figure();
plot(x,y,'-s')
hold on
%For A3:packet loss ratio
y=[0.545269	0.5608496667 0.5646696667 0.5646696667 0.5646696667]/100;
mean_loss_modified=mean(y)
plot(x,y,'-s')
hold on
y=[0.35	0.35 0.35 0.35 0.35]/100;
plot(x,y,'--o')
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
title('Percent of packet losses: NS3'); legend('Simulated MH','Simulated NH','Analytical packet loss');