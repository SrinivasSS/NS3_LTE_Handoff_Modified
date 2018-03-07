clc
close all
clear all
Decision_points=[4	6	8	10	12	16	20	24	30	40	50	60	80];
New =           [1  1	1	2	3	3	3	3	5	5	7	10	14];
Original=       [3	5	6	6	9	10	15	18	20	27	36	44	57];
figure()
plot(Decision_points,New,'-o');
hold on;
plot(Decision_points,Original,'-s');
hold off;
legend('Modified handoff','Signal strength handoff');
title('Handoff Comparison');
xlabel('Number of handoff points->'); ylabel('Average number of Handoffs->');