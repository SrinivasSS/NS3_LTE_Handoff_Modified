function[delay] = trial1delay2(rate)

total_expdelay=[]; %Array to hold expected delays
total_wait=[]; %Array to hold expected wait
final_expque=[];
N=10000;
td=1;g=1;
countpb=0;
counterpb=[];
norm_delay=[];
        counterpb(1)=0;
        total_expdelay(1)=0.0211;
        total_wait(1)=0.0052;
for rho=0.1:0.05:0.9
mtu=1428*8;
myu=(rate)/mtu; 
v=myu*rho; %Lambda
a=1;b=1:N;
%u=[];
    z=50;
    rng(z,'twister')
    f=rng;rng(f);
%     rand('state',z);
    u1=rand(1,N);
    rng(z+10,'twister')
    f=rng;rng(f);
    z=z+1;
%    rand('state',z);
    u2=rand(1,N);
  % u2(a,b)=u1;
  % a=a+1;
% u=mean(u2);
s=-log(u1)/myu;
t=-log(u2)/v;
D=[];
wait=[]; newT=[];
T=cumsum(t);
newT=T;
D(1)=s(1)+T(1);
wait(1)=0;
    for i=2:N
        D(i)=max(T(i),D(i-1))+s(i);
    end
 
asc_s=sort(T,'ascend');
asc_t=sort(D,'ascend');
con=horzcat(asc_t,asc_s);
que=[];
    ascon=sort(con,'ascend');
    for k=1:2*N
         if sum(ascon(k)==asc_s)==1
          if (k == 1)
              que(k)=1;
          else
           que(k)=que(k-1)+1;
              end
          else
             if (k == 1)
                 que(k)=0;
             else
           que(k)=que(k-1)-1;
             end
          end
           if que(k)>20
              que(k)=20;
 if sum(ascon(k)==asc_s)==1
              newT(k)=0;
       end    
               countpb=countpb+1;
           end
           if que(k)<0
               que(k)=0;
           end
    end
    newT=newT(newT~=0);
    delay_new=[];
  for i=2:length(newT)
  wait(i)=max(D(i-1)-   newT(i),0);
delay_new=zeros(1,length(newT));
   end
for i=1:length(newT)
      delay_new(i)=wait(i)+s(i);
end
            cum_delay=cumsum(delay_new);
        
for d=2:length(newT)
    cum_delay(d)=cum_delay(d)/d;
    wait(d)=wait(d)/d;
end

        counterpb(td+1)=countpb/N;
        total_expdelay(td+1)=cum_delay(end);
        total_wait(td+1)=wait(end);

delay(g)=mean(delay_new);
g=g+1;
end