clc
clear all
close all

x=[25 50 75 100 125 150 175 200 400 800 1000 1200 1400 1600];

%For trialhanodff:handoffs number
y=[8 15 20 27 32 35 44 47 52 52 52 52 52 52];
figure();
plot(x,y,'-o')
hold on
%For A3: handoffs number
y=[14 22 28 33 47 58 60 62 65 65 65 65 65 65];
plot(x,y,'-s')
hold off
xlabel('Simulation Time->');ylabel('Average number of handoffs->');
legend('Modified handoff','Native handoff');
title('Expected Number of handoffs: NS3');