// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function y=SSSeSourceSin(Frequency_GHz, Amplitude)
    // Cosinusoidal Source
    //
    // Calling Sequence
    //  y=SSSeSourceSin(Frequency_GHz, Amplitude)
    //
    // Parameters
    //   Frequency_GHz : Signal Frequency
    //   Amplitude : Amplitude of the output wave
    //   y : Electrical Output

    // Description
    // Generates a cosinusoidal wave = A cos(2π·f·t).
    // The actual frequency used is rounded to the nearest sample point to maintain periodicity over the modeled time window.
    //

    global MNT MDT;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        Frequency_GHz=10; Amplitude=1;
    case 1 then
        Amplitude=1;
    end
    x=round((0.1+MNT)*MDT*Frequency_GHz);
    if MNT/2 < x then;  Amplitude=0; end
    y=zeros(MNT,1);
    for i=1:MNT
        y(i)= Amplitude*sin(2*%pi*x/MNT*(i-1)+%pi*90/180);
    end
endfunction
