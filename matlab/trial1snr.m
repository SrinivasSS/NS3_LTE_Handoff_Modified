function[snr] = trial1snr(Rl)

hl=gamrnd(2,1,1,1); %Gamma rnd variable for Nakagami small scale fading
ho=gamrnd(1,1,1,1); %Gamma rnd variable for Nakagami small scale fading
% e=exp(-11.43*135);
prlos=binornd(1,0.8); %Probability of connecting to LOS BS
if prlos==1
    prnlos=0; %Probability of connecting to NLOS BS
    else prnlos=1;
end
Ro=1; %Receiver at origin
Mr=10;%E-3; %Main lobe power at receiver
Mt=12.6;%E-3; %Main lobe power at transmitter
sgm=0.6;%8*power(10,-11); %Thermal Noise
Dl=281.83; %Directivity gain
Et=10; %Et=Mt/mt Front to back ratio
lro=prlos*79.2*(Ro^(-2))+prnlos*2.6*(Ro^(-4)); %Pathloss 
lrl=prlos*79.2*(Rl^(-2))+prnlos*2.6*(Rl^(-4));

Nr=ho*Mr*lro;
Dr=(sgm^2/Mt)+(Dl*Et*hl*lrl);
snr=Nr/Dr;
