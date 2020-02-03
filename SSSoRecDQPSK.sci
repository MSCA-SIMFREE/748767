// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function y=SSSoRecDQPSK(In)
    //DQPSK Receiver
    //
    // Calling Sequence
    //  y=SSSoRecDQPSK(In)
    //
    // Parameters
    //   In : Optical Input
    //   y : Output Power [dBm]
    //
    // Description
    // Differential Quadrature Phase Shift Keying  Receiver with LPF at the I and Q outputs.
    //
    //

    global MSR;
    [I,Q]=SSSoCoupler(zeros(In),In);
    D=1/MSR;
    [I1,I2]=SSSoCoupler(I,zeros(I));
    I1=SSSoDelay(I1,D);
    I2=SSSoPhaseShift(I2,45);
    [I1,I2]=SSSoCoupler(I1,I2);
    yI=SSSoDetector(I1)-SSSoDetector(I2);
    yI=SSSeLPF(yI,0.7*MSR);
    [Q1,Q2]=SSSoCoupler(zeros(Q),Q);
    Q1=SSSoDelay(Q1,D);
    Q2=SSSoPhaseShift(Q2,-45);
    [Q1,Q2]=SSSoCoupler(Q1,Q2);
    yQ=SSSoDetector(Q1)-SSSoDetector(Q2);
    yQ=SSSeLPF(yQ,0.7*MSR);
    y=complex(yI,yQ);
endfunction



