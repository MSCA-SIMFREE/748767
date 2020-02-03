// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Power_mW=SSSoPowerMeter(In)
    // Optical Power Meter
    //
    // Calling Sequence
    //  Power_mW=SSSoPowerMeter(In)
    //
    // Parameters
    //   In : Optical Input
    //   Power_mW : Average Optical Power [mW]
    //
    // Description
    // Computes the time-averaged optical power (mW) over a simulation period.
    // The powers of both polarizations are included in the Average Optical Power.
    // The Average Optical Power is as measured on an optical power meter with a long averaging time.
    // It is the mean power during the simulated time interval.
    // To measure the power waveform of the optical signal, use the Photodetector followed by the Oscilloscope.
    //

    [lhs,rhs]=argn(0);
    if rhs==0 then
        error("Expect at least one argument");
    end
    Power_mW=sum(real(In).*conj(In));
endfunction
