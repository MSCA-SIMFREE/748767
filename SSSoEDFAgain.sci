// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [Out,P_dBm]=SSSoEDFAgain(In,G_dB)
    // A simple optical amplifier
    //
    // Calling Sequence
    //  [Out,P_dBm]=SSSoEDFAgain(In,G_dB)
    //
    // Parameters
    //   In : Optical Input
    //   Out : Optical Output
    //   G_dB : small signal gain [dB]
    //   P_dBm : output power [dBm]
    //
    // Description
    // A simple optical amplifier model with constant gain
    // The amplifier gain is flat with wavelength.
    //

    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        G_dB=0;
    end
    Pin=sum(real(In.*conj(In)));
    G=sqrt(10^(G_dB/10));
    Out=G*In;
    P_dBm=10*log10(G*Pin);
endfunction
