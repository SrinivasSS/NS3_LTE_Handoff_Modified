clc
close all
clear all
w=400*1000000; %Bandwidth
k=1; %we use k instead of i to get all the values. use i if values at 1 loop of j is required
   
%BTS locatioffs:
    r1x=100;r1y=600;
    r2x=500;r2y=900;
    r3x=900;r3y=400;
    figure('visible','off')
    plot(r1x,r1y,'o')
    hold on
    plot(r2x,r2y,'o')
    hold on
    plot(r3x,r3y,'o')
    hold off
%Number of decisioff points:
prompt = 'Number of decisioff points: ';
dec_pts = input(prompt);

for j=1:3
    %1st path:
    r=randi([1,10],1,1);
    userx=[1:r*dec_pts:r*dec_pts*dec_pts];
    r=randi([1,10],1,1);
    usery=[1:r*dec_pts:r*dec_pts*dec_pts];
    plot(userx,usery,'--')
    hold on
for i=1:length(userx)
    Rl=sqrt(((userx(i)-r1x)^2)+((usery(i)-r1y)^2));
    [SINR1(k)] =10*log10(trial1snr(Rl)); %snr and probability of detection
    snr_pd=SINR1(k);
    [pd1(k)]= trial1pd(snr_pd);
    Rl=sqrt(((userx(i)-r2x)^2)+((usery(i)-r2y)^2)); 
    [SINR2(k)] =10*log10(trial1snr(Rl)); 
    snr_pd=SINR2(k);
    [pd2(k)]=trial1pd(snr_pd);
    Rl=sqrt(((userx(i)-r3x)^2)+((usery(i)-r3y)^2)); 
    [SINR3(k)] =10*log10(trial1snr(Rl));
    snr_pd=SINR3(k);
    [pd3(k)]=trial1pd(snr_pd);
    x(k)=k;
    
    if (SINR1(k)>SINR2(k)) && (SINR1(k)>SINR3(k))
        Y(j,i)=1;
        rate(j,i)=w*log2(1+power(10,SINR1(k)/10));
    else if (SINR2(k)>SINR1(k)) && (SINR2(k)>SINR3(k))
         Y(j,i)=2;
        rate(j,i)=w*log2(1+power(10,SINR2(k)/10));
    else Y(j,i)=3;
        rate(j,i)=w*log2(1+power(10,SINR3(k)/10));
        end
    end
    
     if (pd1(k)>pd2(k)) && (pd1(k)>pd3(k))
        p(j,i)=1;
     else if (pd2(k)>pd1(k)) && (pd2(k)>pd3(k))
        p(j,i)=2;
     else p(j,i)=3;
          end
     end
    
    pmd1(k)=1-pd1(k);
    pmd2(k)=1-pd2(k);
    pmd3(k)=1-pd3(k);
    
    var1(k)=var(SINR1);
    var2(k)=var(SINR2);
    var3(k)=var(SINR3);
    
    k=k+1;
end

% snr_mat(:,1)=SINR1;
% snr_mat(:,2)=SINR2;
% snr_mat(:,3)=SINR3;
% snr_mat;
    
var1_j(j,1)=[var(SINR1)];
var1_j(j,2)=[var(SINR2)];
var1_j(j,3)=[var(SINR3)];

Y; %Bs the UE is coffnnected to
p; %Bs with best probability of detectioff

% %To calculate Pfa of each BS:
% Nt = numel(SINR1); %Coffvert SINR to a Square matrix
% M = NaN(ceil(sqrt(Nt))); %Coffvert SINR to a Square matrix
% M(1:Nt)=SINR1; %Coffvert SINR to a Square matrix
% N=i;
% SINR1C=transpose(coffj(M));
% Rx=(M*SINR1C)/N;
% v=eig(Rx) %Eigen values of Rx
% L=length(v);
% l1=1;%length(eig(M));
end
% var1;

%SINR plot
figure('visible','on') %Turns off plot generatioff
snrcombined = [SINR1(:),SINR2(:),SINR3(:)];
bar(x,snrcombined,'grouped')
title('SNR values compared each time')
legend('BS1','BS2','BS3')

%Variance plot for 1  instance
figure('visible','off')
varcombined = [var1_j(:,1),var1_j(:,2),var1_j(:,3)];
bar(varcombined,'grouped')
title('Variance values compared each time')
legend('BS1','BS2','BS3')

%Rate plot
figure('visible','off')
bar(rate)
title('Data rates compared each time')
legend('BS1','BS2','BS3')

%Variance plot for all points instances
figure('visible','off')
plot(x,var1)
hold on
plot(x,var2)
hold on
plot(x,var3)
hold off
title('Variance values compared over time')
legend('BS1','BS2','BS3')

%Probability of Detectioff:
figure('visible','off') %Turns off plot generatioff
pdcombined = [pd1(:),pd2(:),pd3(:)];
bar(x,pdcombined,'grouped')
title('Pd values compared each time')
legend('BS1','BS2','BS3')
ylim([0.25 1])

%to plot all values (sinr,pd) for single base statioff
figure('visible','off') 
plot(x,SINR1)
title('SNR for base statioff 1');

figure('visible','off') 
plot(x,pd1)
title('Probability of detectioff for base statioff 1');

