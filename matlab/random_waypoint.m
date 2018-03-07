clear all
close all
clc

tc=1;
w=400*1000000; %Bandwidth
%Dimensions of area to move around
X = 2500;
Y = 2500;
MINSPEED = 0;
MAXSPEED = 40;
%TIME = 90;
%Location of BTS
r1x=400;r1y=1000;
r2x=2000;r2y=450;
r3x=400;r3y=1010;
figure('visible','off')
plot(r1x,r1y,'-^')
hold on
plot(r2x,r2y,'-^')
hold on
plot(r3x,r3y,'-^')
hold off
figure('visible','on')
for N=1:1:8
%N = 10; %Number of path changes
AMOSTRAS = 1;%Number of paths starting at origin
nodes = zeros(N,6);
%nodes_speed = zeros(N,TIME);
%nodes_speed_mean = zeros (AMOSTRAS,TIME);
k=1;
separate_points=6;%points to calculate values

%Pre-allocating space to matrices:
xcorr=zeros(1,N);
ycorr=zeros(1,N);
SINR1=zeros(1,N*AMOSTRAS*separate_points);SINR2=zeros(1,N*AMOSTRAS*separate_points);SINR3=zeros(1,N*AMOSTRAS*separate_points);
pd1=zeros(1,N*AMOSTRAS*separate_points);pd2=zeros(1,N*AMOSTRAS*separate_points);pd3=zeros(1,N*AMOSTRAS*separate_points);
pmd1=zeros(1,N*AMOSTRAS*separate_points);pmd2=zeros(1,N*AMOSTRAS*separate_points);pmd3=zeros(1,N*AMOSTRAS*separate_points);
hist1=zeros(1,N*AMOSTRAS*separate_points);hist2=zeros(1,N*AMOSTRAS*separate_points);hist3=zeros(1,N*AMOSTRAS*separate_points);
weight1=zeros(1,N*AMOSTRAS*separate_points);weight2=zeros(1,N*AMOSTRAS*separate_points);weight3=zeros(1,N*AMOSTRAS*separate_points);
handoff_number=zeros(1,N*AMOSTRAS*separate_points);lowestweight=zeros(1,N*AMOSTRAS*separate_points);
totalhandoffs=zeros(1,AMOSTRAS);
count=zeros(1,N*AMOSTRAS*separate_points);
highest_sinrweight=zeros(1,N*AMOSTRAS*separate_points); lowest_weight=zeros(1,N*AMOSTRAS*separate_points);
ho_delay_snr=zeros(1,N*AMOSTRAS*separate_points); ho_delay_wei=zeros(1,N*AMOSTRAS*separate_points);
rate_sinr=zeros(1,N*AMOSTRAS*separate_points); rate_wei=zeros(1,N*AMOSTRAS*separate_points);
weighted_handoff_number=zeros(1,N*AMOSTRAS*separate_points); 
total_weightedhandoffs=zeros(1,AMOSTRAS);
% mean_snr=zeros(1,N); mean_wei=zeros(1,N);
mean_totaltime1=zeros(1,N); mean_totaltime2=zeros(1,N); mean_totaltime3=zeros(1,N);
mean_totaltime4=zeros(1,N);mean_totaltime5=zeros(1,N);mean_totaltime6=zeros(1,N);
% sinrMeanRate=zeros(1,N); weiMeanRate=zeros(1,N); 
total_count=zeros(1,N*AMOSTRAS*separate_points);
ho_delay_snr(1)=0; ho_delay_wei(1)=0;
%Start random waypoint
% figure('visible','on')
for total_pts=1:AMOSTRAS
        origin_xcorr=0;
        origin_ycorr=0;
    for i=1:N
        x = rand*X;
        y = rand*Y;
        waypointX = rand*X;
        waypointY = rand*Y;
        dist = sqrt((x-waypointX)^2+(y-waypointY)^2);
        new_waypointX = rand*X;
        new_waypointY = rand*Y;
        xcorr(i)=waypointX;
        ycorr(i)=waypointY;
        b='--';%Denote style of plot
        if i==1
            plot([0 xcorr(i)],[0 ycorr(i)],b)
            hold on
        else plot([xcorr(i-1) xcorr(i)],[ycorr(i-1) ycorr(i)],b)
            hold on
        end
        %separate single path into different points
        if waypointX>origin_xcorr
            b=waypointX;
            a=origin_xcorr;
            signx=1;
        else a=waypointX;
             b=origin_xcorr;
             signx=-1;
        end
        if waypointY>origin_ycorr
            d=waypointY;
            c=origin_ycorr;
            signy=1;
        else c=waypointY;
             d=origin_ycorr;
             signy=-1;
        end
        
        xcorr_diff=(b-a)/separate_points;
        ycorr_diff=(d-c)/separate_points;
        for pt=1:separate_points
            plotx=origin_xcorr+(xcorr_diff*signx*pt);
            ploty=origin_ycorr+(ycorr_diff*signy*pt);
            plot(plotx,ploty,'-o')
            hold on

            Rl=sqrt((plotx-r1x)^2+(ploty-r1y)^2);
            [SINR1(k)] =10*log10(trial1snr(Rl));
            snr_pd=SINR1(k);
            [pd1(k)]= trial1pd(snr_pd);
            Rl=sqrt((plotx-r2x)^2+(ploty-r2y)^2); 
            [SINR2(k)] =10*log10(trial1snr(Rl)); 
            snr_pd=SINR2(k);
            [pd2(k)]=trial1pd(snr_pd);
            Rl=sqrt((plotx-r3x)^2+(ploty-r3y)^2);
            [SINR3(k)] =10*log10(trial1snr(Rl));
            snr_pd=SINR3(k);
            [pd3(k)]=trial1pd(snr_pd);
            
            %Add hysteris to signal strength
            hist1(k)=SINR1(k)+5;
            hist2(k)=SINR2(k)+5;
            hist3(k)=SINR3(k)+5;
            %Calculate the Pmd
            pmd1(k)=1-pd1(k);
            pmd2(k)=1-pd2(k);
            pmd3(k)=1-pd3(k);
            %Calculate the variance
            var1=var(SINR1);
            var2=var(SINR2);
            var3=var(SINR3);
            
            %Calculate weighted parameter
            weight1(k)=0.6*var1+0.40*pmd1(k);
            weight2(k)=0.6*var2+0.40*pmd2(k);
            weight3(k)=0.6*var3+0.40*pmd3(k);
            
            count(k)=k;
            k=k+1;
        end
        origin_xcorr = waypointX;
        origin_ycorr = waypointY;
    end 
