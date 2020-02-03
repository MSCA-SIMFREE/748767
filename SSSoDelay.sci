// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoDelay(In,Delay_ns,PhaseRotat?)
    // Optical Delay
    //
    // Calling Sequence
    //  Out=SSSoDelay(In,Delay_ns,PhaseRotat?)
    //
    // Parameters
    //   In : Optical Input
    //   Delay_ns : Delay of Optical Input [ns]
    //   PhaseRotat? : if False (default) optical waveform phase is fixed
    //   Out : Optical Output
    //
    // Description
    // If the Delay is negative then the Optical Input is advanced.
    // The delay will rotate the optical waveform within the time-window.
    // This simulates a variable optical delay, such as a moving mirror.
    // The delay is implemented by adding an optical-frequency-dependent phase shift to the optical signal in the frequency domain. Thus, the delay can be a fraction of a time-step.
    // Use the Optical Phase Shift component when you require a frequency independent control of the optical carrier phase, with zero delay.
    //

    global MFR MLA;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Delay_ns=0, PhaseRotat?=%F;
    case 2 then
        PhaseRotat?=%F;
    end
    fX=atan(imag(In(:,1)),real(In(:,1)))-2*%pi*Delay_ns*MFR;
    rX=sqrt(In(:,1).*conj(In(:,1)));
    Out(:,1)=rX.*exp(%i*fX);
    fY=atan(imag(In(:,2)),real(In(:,2)))-2*%pi*Delay_ns*MFR;
    rY=sqrt(In(:,2).*conj(In(:,2)));
    Out(:,2)=rY.*exp(%i*fY);
    if PhaseRotat? then
        c=299792458; k=Delay_ns*360*c/L;
        fX=atan(imag(Out(:,1)),real(Out(:,1)))+k*%pi/180;
        rX=sqrt(Out(:,1).*conj(Out(:,1)));
        Out(:,1)=rX.*exp(%i*fX);
        fY=atan(imag(Out(:,2)),real(Out(:,2)))+k*%pi/180;
        rY=sqrt(Out(:,2).*conj(Out(:,2)));
        Out(:,2)=rY.*exp(%i*fY);
    end
endfunction

