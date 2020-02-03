// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoSourceSech(Ppeak_mW,FWHM_ps,f0_GHz)
    // Sech Pulse Train
    //
    // Calling Sequence
    //  Out=SSSoSourceSech(Ppeak_mW,FWHM_ps,f0_GHz)
    //
    // Parameters
    //   Ppeak_mW : Peak Power [mW]
    //   FWHM_ps : Pulse Width FWHM ps]
    //   f0_GHz : Relative Optical Frequency [GHz]
    //   Out : Optical Output
    //
    // Description
    // Generates a train of Sech-shaped optical pulses in the X-polarization at a repetition rate equal to the Symbol-Rate set at the SSSconfig.
    // Useful as a source of optical solitons, provided that the optical power of the pulses is related to the dispersion and nonlinearity of the fiber.
    // SSSconfig sets the number of pulses (equal to the number of symbols).
    //

    global MNT MNS MDT;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        Ppeak_mW=5; FWHM_ps=10; f0_GHz=0;
    case 1 then
        FWHM_ps=10; f0_GHz=0;
    case 2 then
        f0_GHz=0;
    end
    function y=shift(x,n)
        N=length(x);
        n=modulo(n,N);
        if n>=0 then
            for i=1:N
                if i+n<=N then; y(i+n)=x(i); else; y(i+n-N)=x(i); end
            end
        else
            for i=1:N
                if i-n<=N then; y(i)=x(i-n); else; y(i)=x(i-n-N); end
            end
        end
        y=y';
    endfunction
    N=round(MNT/MNS);
    t=linspace(0,MDT*(N-1),N);
    t0=t(round(MNT/MNS/2)+1);
    x=1e-3*FWHM_ps;
    B=x/(1.76274716949);
    g=(1 ./cosh((t-t0)/B));
    G=[];
    for i=(1:MNS); G=[G g]; end
    G=fft(sqrt(Ppeak_mW)/MNT*G);
    Out(:,1)=shift(G,f0_GHz*MNT*MDT);
    Out(:,2)=0*Out(:,1);
endfunction
