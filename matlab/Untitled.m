clc
close all
clear all

x=[0.1 0.2 0.4 0.6 0.8 0.9];

y=[17.8876333333 26.8868 55.8884666667 231.861 421.861 897.8906666667];
figure();
plot(x,y,'-o');
hold on
y=[21.7988 126.324 129.3563333333 340.8453333333 540.8453333333	1006.0096666667]
plot(x,y,'-o')
hold off
title('Mean delay v/s rho');legend('Modified','Native');xlabel('Utilization factor->');ylabel('Delay in msecs');
y=[0.8 1.3666666667 2.3 2.7 2.7 89.5666666667];
figure();
plot(x,y,'-^');
hold on
y=[0.3666666667	2.98	5.1	10.7	14.7	97.9333333333]
plot(x,y,'-^')
hold off
title('Packet loss ratio v/s rho');legend('Modified','Native');xlabel('Number of packets->');ylabel('Percentage');
y=[6920000000	14293333333.3333	18660000000	19406666666.6667	19406666666.6667	870000000]/10^9;
figure();
plot(x,y);
hold on
y=[15498533333.3333	31286666666.6667	32286666666.6667	33286666666.6667	33286666666.6667	3016666666.66667]/10^9;
plot(x,y)
hold on
title('Jitter sum v/s rho');legend('Modified','Native');xlabel('Number of packets->');ylabel('Jitter sum in secs');