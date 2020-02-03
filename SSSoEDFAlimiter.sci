// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [Out,G]=SSSoEDFAlimiter(In,P_dBm)
    // A simple optical limiter.
    //
    // Calling Sequence
    //  [Out,G]=SSSoEDFAlimiter(In,P_dBm)
    //
    // Parameters
    //   In : Optical Input
    //   P_dBm : Output Power [dBm]
    //   Out : Optical Output
    //   G : Small Signal Gain [mW]
    //
    // Description
    // A simple optical amplifier model with constant output DC power.
    // The amplifier gain is flat with wavelength.
    //

    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        P_dBm=0;
    end
    Pwr=sum(real(In(:,1).*conj(In(:,1))+In(:,2).*conj(In(:,2))));
    //Pwr=sum(abs(In(:,1)).^2+abs(In(:,2)).^2);
    G=10^(P_dBm/10)/Pwr;
    Out=In*sqrt(G);
endfunction