%end 
%Normal Handoff:
%handoff_number(1)=0; 

%for a=1:AMOSTRAS
    %disp(['Normal Handoff for path:',num2str(a)])
    handoff_number(1)=0;
    weighted_handoff_number(1)=0;
for i=1:(k-1)
      
    %Normal Handoffs
     [strong_sinr,index_sinr]=max([SINR1(i) SINR2(i) SINR3(i)]);
     highest_sinrweight(i)=index_sinr;
     rate_sinr(i)=w*log2(1+power(10,strong_sinr/10));
     %disp(['UE is connected to cell number:',num2str(highest_sinrweight(i))]);
      if i~=1
        if highest_sinrweight(i)~=highest_sinrweight(i-1)
           handoff_number(i)=handoff_number(i-1)+1;
           ho_delay_snr(i)=0.01; %HO delay add
        else handoff_number(i)=handoff_number(i-1);
             ho_delay_snr(i)=0;
        end
      end
      
      %Weighted Handoffs
     [low_weight,index_weight]=min([weight1(i) weight2(i) weight3(i)]);
     lowest_weight(i)=index_weight;
     
         switch (i)
             case 1
                 wsinr=SINR1(i);
             case 2
                 wsinr=SINR2(i);
             otherwise
                 wsinr=SINR3(i);
         end
     rate_wei(i)=w*log2(1+power(10,wsinr/10));
     %disp(['UE is connected to cell number:',num2str(lowest_weight(i))]);
     if i~=1
        if lowest_weight(i)~=lowest_weight(i-1)
           weighted_handoff_number(i)=weighted_handoff_number(i-1)+1;
           ho_delay_wei(i)=0.01; %HO delay add
        else weighted_handoff_number(i)=weighted_handoff_number(i-1);
            ho_delay_wei(i)=0;
        end
     end
end
 %disp(['Number of Handoffs:',num2str(handoff_number(i))])
 totalhandoffs(1,total_pts)=handoff_number(i);
 total_weightedhandoffs(1,total_pts)=weighted_handoff_number(i);
end
mean_snr(N)=mean(totalhandoffs(:));
mean_wei(N)=mean(total_weightedhandoffs(:));
% disp(['For path with changes N: ',num2str(N)]);
% disp(['Average number of Normal Handoffs:',num2str(mean_snr(N))])
% disp(['Average number of Weighted Handoffs:',num2str(mean_wei(N))])
total_count(tc)=N; tc=tc+1;

%Calculating delay for each path sinr
%For 90 load
[totaltime1]=trial1delay(rate_sinr,0.9); %Total delay fromm queue
mean_totaltime1(N)=mean(totaltime1*10^3+ho_delay_snr);
%For 50% load
[totaltime2]=trial1delay(rate_sinr,0.5); %Total delay fromm queue
mean_totaltime2(N)=mean(totaltime2*10^3+ho_delay_snr);
%For 10% load
[totaltime3]=trial1delay(rate_sinr,0.1); %Total delay fromm queue
mean_totaltime3(N)=mean(totaltime3*10^3+ho_delay_snr);

