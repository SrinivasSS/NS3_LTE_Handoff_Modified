clc
close all
clear all

x=[0.1 0.2 0.4 0.6 0.8 0.9];
y=[17.8876333333 26.8868 55.8884666667 231.861 421.861 897.8906666667];
figure();
plot(x,y,'-s');
hold on
y_ana=[17.0000   25.5527   53.1152  220.3558  400.9278  853.3365];
plot(x,y_ana,'--s');
hold on
y=[21.7988 126.324 129.3563333333 340.8453333333 540.8453333333	1006.0096666667];
plot(x,y,'-o')
hold on
y_ana=[0.0224    0.1298    0.1329    0.3502    0.5558    1.0338]*1000;
plot(x,y_ana,'--o')
hold off
title('Mean delay vs. rho');legend('Simulated MH','Analytical MH','Simulated Native','Analytical Native');
xlabel('Utilization factor->');ylabel('Delay in msecs->');

y=[0.8 1.3666666667 2.3 2.7 2.7 89.5666666667]/100;
figure();
plot(x,y,'-s');
hold on
y=[0.3666666667	2.98 5.1 10.7 14.7 97.9333333333]/100;
plot(x,y,'-o')
hold on
y_ana=[0.3208 2.6075 4.4625 9.3625 12.8625 90.6917]/100;
plot(x,y_ana,'--^')
hold off
title('Packet loss ratio v/s rho');legend('Simulated MH','Simulated NH','Analytical');
xlabel('Utilization Factor->');ylabel('Percentage packet loss->');
% Convert y-axis values to percentage values by multiplication
a=[cellstr(num2str(get(gca,'ytick')'*100))]; 
% Create a vector of '%' signs
pct = char(ones(size(a,1),1)*'%'); 
% Append the '%' signs after the percentage values
new_yticks = [char(a),pct];
% 'Reflect the changes on the plot
set(gca,'yticklabel',new_yticks) 
xlabel('Utilization Factor->');ylabel('Percent of packet losses->');
title('Percent of packet losses vs. rho'); legend('Simulated MH','Simulated NH','Analytical packet loss');

y=[6920000000	14293333333.3333	18660000000	19406666666.6667	19406666666.6667	870000000]/10^9;
figure();
plot(x,y,'-s');
hold on
y_ana=[9920000000	18293333333.3333	22660000000	25406666666.6667	22406666666.6667	880000000]/10^9;
plot(x,y_ana,'--o')
hold on
y=[15498533333.3333	31286666666.6667	32286666666.6667	33286666666.6667	33286666666.6667	3016666666.66667]/10^9;
plot(x,y,'-o')
hold on
y_ana=[18498533333.3333	32286666666.6667	33286666666.6667	33596666666.6667	33596666666.6667	3016666666.66667]/10^9;
plot(x,y_ana,'--o')
hold off
title('Jitter sum vs. rho');legend('Simulated MH','Analytical MH','Simulated Native','Analytical Native');
xlabel('Utilization Factor->');ylabel('Jitter sum in secs->');