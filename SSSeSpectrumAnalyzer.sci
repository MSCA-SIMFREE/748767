// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [y,f0,df]=SSSeSpectrumAnalyzer(x)
    // Electrical Spectrum Analyzer
    //
    // Calling Sequence
    //  [y,f0,df]=SSSeSpectrumAnalyzer(x)
    //
    // Parameters
    //   x : Electrical Input
    //   y : Electrical Output
    //   f0 : f0 = 0
    //   df : Frequency spacing between the spectral components
    //
    // Description
    // Computes the single-sided power spectral density in input signal units RMS squared per bandwidth interval.
    // The bandwidth interval is the frequency spacing between the spectral components, df. This frequency interval is given at the output of the SSSconfig, and is equal to the symbol-rate divided by the code length 2^m.
    // The component at 0 GHz (DC) gives the average power in the signal.
    //


global MNT MNS MDT;
    [lhs,rhs]=argn(0);
    if rhs==0 then
        error("Expect at least one argument");
    end
X=fft(x);
y=abs(X)/MNT;
y=y(1:MNT/2+1);
f0=0;
df=MSR/MNS;
endfunction
