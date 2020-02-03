// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoModMZduo(In,V1, V2)
    // Dual Electrode Mach-Zehnder Modulator
    //
    // Calling Sequence
    //  Out=SSSoModMZduo(In,V1, V2)
    //
    // Parameters
    //   In : Optical Input
    //   V1 : Modulating Signal 1
    //   V2 : Modulating Signal 2
    //   Out : Optical Output
    //
    // Description
    // This is a lossless Dual Electrode Mach-Zehnder modulator, operates on both polarizations.
    // If an Modulating Signal is not connected it is assumed to be zero.
    //

    [lhs,rhs]=argn(0);
    if rhs<2 then
        error("Expect at least two arguments");
    end
    if length(V2)==0 then; V2=0*V1; else V2=%pi*V2; end;
    V1=%pi*V1;
    Xin=In(:,1)/2; Yin=In(:,2)/2;
    X=abs(X).*exp(%i*(atan(imag(Xin),real(Xin))+%pi));
    Y=abs(Y).*exp(%i*(atan(imag(Yin),real(Yin))+%pi));
    x=fft(X,1);
    y=fft(Y,1);
    xin=fft(Xin,1);
    yin=fft(Yin,1);
    xin1=abs(xin).*exp(%i*(atan(imag(xin),real(xin))+V1));
    yin1=abs(yin).*exp(%i*(atan(imag(yin),real(yin))+V1));
    Xin=fft(xin1)+%eps*%i;
    Yin=fft(yin1)+%eps*%i;
    x1=abs(x).*exp(%i*(atan(imag(x),real(x))+V2));
    y1=abs(y).*exp(%i*(atan(imag(y),real(y))+V2));
    Out(:,1)=fft(x1)+Xin+%eps*%i;
    Out(:,2)=fft(y1)+Yin+%eps*%i;
endfunction
