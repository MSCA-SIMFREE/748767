// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Iout=SSSoDetector(In,Ideal?)
    // Photodetector
    //
    // Calling Sequence
    //  Iout=SSSoDetector(In,Ideal?)
    //
    // Parameters
    //   In : Optical Input
    //   Ideal? : if False (default) then ideal photodetector
    //   Iout : Electrical Output
    //
    // Description
    // Converts Optical Input power to an Electrical Output waveform by taking the modulus-squared of the Optical Input field of both polarisations.
    // An Optical Input of 1 mW produces an Electrical Output of 1.
    // The photodetector does not add any electrical noise. Receiver noise, if desired, can be added by setting Ideal? = True.
    // The photodetector has a flat bandwidth. An alternative frequency response can be obtained by simply following the photodetector with the appropriate electrical filter.

    global MNT MSR MLA;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Ideal?=%T;
    end
    Xin=fft(In(:,1),1);
    Yin=fft(In(:,2),1);
    x=real(Xin.*conj(Xin));
    y=real(Yin.*conj(Yin));
    Iout=(x+y)*MNT^2;
    if ~Ideal? then
        q=1.6E-19; c=299792458; h=6.62607e-34; kB=1.3806488E-23;
        T=273; RT=20;
        df=1e9*MSR*MNT/MNS;
        R=q/(h*c/(1E-9*MLA));
        Iout=R*Iout;
        sh=sqrt(q*df);
        ShotNoise=sqrt(1E-3*Iout).*grand(MNT,1,'nor',0,sh);
        sT=sqrt(2*kB*T*df)/RT;
        ThermalNoise=grand(MNT,1,'nor',0,sT);
        Iout=Iout+1E3*(ShotNoise+ThermalNoise);
    end
endfunction
