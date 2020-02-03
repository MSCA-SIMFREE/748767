// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoAttenuator(In,Attenuation_dB)
    // Attenuator
    //
    // Calling Sequence
    // Out=SSSoAttenuator(In,Attenuation_dB)
    //
    // Parameters
    //   In : Optical Input
    //   Attenuation_dB : Required attenuation [dB]
    //   Out : Optical Output
    //
    // Description
    // Attenuates the Optical Input by a specified number of decibels.
    // Both polarizations are attenuated equally.

    //
    
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Attenuation_dB=0;
    end
    Out=In/10.^(Attenuation_dB/20);
endfunction
