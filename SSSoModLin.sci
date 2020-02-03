// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoModLin(In,V)
    // Linear Optical Modulator
    //
    // Calling Sequence
    //  Out=SSSoModLin(In,V))
    //
    // Parameters
    //   In : Optical Input
    //   V : Modulating Signal
    //   Out : Optical Output
    //
    // Description
    // Ideal linear lossles modulator operates on both polarizations,
    // The optical power transfer characteristic of the modulator is
    // Out(t) = In(t)·V(t) where V(t) is the Modulating Signal .
    //

    [lhs,rhs]=argn(0);
    if rhs<2 then
        error("Expect at least two arguments");
    end
    Xin=In(:,1); Yin=In(:,2);
    Out(:,1)=fft(fft(Xin,1).*V,'nonsymmetric');
    Out(:,2)=fft(fft(Yin,1).*V,'nonsymmetric');
endfunction
