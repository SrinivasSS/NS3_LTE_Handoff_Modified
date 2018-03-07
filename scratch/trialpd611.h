#include <iostream>
#include<cstdlib>
#include<stdio.h>
#include<math.h>
#include <ns3/lte-handover-algorithm.h>
#include <ns3/lte-handover-management-sap.h>
#include <ns3/lte-rrc-sap.h>
#include <ns3/nstime.h>

using namespace ns3;

class trialpd611{
public:

//To calculate  variance
void cal_variance(double x[], int size){ //Taking array for variance
double mean=0; double var=0; int i;
std::cout<<"Entering cal_variance..."<<endl;
for(i=0;i<size;i++){
	mean=mean+x[i];
	}
	mean=mean/i;
for (i=0;i<size;i++){
	var=var+((x[i]-mean)*(x[i]-mean));
	}
	var=var/i;
std::cout<<"Mean= "<<mean<<endl<<"Variance= "<<var<<endl;
}

double fact(double f){ //To calculate factorial
if(f==1 || f==0){
return 1;
}
else{
return f*fact(f-1);
}
}
double sumnr(double m, double thsum){ //To calculate summation
//std::cout<<"Hello";
int k; double sum=0;
for (k=0;k<=(m-2);k++){
	sum=sum + pow(thsum,k)/fact(k);
	}
return sum;
}

//To calculate Pmd
double cal_pmd(double sinr_db){ //Taking sinr in db
	double sinr=pow(10,sinr_db/10);
	double A=sinr/(1+sinr);
	int N=10; //Number of samples
	int mu=N/2;
	double th=5; //Desired threshold
	double sumthresh=th/2;
	double Asum1=sumnr(mu,sumthresh);
	sumthresh=A*th/2;
	double Asum2=sumnr(mu,sumthresh);
	double pd=exp(-th/2)*Asum1 + pow(A,mu-1)*exp(-th/(2*(1+sinr))) - exp(-th/2)*Asum2;
	std::cout<<endl<<"Probability of detection: "<<pd;
	double pmd=1-pd;
	std::cout<<endl<<"Probability of missed detection: "<<pmd<<endl;
return pmd;
}
};
