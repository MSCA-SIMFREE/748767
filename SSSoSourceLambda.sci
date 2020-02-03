// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoSourceLambda(Pout_mW,f0_GHz)
    // Optical Source
    //
    // Calling Sequence
    //  Out=SSSoSourceLambda(Pout_mW,f0_GHz)
    //
    // Parameters
    //   Pout_mW : Optical Output Power [mW]
    //   FWHM_ps : Pulse Width FWHM ps]
    //   f0_GHz : Relative Optical Frequency [GHz]
    //   Out : Optical Output
    //
    // Description
    // A tunable optical source with its output in the X-polarization.
    // The spectral linewidth is 0 MHz, i.e. the output is monochromatic.
    //

    global MNT MDT;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        Pout_mW=1,f0_GHz=0;
    case 1 then
        f0_GHz=0;
    end
    Out(:,2)=complex(zeros(MNT,1));
    k=round(MNT*MDT*f0_GHz);
    if k>=0 then; k1=k; else; k1=k+MNT;end
    Out(:,1)=Out(:,2);
    Out(k1+1,1)=complex(sqrt(Pout_mW),0);
endfunction
