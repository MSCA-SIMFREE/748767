// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [BER,BERt,ydec,serr]=SSSeDecoder(x,s,M,QorP?)
    // PSK/QAM decoder
    //
    // Calling Sequence
    //  [BER,BERt,ydec,serr]=SSSeDecoder(x,s,M,QorP?)
    //
    // Parameters
    //   x : Electrical Input
    //   s : Source Symbols
    //   M : Number of constelation points
    //   QorP? : If QorP?=Q (default) M-QAM decoder, else M-PSK decoder.
    //   BER : Bit Error Rate obtained by counting errors
    //   BERt :  Bit Error Rate calculated from Signal to Noise Ratio
    //   ydec : Error Vector Magnitude
    //   serr : numbers of errored symbols
    //
    // Description
    // Decodes input stream of symbols and calculate BER.
    //


    global MNS MNT MSR;
    [lhs,rhs] = argn(0);
    if rhs < 2 then error("Expect at least one argument"); end
    select rhs
    case 2 then
        M =4; QorP? = "QAM";
    case 3 then
        QorP? = "QAM";
    end
    L = length(s);
    k = floor(L/M);
    b = log2(M);
    y = complex(zeros(k,M));
    [c0,s0] = SSSeCoder((0:M-1)',M, QorP?);
    for m = 1:M
        t = find(s == s0(m));
        y(1:k,m) = x(t);
    end
    y = y';
    c = complex(mean(real(y),'c'),mean(imag(y),'c'));
    P = sqrt(variance(c, "*", %nan));
    c = c/P;
    cFm = atan(imag(c),real(c));
    y = y/P;
    yFm = atan(imag(y),real(y));
    c0Fm = atan(imag(c0),real(c0));
    dFm = c0Fm-cFm;
    dFm = repmat(dFm,1,k);
    ydec = abs(y).*exp(%i*(yFm+dFm));//method 1
    dym = c0 - c;
    dym = repmat(dym,1,k);
    ydec = y + dym;//method 2
    sout = zeros(M,k);
    for m = 1:M
        for j = 1:k
        [n,i] = min(abs(ydec(m,j)-c0));
        sout(m,j) = i-1;
        end
    end
    s0=repmat((0:M-1)',1,k)
    serr = (s0 ~= sout);
    nobe = sum(serr);
    BER = nobe/(L*b);
    c0=repmat(c0,1,k);
    dn = ydec-c0;
    Noise = variance(real(dn), "*", %nan)+variance(imag(dn), "*", %nan);
    Power = variance(real(c0), "*", %nan)+variance(imag(c0), "*", %nan);
    SNR = Power/Noise;
    if part(QorP?,1)=="Q" then
        e = erfc(sqrt(3*SNR/2/(M-1)));
        BERt = 2/b*(1-1/sqrt(M))*e*(1-1/2*(1-1/sqrt(M))*e);
    else
        BERt = erfc(sqrt(SNR)*sin(%pi/M))/b;
    end
    ydec=matrix(ydec,L,1);
    serr=matrix(serr,L,1);
endfunction