%Calculating delay for each path weighted
%For 90 load
[totaltime4]=trial1delay(rate_wei,0.9); %Total delay fromm queue
mean_totaltime4(N)=mean(totaltime4*10^3+ho_delay_wei);
%For 50% load
[totaltime5]=trial1delay(rate_wei,0.5); %Total delay fromm queue
mean_totaltime5(N)=mean(totaltime5*10^3+ho_delay_wei);
%For 10% load
[totaltime6]=trial1delay(rate_wei,0.1); %Total delay fromm queue
mean_totaltime6(N)=mean(totaltime6*10^3+ho_delay_wei);

%Calculating mean data rate
%For normal handoff
sinrMeanRate(N)=mean(rate_sinr);
weiMeanRate(N)=mean(rate_wei);
end
%SINR plot
figure('visible','off') %Turns off plot generation
snrcombined = [SINR1(:) SINR2(:) SINR3(:)];
bar(count,snrcombined,'grouped')
title('SINR values compared each time')
legend('BS1','BS2','BS3')

%variance and pmd plot plot
figure('visible','off') %Turns off plot generation
weight_combined = [weight1(:) weight2(:) weight3(:)];
bar(count,weight_combined,'grouped')
title('Weight values compared each time')
legend('BS1','BS2','BS3')

%Rate of UE
figure('visible','on')
bar(rate_sinr)
title('Average data rate')
ylabel('Rate in bps ->');

%Rate of UE
figure('visible','off')
ratecombined=[rate_sinr(:) rate_wei(:)];
bar(ratecombined,'grouped')
title('Rate as UE moves through Base stations')
ylabel('Rate ->');
legend('Normal handoff','Weighted Handoff')

%Final handoffs plot
figure('visible','on')
plot(mean_snr)
hold on
plot(mean_wei)
hold off
title('Number of handoffs for all N values');

%To plot mean delay v/s data rate:
%For 90 load
%rateasc=sort(rate(:));
[totaltime1]=trial1delay(rate_sinr,0.9); %Total delay fromm queue
figure('visible','off')
plot(totaltime1*10^6+0.5076,'-o')
disp(['Average delay with 90% load:',num2str(mean(totaltime1))]);
hold on
%For 50% load
[totaltime2]=trial1delay(rate_sinr,0.5); %Total delay fromm queue
plot(totaltime2*10^6+0.5076,'-^')
disp(['Average delay with 50% load:',num2str(mean(totaltime2))]);
hold on
%For 10% load
[totaltime3]=trial1delay(rate_sinr,0.1); %Total delay fromm queue
plot(totaltime3*10^6+0.5076,'-s')
disp(['Average delay with 10% load:',num2str(mean(totaltime3))]);
hold off
legend('For 90% load','For 50% load','For 10% load')
title('Latency vs rate')
ylabel('Mean Delay in terms of msecs->');

%Mean latency for all 3 paths:
figure('visible','off')
plot(mean_totaltime1*10^3+0.5076,'-o')
hold on
plot(mean_totaltime4*10^3+0.5076,'-^')
hold off
ylabel('Latency in msecs');title('Total latency vs Load for both handoffs');
legend('Normal:90%','Weighted:90%');
figure('visible','off')
plot(mean_totaltime2*10^3+0.5076,'-o')
hold on
plot(mean_totaltime5*10^3+0.5076,'-^')
hold off
ylabel('Latency in msecs');title('Total latency vs Load for both handoffs');
legend('Normal:50%','Weighted:50%');
figure('visible','off')
plot(mean_totaltime3*10^3+0.5076,'-o')
hold on
plot(mean_totaltime6*10^3+0.5076,'-^')
hold off
ylabel('Latency in msecs');title('Total latency vs Load for both handoffs');
legend('Normal:10%','Weighted:10%');

%Percentage of improvement
percent_90=100*((mean_totaltime1*10^3+0.5076)-(mean_totaltime4*10^3+0.5076))/(mean_totaltime1*10^3+0.5076);
percent_50=100*((mean_totaltime2*10^3+0.5076)-(mean_totaltime5*10^3+0.5076))/(mean_totaltime2*10^3+0.5076);
percent_10=100*((mean_totaltime4*10^3+0.5076)-(mean_totaltime6*10^3+0.5076))/(mean_totaltime3*10^3+0.5076);
figure('visible','off')
percent_combined=[percent_90 percent_50(:) percent_10(:)];
bar(percent_combined,'grouped')
title('Percentage improvement in weighted handoffs'); 
%legend('For 90% Load','For 50% Load','For 10% Load');
ylabel('Percent Improvement ->');

%Mean Rate difference
figure('visible','off')
mean_rateCombined=[weiMeanRate(:) sinrMeanRate(:)];
bar(mean_rateCombined,'grouped')
legend('Weighted handoff','Normal handoff')
title('Mean data rate comparison');ylabel('Mean data rate->');