%Plot SNR vs Pd for all statioffs:
figure('visible','off')
title('SNR vs Pd for BS1')
bar(SINR1,pd1,'r')
axis([0 70 0.8 1])
figure('visible','of')
bar(SINR2,pd2,'b')
title('SNR vs Pd for BS2')
axis([0 70 0.8 1])
figure('visible','off')
bar(SINR3,pd3,'g')
title('SNR vs Pd for BS3')
axis([0 70 0.8 1])
handoff_number(1)=0;
%Weighted Handoff:
weight1=0.6*var1+0.40*pmd1;
weight2=0.6*var2+0.40*pmd2;
weight3=0.6*var3+0.40*pmd3;
i=1;
for a=1:3
  disp(['Weighted Handoff for path:',num2str(a)])
  handoff_number(i)=0;
for i=((a-1)*dec_pts+1):a*dec_pts
     if i==1
         disp(['UE is coffnected to cell number:',num2str(Y(1,1))]);
     else if (weight1(i)<weight2(i)) && (weight1(i)<weight3(i))
        lowestweight(i)=1;   disp(['UE is coffnected to cell number:',num2str(lowestweight(i))]);
     else if (weight2(i)<weight1(i)) && (weight2(i)<weight3(i))
        lowestweight(i)=2;   disp(['UE is coffnected to cell number:',num2str(lowestweight(i))]);
     else lowestweight(i)=3; disp(['UE is coffnected to cell number:',num2str(lowestweight(i))]);
          end
     end
     end
     if i~=1
        if lowestweight(i)~=lowestweight(i-1)
           handoff_number(i)=handoff_number(i-1)+1;
        else handoff_number(i)=handoff_number(i-1);
        end
     end
end
  disp(['Number of Handoffs:',num2str(handoff_number(i))])
  averageHandoffsWeighted(a)=handoff_number(i);
end
%Normal Handoff:
%handoff_number(1)=0;
for a=1:3
    disp(['Normal Handoff for path:',num2str(a)])
    handoff_number(i)=0;
for i=((a-1)*dec_pts+1):a*dec_pts
     if i==1
         disp(['UE is coffnected to cell number:',num2str(Y(1,1))]);
     else if (SINR1(i)>SINR2(i)) && (SINR1(i)>SINR3(i))
        lowestweight(i)=1;   disp(['UE is coffnected to cell number:',num2str(lowestweight(i))]);
     else if (SINR2(i)>SINR1(i)) && (SINR2(i)>SINR3(i))
        lowestweight(i)=2;   disp(['UE is coffnected to cell number:',num2str(lowestweight(i))]);
     else lowestweight(i)=3; disp(['UE is coffnected to cell number:',num2str(lowestweight(i))]);
          end
     end
     end
     if i~=1
        if lowestweight(i)~=lowestweight(i-1)
           handoff_number(i)=handoff_number(i-1)+1;
        else handoff_number(i)=handoff_number(i-1);
        end
     end
end
 disp(['Number of Handoffs:',num2str(handoff_number(i))])
 averageHandoffsNormal(a)=handoff_number(i);
end
disp(['Average Number of Handoffs for Weighted:',num2str(ceil(mean(averageHandoffsWeighted)))])
disp(['Average Number of Handoffs for Normal:',num2str(ceil(mean(averageHandoffsNormal)))])
%To plot mean delay v/s data rate:
%For 90 load
rateasc=sort(rate(:));
[totaltime1]=trial1delay(rateasc,0.9); %Total delay fromm queue
figure('visible','off')
plot(rateasc,totaltime1*10^6+0.5076,'-o')
hold on
%For 50% load
[totaltime2]=trial1delay(rateasc,0.5); %Total delay fromm queue
plot(rateasc,totaltime2*10^6+0.5076,'-^')
hold on
%For 10% load
[totaltime3]=trial1delay(rateasc,0.1); %Total delay fromm queue
plot(rateasc,totaltime3*10^6+0.5076,'-s')
grid off
hold off
legend('For 90% load','For 50% load','For 10% load')
title('Latency vs rate')
xlabel('Rate in Gbps->'); ylabel('Mean Delay in terms of msecs->');
grid off 

%To plot mean delay v/s load:
%For highest data rate load:
rho=0.1:0.05:0.9;
rate_coffstant=max(rateasc);
[totaltime4]=trial1delay2(rate_coffstant); %Total delay fromm queue
figure('visible','off')
plot(rho,totaltime4*10^6+0.5076,'-o')
hold on
%For median data rate:
rate_coffstant=median(rateasc);
[totaltime5]=trial1delay2(rate_coffstant); %Total delay fromm queue
plot(rho,totaltime5*10^6+0.5076,'-^')
hold on
%For lowest data rate:
rate_coffstant=min(rateasc);
[totaltime6]=trial1delay2(rate_coffstant); %Total delay fromm queue
plot(rho,totaltime6*10^6+0.5076,'-s')
grid off
hold off
legend('For Highest data rate','For Median data rate','For Lowest data rate','Location','northwest')
title('Latency vs load')
xlabel('Percent of Load->'); ylabel('Mean Delay in terms of msecs->');
grid off 










