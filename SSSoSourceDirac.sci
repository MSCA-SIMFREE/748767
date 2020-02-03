// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoSourceDirac()
    // Optical Dirac impulse
    //
    // Calling Sequence
    //  Out=SSSoSourceDirac()
    //
    // Parameters
    //   Out : Optical Output
    //
    // Description
    // Generates a single optical Dirac impulse in the time-domain, into both polarizations.
    // This impulse gives a flat optical power spectral density of 1 mW in a bandwidth interval df for both X and Y polarizations.
    // That is, it gives a total power spectral density of 2 mW/df) where df is the Frequency Spacing, in GHz, between spectral points.
    // The flat spectrum of the Optical Impulse makes it useful for measuring the spectral transfer characteristic of linear optical components (e.g. filters, linear fibers, etc.) or subsystems.
    //

    global MNT;
    Out(:,1)=complex(ones(1,MNT));
    Out(:,2)=Out(:,1);
endfunction
