// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE

function [SamplePoints,FrequencySpacing,ActualBandwidth,SequenceDuration]=SSSconfig(BitRate_GHz, Bandwith_GHz,CodeLength_to2, CenterWavelength_nm, Auto?)
    // Sets main parameters of simulation
    //
    // Calling Sequence
    //  [SamplePoints,FrequencySpacing,ActualBandwidth,SequenceDuration]=SSSconfig(BitRate_GHz, Bandwith_GHz,CodeLength_to2, CenterWavelength_nm, Auto?)
    //
    // Parameters
    //   SymbolRate_GHz : The symbol-rate (Gbaud) for the system simulation.
    //   Bandwith_GHz : The bandwidth (GHz) required for the simulation. The bandwidth must be sufficiently wide to contain the spectra of all signals. However, do not make this unnecessarily large as it will slow the calculation and use more memory.
    //   CodeLength_to2 : = 2^m. m sets the code length of all symbol sequences used in the simulation to be 2^m, m = 0 to 10. The actual code sequence to be used must be specified in the Data Source component. Note: try to keep codes short to reduce memory requirement and computation time.
    //   CenterWavelength_nm : The wavelength (nm) that corresponds to the center (i.e. 0 GHz) of the simulated optical spectrum. Optical frequencies are referenced in GHz offset from the Center Wavelength.
    //   Auto? : If Auto? = True (defalut) ActualBandwidth is automatically increased to provide a convenient number of integer samples per bit.
    //   SamplePoints : The number of points used to sample the waveforms and optical spectra in the simulation.
    //   FrequencySpacing : The frequency spacing between spectral components. It is given by Symbol-Rate divided by code-length.
    //   ActualBandwidth : The bandwidth actually used in the simulation.
    //   SequenceDuration : The duration (ns) of the time sequences used in the simulations. It is a product of symbol-period and code length.
    //
    // Description
    // A SSSconfig is required for all symulations. It sets the simulated period and the simulation accuracy, and derives the time and frequency intervals.
    // The SSSconfig executes at the start of the simulation and determines global parameters: MSR, MDT, MNT, MNS, MFR, MLA that are automatically used by other components during the simulation.

    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        BitRate_GHz=10; Bandwith_GHz=200; CodeLength_to2=5;..
        CenterWavelength_nm=1550; Auto?=%T;
    case 1 then
        Bandwith_GHz=200; CodeLength_to2=5;..
        CenterWavelength_nm=1550; Auto?=%T;
    case 2 then
        CodeLength_to2=5; CenterWavelength_nm=1550; Auto?=%T;
    case 3 then
        CenterWavelength_nm=1550; Auto?=%T;
    case 4 then
        Auto?=%T;
    end
    MSR=BitRate_GHz;
    MLA=CenterWavelength_nm;
    MNS=2^CodeLength_to2;
    FrequencySpacing=MSR/MNS;
    SequenceDuration=1/FrequencySpacing;
    if Auto? then
        ActualBandwidth=MSR*2^ceil(log2(Bandwith_GHz/MSR));
    else
        ActualBandwidth=MSR*2*ceil(Bandwith_GHz/MSR/2);
    end
    MDT=1/ActualBandwidth;
    MNT=MNS*ActualBandwidth/MSR;
    SamplePoints=MNT;
    MFR=[0:MNT/2 -MNT/2+1:-1]'*FrequencySpacing;
    
    global MSR MDT MNT MNS MFR MLA;
endfunction

