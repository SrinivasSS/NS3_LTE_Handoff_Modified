%Prelim data plots
clear all;
close all;
clc

width=0.4;
figure()
subplot(1,2,1)
%c=categorical(a);
y=[20 10 35 55];
barh(y,width,'c')
set(gca,'yticklabel',{'World', 'Developed', 'Developing', 'Least developed countries'});
title('\fontsize{13} Growth of mobile-broadband subscriptions, Compound Annual Growth Rate, 2012-2017');
xlabel('Percentage->');
subplot(1,2,2)
%c=categorical(a);
y=[58 98 50 22];
barh(y,width,'c')
set(gca,'yticklabel',{'World', 'Developed', 'Developing', 'Least developed countries'});
title('\fontsize{13} Growth in Mobile-broadband subscriptions');
xlabel('Per 100 inhabitants->');
% Mobile-broadband subscriptions have grown more than 20% annually in the last five years and are expected to
% reach 4.3 billion globally by end 2017.
% Despite the high growth rates in developing countries and in LDCs, there are twice as many mobile-broadband
% subscriptions per 100 inhabitants in developed countries as in developing countries, and four times as many in
% developed countries as in LDCs.


figure()
subplot(1,2,1)
%c=categorical(a);
y=[10 5 13 38];
barh(y,width,'c')
set(gca,'yticklabel',{'World', 'Developed', 'Developing', 'Least developed countries'});
title('\fontsize{9} Growth of fixed-broadband subscriptions, CAGR, 2012-2017');
xlabel('Percentage->');
subplot(1,2,2)
%c=categorical(a);
y=[12 32 9 3];
barh(y,width,'c')
set(gca,'yticklabel',{'World', 'Developed', 'Developing', 'Least developed countries'});
title('\fontsize{9} Growth in Fixed-broadband subscriptions, 2017');
xlabel('Per 100 inhabitants->');
% The global number of fixed-broadband subscriptions has increased by 9% annually in the last five years and 330
% million new fixed-broadband subscriptions have been added.
% Higher growth will be needed to bridge the divide between developed and developing countries: there are 31
% fixed broadband subscriptions per 100 inhabitants in developed countries against 9 in developing countries.
% Fixed-broadband uptake remains very limited in LDCs, with only one subscription per 100 inhabitants. 

figure()
x=[2016, 2017, 2018, 2019, 2020, 2021];
y=[7201, 11183, 16646, 24220 ,34382, 48270];
set(gca,'yticklabel',{'7201 ','11183 ','16646', '24220' ,'34382', '48270'});
bar(x,y,width,'c')
%text('\rightarrow CAGR=46%');
hold on

a=[2263 3214 4295 5509 6796 8201];
set(gca,'xTickLabel',{'2016';'2017';'2018';'2019';'2020';'2021'})
plot(x,a,'-o')
%text('\rightarrow CAGR=29%');
hold on

b=[3660 6094 9696 15010 22512 33173];
set(gca,'xTickLabel',{'2016';'2017';'2018';'2019';'2020';'2021'})
plot(x,b,'-o')
%text('\rightarrow CAGR=29%');
hold off
text(2016 ,35000,'Growth of video:54% \rightarrow','Color','red','FontSize',13);
text(2016 ,30000,'Growth of all other apps:29% \rightarrow','Color','blue','FontSize',13);
legend('Mobile data and Internet','Other applications on mobile: email,file sharing etc','Percent video on Mobile','Location','northwest');
title('\fontsize{15} Increase in data usage: Mobile and its applications')
xlabel('Year->');ylabel('Data used in Petabytes->');
%Video will be 79% of Global mobile data traffic in 2021, compared to 60% at the end of 2016.
% 1 Gigabyte = 1,000 Megabytes
% 1 Terabyte = 1,000 Gigabytes
% 1 Petabyte = 1,000 Terabytes = 1,000,000 Gigabytes
% 1 Exabyte = 1,000 Petabytes = 1,000,000 Terabyte