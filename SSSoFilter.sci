// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoFilter(In,B_GHz,fo_GHz,Type)
    // Optical Filter
    //
    // Calling Sequence
    //  Out=SSSoFilter(In,B_GHz,fo_GHz,Type)
    //
    // Parameters
    //   In : Optical Input
    //   B_GHz : FWHM Bandwidth [GHz]
    //   fo_GHz : Center Frequency [GHz]
    //   Type : Sets the response of the optical filter: 0-Lorentzian, 1-Gaussian, 2-Rectangular, 3:7-SuperGaussian m=2:5
    //   Out : Optical Output

    //
    // Description
    // The Optical Filter can be used as the basis of many WDM demultiplexers and multiplexers.
    // It can also be used to improve the performance of amplified system by limiting their noise bandwidth.
    // The Optical Filter operates only on the magnitude of the Optical Input field – it does not modify the phase.
    // Thus it will not show pulse distortion due to dispersion, but it will show pulse distortion due to bandwidth limitation.
    //

    global MNT MNS MFR;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        B_GHz=60; fo_GHz=0; Type=0;
    case 2 then
        fo_GHz=0; Type=0;
    case 3 then
        Type=0;
    end
    select Type
    case 0 then
        g=sqrt(1 ./(1+(MFR-fo_GHz).^2/(B_GHz^2/4)))';
    case 1 then
        g=sqrt(exp(-1/log(sqrt(2)).*((MFR-fo_GHz)/B_GHz).^2))';
    case 2 then
        fg=fo_GHz+B_GHz/2; fd=fo_GHz-B_GHz/2;
        g=ones(MNT,1);
        g(MFR<fd)=0;
        g(MFR>fg)=0;
    case 3 then
        g=sqrt(exp(-((MFR-fo_GHz)/(0.54798*B_GHz)).^4))';
    case 4 then
        g=sqrt(exp(-((MFR-fo_GHz)/(0.53150*B_GHz)).^6))';
    case 5 then
        g=sqrt(exp(-((MFR-fo_GHz)/(0.52344*B_GHz)).^8))';
    case 6 then
        g=sqrt(exp(-((MFR-fo_GHz)/(0.51866*B_GHz)).^10))';
    case 7 then
        k=round(MNT/MNS);
        A=zeros(MNT,1);
        A=[ones(k,1); A];
        A($-k+1:$)=[];
        a=fft(A); g=(a/a(1));
    end
    Out=[g g].*In;
endfunction
