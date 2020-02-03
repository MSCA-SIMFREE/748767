// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [BER,EyeOpening,Q]=SSSeBERcalculator(x,RecSens_dBm,ASE,Be_GHz,Bo_GHz)
    // BER Calculator
    //
    // Calling Sequence
    //  [BER,EyeOpening,Q]=SSSeBERcalculator(x,RecSens_dBm,ASE,Be_GHz,Bo_GHz)
    //
    // Parameters
    //   x : Electrical Input
    //   RecSens_dBm: The Receiver Sensitivity establishes the level of Gaussian receiver noise that is assumed to be added to the electrical signal after detection. The Receiver Sensitivity is the mean received optical power at which the BER is 10E-9 when there is no background ASE and the received signal has an eye that is completely open with an infinite extinction ratio.
    //   ASE : The power spectral density of ASE that is assumed to be added to noiseless optical signal before detection. The ASE is assumed to be unpolarized.
    //   Be_GHz : Electrical Receiver Bandwidth (GHz). The equivalent bandwidth of the electrical filter after the photodetector.
    //   Bo_GHz : The equivalent bandwidth of the optical filter that would be place before the photodetector. Optical filtering passes the signal, but removes ASE that is out of band. The product of Optical Filter Bandwidth with ASE PSD gives the amount of unpolarized ASE incident on the photodetector.
    //   BER: Bit Error Rate found at the decision time that gives a maximum eye opening. If calculating the BER it is assumed that all levels above the decision threshold are 1's and all those below are 0's. BER is the average of the probability of error over all the bits in the received waveform.
    //   EyeOpening : maximum eye opening. The Eye Opening is taken as the region where half the levels are above the decision threshold (these are assumed to be 1’s) and half are below (these are assumed to be 0’s). Consequently, the data must be balanced, i.e. have equal number of 1’s and 0’s.
    //   Q : The Q Factor corresponds to the estimated BER, where BER=0.5 erfc(Q/sqrt(2)). Returns NaN if the BER is too small to calculate the above.
    //
    // Description
    // The BER Calculator estimates what the BER of a noiseless NRZ/RZ optical signal would be if:
    //    1.a given level of unpolarized ASE was added before the photodetector, and
    //    2.a given level of Gaussian noise was added to the electrical signal after detection.
    //

    global MDT MNT MNS;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        RecSens_dBm=-20; ASE=0; Be_GHz=7.5; Bo_GHz=80;
    case 2 then
        ASE=0; Be_GHz=7.5; Bo_GHz=80;
    case 3 then
        Be_GHz=7.5; Bo_GHz=80;
    case 4 then
        Bo_GHz=80;
    end
    k=MNT/MNS;
    if k>32 then
        k2=k/32;
        x=x(1:k2:$);
        k1=32;
    else
        x=x;
        k1=k;
    end
    b=matrix(x,k1,MNS);
    d=[]
    for n=1:k1
        c=gsort(b(n,:),"g","i");
        d=[d c(MNS/2+1)-c(MNS/2)];
    end
[EyeOpening, k3]=max(d);
b1=b(k3,1:MNS);
b2=gsort(b1,"g","i");
I0=b2(1:MNS/2);
I1=b2(MNS/2+1:$);
sth=10^(RecSens_dBm/10)/6;
Isp=Bo_GHz*ASE;
I0M=max(I0); I1m=min(I1);
s0=sqrt((Isp*(2*I0M+Isp)*Be_GHz/Bo_GHz+sth^2));
s1=sqrt((Isp*(2*I1m+Isp)*Be_GHz/Bo_GHz+sth^2));
Ith=(s0*I1m+s1*I0M)/(s0+s1);
for i=1:length(I0)
    S0=sqrt((Isp*(2*I0+Isp)*Be_GHz/Bo_GHz+sth^2));
    S1=sqrt((Isp*(2*I1+Isp)*Be_GHz/Bo_GHz+sth^2));
    x1=(I1-Ith)./S1;
    x0=(Ith-I0)./S0;
    BER1=1 ./(x1*sqrt(2*%pi)).*exp(-x1.^2/2);
    BER0=1 ./(x0*sqrt(2*%pi)).*exp(-x0.^2/2);
    B=(BER0+BER1)/2;
end
BER=mean(B);
Q=sqrt(2*log(1/(sqrt(2*%pi)*BER)));
endfunction

