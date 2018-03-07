# LTE_Handoff_Modified
An modified algorithm to implement an integrated QoS metric based handoff in LTE systems using NS3
The modified handoff algorithm takes the variance of the SINR and the probability of missed detection into consideration when making a handoff.
The resulting algorithm has the potential to reduce the number handoffs performed as compared to the conventional handoff method of only taking the signal strength and hysteresis into account.
This repository has the code for 2 implementations of the project. One in Matlab and the other in the NS3 LENA software.

MATLAB:
The Matlab implementation was done to implement the handoff in a mmWave radio propagation model based on the work done by R.Health and T.Bai from the university of Austin, Texas in the paper titled 'Coverage and Rate Analysis for Millimeter-Wave Cellular Networks', IEEE TRANSACTIONS ON WIRELESS COMMUNICATIONS, VOL. 14, NO. 2, FEBRUARY 2015.

NS3:
The handoff was also implemented in a LTE propagation model using the NS3 LENA software. The modifed algorithm was compared to the native NS3 handoff called the strongest cell or A3 handoff procedure. The 'scratch' folder contains the code required to implement the NS3 program. Copy and paste it inside the repos/ns-allinone3.26/ns-3.26 folder while replacing the older scratch folder.

Results:
A reduction was found in the number of handoffs performed. Additionally this leads to a decrease in the mean delay, mean packet loss and the mean sum of jitter. The improvement in the mmWave scenario in Matlab was found to be more as compared to the LTE scenario using NS3.
