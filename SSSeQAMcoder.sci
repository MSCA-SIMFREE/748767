// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [y,s] = SSSeQAMcoder(x,M)
    xM = 0:M-1;
    b = sqrt(M);
    L = log2(M);
    Kmod = 1/sqrt(2*(M-1)/3);
    yM = zeros(M,L);
    A=ones(1,L);
    B=2.^(L-1:-1:0)
    for n = 1:M
        yM(n,:) = [bitand(xM(n)*A,B)>0];
        yM(n,2:$) = bitxor(yM(n,1:$-1),yM(n,2:$));
    end
    sM = (yM*2 .^(L-1:-1:0)');
    reM = 2*floor(sM/b)-b+1;
    imM = -2*pmodulo(sM,b)+b-1;
    yM = (reM+%i*imM)*Kmod;
    s=sM(x+1);
    y=yM(x+1);
endfunction

