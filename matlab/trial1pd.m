function[pdt] = trial1pd(snr_pd)

%Pd for AWGN channel:

%Pd for rayleigh channel:
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
end

pdt=pd(2947);







% L=3;           %consecutive samples
% % y=randn(1,L);
% y=-10^(snr_mat/10)  %Input signal
% r = xcorr(y)  %Auto-correlation of y
% N=length(r)  %number of available samples
% R=toeplitz(r) %sample covariance matrix
% EG=eig(R)
% MX=max(abs(EG)) %Maximum Eigenvalue
% MN=min(abs(EG)) %Minimum Eigenvalue
% Ratio=(MX/MN)/10000 % Maximum-Minimum Eigenvalue ratio
% ftwex=[0 2.73 3.17 3.55 4.00 4.38 4.89 5.52 6.41 7.93] %inverse tracy-widom for exact
% ftwas=[0 2.54 3.07 3.52 3.98 4.44 5.03 5.68 6.66 8.30] %inverse tracy-widom for approx
% pfa=[0:0.1:0.9];
% for i=1:length(pfa)
%     th_sa(i)=((sqrt(N)+sqrt(L))/(sqrt(N)-sqrt(L)))^2*(1+((sqrt(N)+sqrt(L))^-2/3/(N*L)^1/6)*ftwas(i))/10 %Threshold for semi-asymptotic ED
%     th_ex(i)=ftwex(i) %Threshold for exact ED
%     if i==1
%         pdas(i)=0; pdex(i)=0;
%     else if (Ratio>th_sa)
%         pdas(i)=pdas(i-1)+1;
%         end
%     end
%     if i==1
%         pdas(i)=0; pdex(i)=0;
%     else if (Ratio>th_ex)
%         pdex(i)=pdex(i-1)+1;
%     end
%     end
%  end


    
    


