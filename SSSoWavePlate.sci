// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoWavePlate(In,Retardation_deg)
    // Wave Plate
    //
    // Calling Sequence
    //  Out=SSSoWavePlate(In,Retardation_deg)
    //
    // Parameters
    //   In : Optical Input
    //   Retardation_deg : Retardation between the Fast and Slow Axes [deg]
    //   Out : Optical Output
    //
    // Description
    // This is a variable wave plate. It retards one polarization with respect to the orthogonal polarization.
    // The fast axis is aligned with the X-axis.
    // The Retardation sets the relative phase delay between the fast and slow axes:
    //    1    =    Full-Wave Plate
    //    0.5    =    Half-Wave Plate
    //    0.25    =    Quarter Wave-Plate
    //

    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Retardation_deg=0
    end
Xin=In(:,1); Yin=In(:,2);
Out(:,1)=abs(Xin).*exp(%i*(atan(imag(Xin),real(Xin))+Retardation_deg*2*%pi));
Out(:,2)=In(:,2);
endfunction
