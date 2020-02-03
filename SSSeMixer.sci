// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Y=SSSeMixer(X,Lo)
    // Optical Mixer
    //
    // Calling Sequence
    //  Y = SSSeMixer(X,Lo)
    //
    // Parameters
    //   X : Optical Input 1
    //   Lo : Optical Input 1
    //   Y : Optical Output
    //
    // Description
    // Mixes two optical signals.
    //

    [lhs,rhs]=argn(0);
    if rhs<=2 then
        error("Expect at least two arguments");
    end
lo=fft(Lo);
flo=atan(imag(lo),real(lo))+90*%pi/180;
y0=abs(lo).*exp(%i*flo);
Y0=fft(y0,1,"nonsymmetric");
Y1=Y0.*X;
y1=fft(Y1);
fy1=atan(imag(y1),real(y1))+90*%pi/180;
y=abs(y1).*exp(%i*fy1);
Y=fft(y,1,"nonsymmetric")+Lo.*X;
endfunction

