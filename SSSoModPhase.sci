// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoModPhase(In,V)
    // Optical Phase Modulator
    //
    // Calling Sequence
    //  Out=SSSoModPhase(In,V)
    //
    // Parameters
    //   In : Optical Input
    //   V : Electrical Input
    //   Y : Optical Output
    //
    // Description
    // The modulation of the optical field is described by:
    // Out(t) = In(t)·exp(j·V(t))
    //

    [lhs,rhs]=argn(0);
    if rhs<=2 then
        error("Expect at least two arguments");
    end
    Xin=In(:,1); Yin=In(:,2);
    xin=fft(Xin,1);
    yin=fft(Yin,1);
    fxin=atan(imag(xin),real(xin))+%pi*V;
    fyin=atan(imag(yin),real(yin))+%pi*V;
    Out(:,1)=fft(abs(xin).*exp(%i*(atan(imag(xin),real(xin))+%pi*V)),'nonsymmetric');
    Out(:,2)=fft(abs(yin).*exp(%i*(atan(imag(yin),real(yin))+%pi*V)),'nonsymmetric');
endfunction

