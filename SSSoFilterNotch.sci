// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoFilterNotch(In,B_GHz,fo_GHz,Type)
    // Optical Notch Filter
    //
    // Calling Sequence
    //  Out=SSSoFilterNotch(In,B_GHz,fo_GHz,Type)
    //
    // Parameters
    //   In : Optical Input
    //   B_GHz : FWHM Bandwidth [GHz]
    //   fo_GHz : Center Frequency [GHz]
    //   Type : Sets the response of the optical filter: 0-Lorentzian, 1-Gaussian, 2-Rectangular, 3:7-SuperGaussian m=2:5
    //   Out : Optical Output

    //
    // Description
    // The same parameters as Optical Filter but cuts specified band.
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
        g=sqrt(1 ./(1+(MFR-fo_GHz).^2/(B_GHz^2/4)));
    case 1 then
        g=sqrt(exp(-1/log(sqrt(2)).*((MFR-fo_GHz)/B_GHz).^2));
    case 2 then
        g=[];
        fg=fo_GHz+B_GHz/2; fd=fo_GHz-B_GHz/2;
        for i=1:length(MFR)
            if MFR(i)>=fd then
                if MFR(i)<=fg then; g=[g;1]; else g=[g;0] ; end
            else; g=[g;0];
            end
        end
    case 3 then
        g=sqrt(exp(-((MFR-fo_GHz)/(0.54798*B_GHz)).^4));
    case 4 then
        g=sqrt(exp(-((MFR-fo_GHz)/(0.53150*B_GHz)).^6));
    case 5 then
        g=sqrt(exp(-((MFR-fo_GHz)/(0.52344*B_GHz)).^8));
    case 6 then
        g=sqrt(exp(-((MFR-fo_GHz)/(0.51866*B_GHz)).^10));
    case 7 then
        k=round(MNT/MNS);
        A=zeros(MNT,1);
        A=[ones(k,1); A];
        A($-k+1:$)=[];
        a=fft(A); g=(a/a(1));
    end
    g=1+%eps*3 -g;
    Out=[g g].*In;
endfunction
