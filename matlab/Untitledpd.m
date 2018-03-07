%Pd for rayleigh channel:
snr_pd=5;
snr=10.^(snr_pd./10); %SNR
th=0:0.01:100;
N=10;
p_f=1-gammainc(th./2,N./2);
% p_f=[1:-0.001:0]
pd=[];
A=snr./(1+snr);
mu=N./2;
for i=1:length(p_f)
	k=0:1:mu-2;
	sum1=sum((1./factorial(k)).*(th(i)./2).^(k));
	sum2=sum((1./factorial(k)).*(((th(i)./2).*(A)).^(k)));
	pd(i)=exp(-th(i)./2).*sum1+(1./A).^(mu-1).*(exp(-th(i)./(2*(1+snr))) -exp(-th(i)./2).*sum2);
    pmd(i)=1-pd(i);
end
plot(p_f,pmd)
hold on
%Pd for rayleigh channel:
snr_pd=10;
snr=10.^(snr_pd./10); %SNR
th=0:0.01:100;
N=10;
p_f=1-gammainc(th./2,N./2);
% p_f=[1:-0.001:0]
pd=[];
A=snr./(1+snr);
mu=N./2;
for i=1:length(p_f)
	k=0:1:mu-2;
	sum1=sum((1./factorial(k)).*(th(i)./2).^(k));
	sum2=sum((1./factorial(k)).*(((th(i)./2).*(A)).^(k)));
	pd(i)=exp(-th(i)./2).*sum1+(1./A).^(mu-1).*(exp(-th(i)./(2*(1+snr))) -exp(-th(i)./2).*sum2);
    pmd(i)=1-pd(i);
end
plot(p_f,pmd,'--')
hold on
%Pd for rayleigh channel:
snr_pd=20;
snr=10.^(snr_pd./10); %SNR
th=0:0.01:100;
N=10;
p_f=1-gammainc(th./2,N./2);
% p_f=[1:-0.001:0]
pd=[];
A=snr./(1+snr);
mu=N./2;
for i=1:length(p_f)
	k=0:1:mu-2;
	sum1=sum((1./factorial(k)).*(th(i)./2).^(k));
	sum2=sum((1./factorial(k)).*(((th(i)./2).*(A)).^(k)));
	pd(i)=exp(-th(i)./2).*sum1+(1./A).^(mu-1).*(exp(-th(i)./(2*(1+snr))) -exp(-th(i)./2).*sum2);
    pmd(i)=1-pd(i);
end
plot(p_f,pmd,':k')
hold off
title('Pmd v/s Pfa for varying SINR');legend('For 5 db','For 10 db','For 20 db');
xlabel('Probability of false alarm');ylabel('Probability of missed detection');