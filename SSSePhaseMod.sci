// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Y=SSSePhaseMod(X,V)
    // Electrical Phase Modulator
    //
    // Calling Sequence
    //  Y=SSSePhaseMod(X,V)
    //
    // Parameters
    //   X : Electrical Input
    //   V : Electrical Input
    //   Y : Electrical Output
    //
    // Description
    // The modulation of the electrical field is described by:
    // Y(t) = Ein(X(t))·exp(j·V(t))
    //

    [lhs,rhs]=argn(0);
    if rhs<2 then
        error("Expect at least two arguments");
    end
    Y=abs(X).*exp(%i*(atan(imag(X),real(X))+V));
endfunction

