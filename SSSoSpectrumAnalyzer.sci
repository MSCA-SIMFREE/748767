// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [x,y]=SSSoSpectrumAnalyzer(In,Freq?)
    // Optical Spectrum Analyzer
    //
    // Calling Sequence
    //  [x,y]=SSSoSpectrumAnalyzer(In,Freq?)
    //
    // Parameters
    //   In : Optical Input
    //   Freq? : If Freq?=True (default) X-axis is plotted in [GHz], otherwise is plotted in [nm]
    //   Out : Optical Output
    //   G : small signal gain [mW]
    //
    // Description
    // Computes the optical power spectral density in mW per bandwidth interval df.
    // The psd is the sum of the psd’s of both polarizations.
    // The bandwidth interval df over which the power is integrated for display, is the frequency spacing between spectral components.
    // This frequency interval is given at the output of the SSSconfig, and is equal to the symbol-rate divided by the code length 2^m.
    //

    global MNT MFR MLA;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Freq?=%T;
    end
    c=299792458;
    MF=[MFR(MNT/2+1:MNT); MFR(1:MNT/2)];
    B=real(In(:,1).*conj(In(:,1))+In(:,2).*conj(In(:,2)));
    B=[B(MNT/2+1:MNT); B(1:MNT/2)];
    if %T then
        x=MF; y=B;
    else
        x=flipdim(1e9*c/(MF(1:128:MNT)+c/(1e-9*MLA)),1);
        y=flipdim(B(1:128:MNT),1);
    end
endfunction
