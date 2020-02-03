// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [BER,BERt,d]=SSSeQAMdecoder(x,s,M)
    c0=SSSeQAMcoder((0:M-1)',M);
    L = length(s);
    k=floor(L/M);
    y=complex(zeros(k,M));
    for m=1:M
        t=find(s==m-1);
        y(1:k,m)=x(t);
    end
    y=conj(y');
    c=complex(mean(real(y),'c'),mean(imag(y),'c'));
    P=sqrt(variance(real(c))+variance(imag(c)));
    cP=c/P;
    cFi=atan(imag(cP),real(cP));
    xP=x/P;
    xFi=atan(imag(xP),real(xP));
    c0Fi=atan(imag(c0),real(c0));
    dFi=mean(c0Fi-cFi);
    c1=abs(cP).*exp(%i*(cFi+dFi));
    x1=abs(xP).*exp(%i*(xFi+dFi));
    d=zeros(L,1);
    for j=1:L
        [n,i]=min(abs(x1(j)-c1));
        d(j)=i-1;
    end
    be=(s~=d);
    nobe =sum(be);
    b=log2(M);
    BER=nobe/(L*b);
    plot2d(real(x1),imag(x1),0);
    plot2d(real(x1(be)),imag(x1(be)),-9);
    a=gca();
    poly1= a.children(1).children(1);
    poly1.mark_foreground = 5;
    poly1.mark_background = 0;
    poly1.mark_size = 0;
    plot2d(real(c1),imag(c1),-9);
    a=gca();
    poly1= a.children(1).children(1);
    poly1.mark_foreground = 1;
    poly1.mark_background = 1;
    poly1.mark_size = 0;
    x2=complex(zeros(L,1));
    for j=1:L
        x2(j)=c1(s(j)+1);
    end
    dn=x1-x2;
    Noise=variance(real(dn))+variance(imag(dn));
    Power=variance(real(x2))+variance(imag(x2));
    SNR=Power/Noise;
    SNRdB=10*log10(SNR);
    e=erfc(sqrt(3*SNR/2/(M-1)));
    BERt=2/b*(1-1/sqrt(M))*e*(1-1/2*(1-1/sqrt(M))*e);
endfunction
