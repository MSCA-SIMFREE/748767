// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [Out1,Out2]=SSSoCoupler(In1,In2,Coupling)
    // Optical Coupler
    //
    // Calling Sequence
    //  [Out1,Out2]=SSSoCoupler(In1,In2,Coupling)
    //
    // Parameters
    //   In1 : Optical Input 1
    //   In2 : Optical Input 2
    //   Coupling : Percentage of power coupled across the coupler
    //   Out1 : Optical Output 1
    //   Out2 : Optical Output 2
    //
    // Description
    // Cross-coupled fields experience a 90-degree phase lag with respect to through coupled fields.
    // The input parameter Coupling sets the % of power that is coupled across the coupler, i.e. from input 1 (2) to  output 2 (1).
    // An example of the use of the Coupler component is in simulating Mach-Zehnder interferometers.
    // A lossy coupler can be formed by adding Attenuators to its inputs or outputs.
    //

    global MNT;
    [lhs,rhs]=argn(0);
    if rhs<2 then
        error("Expect at least two argument");
        end
    if rhs==2 then
        Coupling=50;
    end
    if length(In1)==0 then; In1=zeros(MNT,2); end
    if length(In2)==0 then; In2=zeros(MNT,2); end
    A=sqrt(Coupling/100);
    B=sqrt(1-Coupling/100);
    Out1=In1*B+SSSoPhaseShift(In2*B, 90);
    Out2=SSSoPhaseShift(In1*A, 90)+In2*A;
endfunction
