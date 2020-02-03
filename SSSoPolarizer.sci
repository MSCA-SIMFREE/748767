// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [OutX,OutY]=SSSoPolarizer(In,DOP)
    // Polarizer
    //
    // Calling Sequence
    //  [OutX,OutY]=SSSoPolarizer(In,DOP)
    //
    // Parameters
    //   In : Optical Input
    //   DOP : Degree of Polarization
    //   OutX : Optical Output X
    //   OutY : Optical Output Y
    //
    // Description
    //  Passes light of a specific polarization (X/Y) and blocks waves of other polarizations (Y/X).
    //

    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        DOP=1;
    end
    A=sqrt((1+DOP)/2);
    B=sqrt((1-DOP)/2);
    OutX(:,1)=In(:,1)*A;
    OutX(:,2)=In(:,2)*B;
    OutY(:,1)=In(:,1)*B;
    OutY(:,2)=In(:,2)*A;
endfunction
