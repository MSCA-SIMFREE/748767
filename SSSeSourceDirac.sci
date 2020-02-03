// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE



function y=SSSeSourceDirac()
    // Electrical Dirac Impulse
    //
    // Calling Sequence
    //  y=SSSeSourceDirac()
    //
    // Parameters
    //   y : Electrical Output
    //
    // Description
    // Generates an electrical impulse at the start of the simulation period. The average level over the entire simulation period is one unit.
    // This component is useful for testing the response of an electrical sub-system.
    //


    global MNT;
    y=zeros(MNT,1);
    y(1,1)=sqrt(MNT);
endfunction
