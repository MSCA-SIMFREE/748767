// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoPolDelay(In,Delay_ps)
    // Polarization Delay
    //
    // Calling Sequence
    //  Out=SSSoPolDelay(In,Delay_ps)
    //
    // Parameters
    //   In : Optical Input
    //   Delay_ps : Delay of the X-polarization [ps]
    //   Out : Optical Output
    //
    // Description
    // Delays the X-polarization component of the Optical Input by a specified Time Delay.
    // Negative values will advance the X-component.
    //

    global MFR;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Delay_ps=0
    end
    Xin=In(:,1); Yin=In(:,2);
    Out(:,1)=In(:,1);
    Out(:,2)=abs(Yin).*exp(%i*(atan(imag(Yin),real(Yin))+Delay_ps*2e-3*%pi*MFR));
endfunction
