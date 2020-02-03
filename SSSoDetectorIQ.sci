// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [xI, xQ, yI, yQ]=SSSoDetectorIQ(In)
    // Ideal Photodetector
    //
    // Calling Sequence
    //  [xI, xQ, yI, yQ]=SSSoDetectorIQ(In)
    //
    // Parameters
    //   In : Optical Input
    //   xI : in-phase Electrical Output in X polarisation
    //   xQ : quadrature-phase Electrical Output in X polarisation
    //   yI : in-phase Electrical Output in Y polarisation
    //   yQ : quadrature-phase Electrical Output in Y polarisation
    //
    // Description
    // Phisycally not existing device. Provide to easy convert optical field in fiber to electrical components.
    // The photodetector does not add any electrical noise.
    // The photodetector has a flat bandwidth.
    // An alternative frequency response can be obtained by simply following the photodetector with the appropriate electrical filter.

    global MNT;
    x=fft(In(:,1),1);
    xI=real(x).*abs(x)*MNT^2;
    xQ=imag(x).*abs(x)*MNT^2;
    y=fft(In(:,2),1);
    yI=real(y).*abs(y)*MNT^2;
    yQ=imag(y).*abs(y)*MNT^2;
endfunction
