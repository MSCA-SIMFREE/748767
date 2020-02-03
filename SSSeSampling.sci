// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [y,Index,MaxCo]=SSSeSampling(x,xref,Index)
    // Sampling and time shifting
    //
    // Calling Sequence
    //  [x,Index,MaxCo]=SSSeSampling(x,xref,Index)
    //
    // Parameters
    //   x : Input Sequence
    //   xref : Reference Sequence
    //   y : Output Sampled Sequence
    //   MaxCo : Maximum Correlation
    //   Index : Index of MaxCo
    //
    // Description
    // Shifts Input Sequence to obtain maximum correlation with oryginal source sequence. Decimate
    //

    global MNS MNT;
    [lhs,rhs] = argn(0);
    if rhs < 2 then error("Expect at least one argument"); end
    m = MNT/MNS;
    k = 2*log2(MNS)*m;//length of correlator
        x1 = x(1:k);
        x1 = [x1;x1];
        Co = zeros(k,1);
        A = real(xref(1:k));
    if rhs < 3 then
        for j = 1:k
            Co(j) = abs(correl(A, real(x1(j:j+k-1))));
        end
        [MaxCo,Index]=max(Co);
    else
        MaxCo = abs(correl(A, real(x1(Index:Index+k-1))));
    end
    Index=Index+m/2;
    x = [x;x];
    x = x(Index:Index+MNT-1);
    y = x(1:m:MNT);
endfunction
