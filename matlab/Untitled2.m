clc
close all
clear all
time=[25,50,75,100,125,150,175,200]
mean_snr=[2,4,6,7,10,12,12,15]
mean_wei=[1,3,3,4,5,5,6,7]
plot(time,mean_snr,'-o')
hold on
plot(time,mean_wei,'-s')
hold off
title('Number of handoffs'); legend('Signal strength handoff','Modified Handoff');
xlabel('UE duration in secs->');ylabel('Number of handoffs->');