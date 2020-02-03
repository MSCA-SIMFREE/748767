// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [y,t0,dt]=SSSeOscilloscope(x)
    // Electrical Oscilloscope
    //
    // Calling Sequence
    //  [y,t0,dt]=SSSeOscilloscope(x)
    //
    // Parameters
    //   x : Electrical Input
    //   t0: Start time = 0
    //   dt : Time step [ns]
    //   Out : Electrical Output
    //
    // Description
    // Old module, not used in new version.
    //

global MDT;
    [lhs,rhs]=argn(0);
    if rhs==0 then
        error("Expect at least one argument");
    end
y=x;
t0=0;
dt=MDT;
endfunction
