// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [zX,zY] = SSSeIQcohrec2pol(X,Phet)
    // Coherent receiver of X and Y polarized optical signals
    //
    // Calling Sequence
    //  [zX,zY] = SSSeIQcohrec2pol(X,Phet)
    //
    // Parameters
    //   X : Optical Input
    //   Phet : Power [mW] of local heterodyne laser
    //   zX : Electrical Output of X polarisation. Complex vector I+jQ.
    //   zY : Electrical Output of Y polarisation. Complex vector I+jQ.
    //
    // Description
    // Complete coherent receiver with two double balanced detectors and local heterodyne laser.
    // Receives X and Y polarized optical signals.
    //

    [lhs,rhs] = argn(0);
    if rhs < 1 then
        error("Expect at least one argument");
        end
    if rhs == 1 then
        Phet = 10;
    end
    [X1,Y] = SSSoPolarizer(X);
    zX = SSSeIQcohrec1pol(X1,Phet);
    zY = SSSeIQcohrec1pol(Y,Phet);
endfunction
