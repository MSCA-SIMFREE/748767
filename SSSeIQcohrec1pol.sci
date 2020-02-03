// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function z = SSSeIQcohrec1pol(X,Phet)
    // Coherent receiver of X polarized optical signal
    //
    // Calling Sequence
    //  z = SSSeIQcohrec1pol(X,Phet)
    //
    // Parameters
    //   X : Optical Input
    //   Phet : Power [mW] of local heterodyne laser
    //   z : Electrical Output of X polarisation. Complex vector I+jQ.
    //
    // Description
    // Complete coherent receiver with double balanced detectors and local heterodyne laser.
    // Receives X polarized optical signal.
    //

    [lhs,rhs] = argn(0);
    if rhs < 1 then
        error("Expect at least one argument");
        end
    if rhs == 1 then
        Phet = 10;
    end
    [X,X2] = SSSoCoupler([],X);
    X = SSSoPhaseShift(X,90);
    H = SSSoSourceLambda(Phet,0);
    H = SSSoPolRotator(H,45);
    [H,H2] = SSSoCoupler([],H);
    [X,H] = SSSoCoupler(X,H);
    [X2,H2] = SSSoCoupler(X2,H2);
    z = complex(SSSoDetector(X)-SSSoDetector(H),SSSoDetector(X2)-SSSoDetector(H2));
endfunction
