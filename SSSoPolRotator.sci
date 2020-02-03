// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoPolRotator(In,Angle_deg)
    // Polarization Rotator
    //
    // Calling Sequence
    //  Out=SSSoPolRotator(In,Angle_deg)
    //
    // Parameters
    //   In : Optical Input
    //   Angle_deg : Degree of Polarization
    //   Out : Optical Output
    //
    // Description
    //  Rotates the polarization of the Optical Input by the Angle_deg.
    //

    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Angle_deg=0
    end
    k=Angle_deg*%pi/180;
    Xin=In(:,1); Yin=In(:,2);
    Out(:,1)=Xin*cos(k)-Yin*sin(k);
    Out(:,2)=Xin*sin(k)+Yin*cos(k);
endfunction
