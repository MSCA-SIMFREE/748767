// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [x2,t]=SSSeEyeDiagram_v1(x,Eyes#frame)
    // Displays as an eye diagram
    //
    // Calling Sequence
    //  SSSeEyeDiagram(x,s)
    //
    // Parameters
    //   x : Elecrtical Input
    //   Eyes#frame: Number of eyes plotted along the x-axis for each time frame.
    //   x2 : output bit frames
    //   t : time vector
    //
    // Description
    // Plots an eye diagram of binary modulated signal. For QAM or PSK modulation use Constellation Plot.
    // The time scale is in ns.
    //

    global MDT MNT MNS;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Eyes#frame=2;
    end
    a=MNT/MNS;
    if a>64 then
        k1=a/64;
        k2=MNT/k1;
        x=x(1:k1:$);
    else
        x=x;
        k1=1;
        k2=MNT;
    end
    k3=k2/MNS;
    x1=x;
    while length(x1)<=k3*Eyes#frame
        x1=[x1;x];
    end
    x1=[x1;x1];
    k4=k3*Eyes#frame+1;
    x2=x1(1:k4);
    for n=1:MNS-1
        x2=[x2,x1(n*k3+1:n*k3+k4)];
    end
    dt=k1*MDT;
    t=repmat((0:k4-1)*dt,MNS,1)';
endfunction
