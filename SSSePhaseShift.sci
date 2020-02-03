// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Y=SSSePhaseShift(X,Phi_deg)
    // Electrical Phase Shift
    //
    // Calling Sequence
    //  Y=SSSePhaseShift(X,Phi_deg)
    //
    // Parameters
    //   X : Electrical Input
    //   Phi_deg : The phase shift, in degrees.
    //   Y : Electrical Output
    //
    // Description
    // Phase shifts the Electrical Input.
    // Operates on the baseband electrical signal.Positive values of Phi_deg advance the phase, negative values retard it.
    // Implemented in the complex frequency domain by multiplying each frequency point by exp(j· phase shift·π/180).
    // This results in an attenuation of the DC component proportional to cos(phase shift·π/l80).
    //

    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Phi_deg=0;
    end
x=fft(X);
y=abs(x).*exp(%i*(atan(imag(x),real(x))+Phi_deg*%pi/180));
Y=fft(y,1,"nonsymmetric");
endfunction
