// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoCombiner4x1(In1,In2,In3,In4)
    // 4x1 Combiner
    //
    // Calling Sequence
    //  Out=SSSoCombiner4x1(In1,In2,In3,In4)
    //
    // Parameters
    //   In1 : Optical Input 1
    //   In2 : Optical Input 2
    //   In3 : Optical Input 3
    //   In4 : Optical Input 4
    //   Out : Optical Output
    //
    // Description
    // The 4x1 Combiner sums the four Optical Inputs. There is no loss between any input and the output.
    // This combiner adds all of the inputs without loss.
    // In practice, lossless coupling can only be achieved if the transfer function is frequency selective, for example, if the combiner is implemented using an AWGM or a grating. If a broadband combiner is being modeled, then an additional 6-dB of loss should be included in the simulation.
    //

    [lhs,rhs]=argn(0);
    if rhs~=4 then
        error("Expect four arguments");
    end
    Out=In1+In2+In3+In4;
endfunction
