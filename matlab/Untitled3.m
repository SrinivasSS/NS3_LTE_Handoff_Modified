clc
clear all
close all

v=5;
w=5;
h=2.5;
s=[0:30];
a=2*(v./s)*(1-(h/w));
subplot(1,3,1)
plot(s,a)
hold on
v=10;
a=2*(v./s)*(1-(h/w));
plot(s,a)
hold on
v=20;
a=2*(v./s)*(1-(h/w));
plot(s,a)
hold off
xlabel('Obstacle spacing(m)->');ylabel('Rate of handoffs/sec->');
title('Handoff rate for fixed obstacles'); legend('For v=5km/hr','For v=10km/hr','For v=20km/hr')

t=0:0.01:0.15;
a=16.*t;
subplot(1,3,2)
plot(t,a)
xlabel('Truck density(trucks/m)->');ylabel('Rate of handoffs/sec->');
title('Handoff rate for moving obstacles');

t=0:0.1:1;
a=t+0.7.*t;
subplot(1,3,3)
plot(t,a)
xlabel('Pedestrian density(pedestrians/m)->');ylabel('Rate of handoffs/sec->');
title('Handoff rate for pedestrian obstacles');