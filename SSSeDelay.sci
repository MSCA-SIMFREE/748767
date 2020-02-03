// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function y=SSSeDelay(x,TimeDelay_ns)
    // Delays the Electrical Input
    //
    // Calling Sequence
    //  y=SSSeDelay(x,TimeDelay_ns)
    //
    // Parameters
    //   x : Electrical Input
    //   TimeDelay_ns : The value, in ns, that the Electrical Input is delayed.
    //   y : Electrical Output
    //
    // Description
    // Simulates a variable electrical delay. The delay can be a fraction of a time-step.
    // Has no effect on the DC content of the signal.
    // If the delay is negative then the input is advanced in time.
    // The delay is implemented in the frequency-domain by multiplying each frequency-point by a phase shift proportional to the electrical frequency and the delay.
    //

    global MFR;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        TimeDelay_ns=0;
    end
X=fft(x);
fX=atan(imag(X),real(X))-2*%pi*TimeDelay_ns.*MFR;
Y=abs(X).*exp(%i*fX);
y=real(fft(Y,1,"symmetric"));
endfunction

