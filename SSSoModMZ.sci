// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoModMZ(In,V)
    // Mach-Zehnder Modulator
    //
    // Calling Sequence
    //  Out=SSSoModMZ(In,V)
    //
    // Parameters
    //   In : Optical Input
    //   V : Modulating Signal
    //   Out : Optical Output
    //
    // Description
    // This is a lossless Mach-Zehnder modulator, operates on both polarizations.
    //

    [lhs,rhs]=argn(0);
    if rhs<>2 then
        error("Expect two arguments");
    end
    V1=V/2; V2=-V/2;
    Xin=In(:,1); Yin=In(:,2);
    if length(V2)==0 then; V2=0*V1; else V2=%pi*V2; end;
    V1=%pi*V1;
    Xin=Xin/2; Yin=Yin/2;
    X=abs(Xin).*exp(%i*(atan(imag(Xin),real(Xin))+%pi));
    Y=abs(Yin).*exp(%i*(atan(imag(Yin),real(Yin))+%pi));
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
