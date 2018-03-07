clc
clear all
close all

x=[500 1000	1500	2000	5000	10000];

y=[18.069	17.4358666667	17.1013	17.0287	17.3837333333	17.3837333333];
figure();
plot(x,y);
hold on
y=[21.5087	21.54	21.5887333333	21.5924333333	21.5924333333	21.7924333333]
plot(x,y)
hold off
title('Mean delay v/s packet');legend('Modified','Native');xlabel('Number of packets->');ylabel('Delay in msecs');
y=[1.4	1	0.8444453333	0.7833333333	0.594504	0.594504];
figure();
plot(x,y);
hold on
y=[0.5333333333	0.2666666667	0.1777776667	0.1333333333	0.0533546667	0.0533546667]
plot(x,y)
hold off
title('Packet loss ratio v/s packet');legend('Modified','Native');xlabel('Number of packets->');ylabel('Percentage');
y=[786666666.666667	1386666666.66667	1920000000	2520000000	6540000000	6540000000]/10^9;
figure();
plot(x,y);
hold on
y=[979139333.333333	2029400000	3105043333.33333	4101163333.33333	9458346666.66667	9458346666.66667]/10^9;
plot(x,y)
hold off
title('Jitter sum v/s packet');legend('Modified','Native');xlabel('Number of packets->');ylabel('Jitter sum in secs');