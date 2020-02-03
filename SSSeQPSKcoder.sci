// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [Out,bitsFi]=SSSeQPSKcoder()
    global MNT MNS MSR;
    x0=SSSeSourceData();
    x0=2*x0-1;
    x2=[x0;x0];//dekorelacja I i Q
    k=MNT/MNS;
    i=round(3/7*MNS);
    x3=x2(i*k+1:i*k+MNT);//dekorelacja I i Q
    x=complex(x0,x3);
    bits=x(1:k:MNT);
    bitsFi=2*(atan(imag(bits),real(bits)))/%pi+1.5;
    fx=SSSeLPF(atan(imag(x),real(x)),2*MSR);
    x=abs(x).*exp(%i*fx);
    Out(:,1)=fft(x);
    Out(:,2)=zeros(Out(:,1));
endfunction

