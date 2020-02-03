// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [S0,S1,S2,S3,DOP]=SSSoPolAnalyzer(In)
    // Polarization Analyser
    //
    // Calling Sequence
    //  [S0,S1,S2,S3,DOP]=SSSoPolAnalyzer(In)
    //
    // Parameters
    //   In : Optical Input
    //   S0 :
    //   S1 : Stokes S1/S0
    //   S2 : Stokes S2/S0
    //   S3 : Stokes S3/S0
    //   DOP : Degree of Polarization
    //
    // Description
    // Computes the Degree of Polarization and normalized Stokes parameters.
    // The Stokes parameters are a measure of the state of polarization (SOP).
    //
    // Polarization    S1    S2    S3
    // Linear X    1        0    0
    // Linear Y    -1        0    0
    // Linear +45 degs    0        1    0
    // Linear -45 degs    0        -1    0
    // Right CP    0        0    1
    // Left CP    0        0    -1
    // Unpolarized    0        0    0

    //

    [lhs,rhs]=argn(0);
    if rhs==0 then
        error("Expect at least one argument");
    end
    xin=ftt(In(:,1)); yin=ftt(In(:,2));
    ax=abs(xin).^2; ay=abs(yin).^2;
    b=2*conj(xin).*yin;
    s0=ax+ay; s1=ax-ay;
    s2=real(b); s3=imag(b);
    S1=mean(s1/s0); S2=mean(s2/s0); S3=mean(s3/s0);
    DOP=sqrt(s1.^2+s2.^2+s3.^2)/s0;
endfunction
