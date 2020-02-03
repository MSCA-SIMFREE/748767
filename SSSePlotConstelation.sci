// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function SSSePlotConstelation(xdec,serr,M,c)
    // Plots Constelation
    //
    // Calling Sequence
    //  SSSePlotConstelation(xdec,serr,M,c))
    //
    // Parameters
    //   xdec : Points from decoder
    //   serr : Erroneous points from decoder
    //   M : Number of constelation points
    //   c : Constelation points
    //
    // Description
    // Plots constelation. Erroneous points in red circles.
    //

    [lhs,rhs] = argn(0);
    if rhs < 2 error("Expect at least two arguments"); end
    select rhs
    case 2 then
        M = 4; c = SSSeQAMcoder((0:M-1)',M);
    case 3 then
        c = SSSeQAMcoder((0:M-1)',M);
    end
    plot2d(real(xdec),imag(xdec),0,rect=[-1.5, -1.5, 1.5, 1.5]);
    plot2d(real(xdec(serr)),imag(xdec(serr)),-9,rect=[-1.5, -1.5, 1.5, 1.5]);
    a1=gca();
    a1.isoview="on"
    poly1= a1.children(1).children(1);
    poly1.mark_foreground = 5;
    poly1.mark_background = 0;
    poly1.mark_size = 0;
    plot2d(real(c),imag(c),-9,rect=[-1.5, -1.5, 1.5, 1.5]);
    a2=gca();
    poly1= a2.children(1).children(1);
    poly1.mark_foreground = 1;
    poly1.mark_background = 1;
    poly1.mark_size = 0;
endfunction
