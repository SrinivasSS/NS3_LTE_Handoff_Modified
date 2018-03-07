clc
clear all
close all

krv=0.005;
k1=2;k2=3;
diff=0:1:6;
T=0.001;
for i=1:1:length(diff)
ans(i)=T/2 +krv*((10^(diff(i)/k2)-1)/(10^(diff(i)/k2)+1))
end
plot(diff,ans)
hold on
T=0.002;
for i=1:1:length(diff)
ans(i)=T/2 +krv*((10^(diff(i)/k2)-1)/(10^(diff(i)/k2)+1))
end
plot(diff,ans)
hold on
T=0.005;
for i=1:1:length(diff)
ans(i)=T/2 +krv*((10^(diff(i)/k2)-1)/(10^(diff(i)/k2)+1))
end
plot(diff,ans)
hold on
T=0.01;
for i=1:1:length(diff)
ans(i)=T/2 +krv*((10^(diff(i)/k2)-1)/(10^(diff(i)/k2)+1))
end
plot(diff,ans)
hold on
T=0.02;
for i=1:1:length(diff)
ans(i)=T/2 +krv*((10^(diff(i)/k2)-1)/(10^(diff(i)/k2)+1))
end
plot(diff,ans)
hold on
ylabel('Delay in secs');xlabel('Hysteresis in dB')
legend('T=1','T=2','T=5','T=10','T=20')