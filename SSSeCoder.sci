// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [y,s,c] = SSSeCoder(x,M,QorP?)
    // PSK/QAM coder
    //
    // Calling Sequence
    //  [y,s,c] = SSSeCoder(x,M,QorP?)
    //
    // Parameters
    //   x : Electrical Input
    //   M : Number of constelation points
    //   QorP? : If QorP?=Q (default) M-QAM coder, else M-PSK coder.
    //   y : Elecrtical Output
    //   s : Symbols Output
    //   c : Constelation Output
    //
    // Description
    // Codes input stream of symbols in Gray code and generates constelation points.
    //


    [lhs,rhs] = argn(0);
    select rhs
    case 1 then
        error("Expect at least one argument");
    case 2 then
       QorP? = "QAM";
    end
    xM = 0:M-1;
    b = sqrt(M);
    L = log2(M);
    yM = zeros(M,L);
    A=ones(1,L);
    B=2.^(L-1:-1:0)
    for n = 1:M
        yM(n,:) = [bitand(xM(n)*A,B)>0];
        yM(n,2:$) = bitxor(yM(n,1:$-1),yM(n,2:$));
    end
    sM = (yM*2 .^(L-1:-1:0)');
    if part(QorP?,1) == "Q" then
        reM = 2*floor(sM/b)-b+1;
        imM = -2*pmodulo(sM,b)+b-1;
        Kmod = 1/sqrt(2*(M-1)/3);
        yM = (reM+%i*imM)*Kmod;
    else
        yM = exp(%i*2*%pi/M*(sM+0.5));
    end
    s=sM(x+1);
    y=yM(x+1);
    c=yM(xM'+1)
endfunction


