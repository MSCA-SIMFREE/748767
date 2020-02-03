// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoPhaseShift(In,Angle_deg)
    // Optical Phase Shift
    //
    // Calling Sequence
    //  Out=SSSoPhaseShift(In,Angle_deg)
    //
    // Parameters
    //   In : Optical Input
    //   Angle_deg : Phase shift [deg]
    //   Out : Optical Output
    //
    // Description
    // Phase shifts the carrier of the Optical Input.
    // Positive values of Angle_deg advance the phase, negative values retard it.
    // Simulates a broadband constant optical phase-shift.
    // It is implemented by multiplying each time-domain value of the (complex) optical waveform by exp(angle·π/l80).
    // This phase shifts the carrier of the optical signal, not the envelope.
    // This function assumes the time-delay associated with a phase shift is negligible.
    // That is, this phase shift does not rotate the waveform within the time window.
    //

    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Angle_deg=0;
    end
    Xin=In(:,1); Yin=In(:,2);
    Out(:,1)=abs(Xin).*exp(%i*(atan(imag(Xin),real(Xin))+Angle_deg*%pi/180));
    Out(:,2)=abs(Yin).*exp(%i*(atan(imag(Yin),real(Yin))+Angle_deg*%pi/180));
endfunction
