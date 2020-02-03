// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function y=SSSeEyeOpening(x)
    // Eye Opening
    //
    // Calling Sequence
    //  y=SSSeEyeOpening(x)
    //
    // Parameters
    //   x : Elecrtical Input
    //   y : Max. Eye Opening value
    //
    // Description
    //   The Eye Opening is taken as the region where half the levels are above the decision threshold (these are assumed to be 1’s) and half are below (these are assumed to be 0’s). Consequently, the data must be balanced, i.e. have equal number of 1 ’s and 0’s.
    //


    global MNT MNS;
    [lhs,rhs]=argn(0);
    if rhs==0 then
        error("Expect at least one argument");
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
    y=max(d);
endfunction
