// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoEDFAgainNoise(In,G_dB,NF_dB)
    // Optical Amplifier
    //
    // Calling Sequence
    //  Out=SSSoEDFAgainNoise(In,G_dB,NF_dB)
    //
    // Parameters
    //   In : Optical Input
    //   G_dB : Small Signal Gain [dB]
    //   G_dB : Noise Figure [dB]
    //   Out : Optical Output
    //
    // Description
    // A simple optical amplifier model with constant gain and white stationary noied added.
    // The amplifier gain is flat with wavelength.
    //

    [lhs,rhs]=argn(0);
    global MNT MNS MSR MLA
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        G_dB=0; NF_dB=0;
    case 2 then
        NF_dB=0;
    end
    NF=10^(NF_dB/10);
    G=10^(G_dB/10);
    c=299792458;
    h=6.62607e-34;
    df=1e9*MSR/MNS;
    L=1e-9*MLA;
    sASE=sqrt(1e3*G*NF*df*h*c/L/4);
    x=complex(grand(MNT,1,'nor',0,sASE),grand(MNT,1,'nor',0,sASE));
    y=complex(grand(MNT,1,'nor',0,sASE),grand(MNT,1,'nor',0,sASE));
    Out=sqrt(G)*In;
    Out(:,1)= Out(:,1)+x;
    Out(:,2)= Out(:,2)+y;
endfunction
