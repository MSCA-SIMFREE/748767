// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSoSourceGauss(Ppeak_mW,FWHM_ps,f0_GHz,Order)
    // Gaussian Pulse Train
    //
    // Calling Sequence
    //  Out=SSSoSourceGauss(Ppeak_mW,FWHM_ps,f0_GHz,Order)
    //
    // Parameters
    //   Ppeak_mW : Peak Power [mW]
    //   FWHM_ps : Pulse Width FWHM ps]
    //   f0_GHz : Relative Optical Frequency [GHz]
    //   Out : Optical Output
    //
    // Description
    // Generates a train of Gaussian-shaped optical pulses in the X-polarization at a repetition rate equal to the Symbol-Rate set at the SSSconfig.
    // Useful as a source with a Gaussian profile and spectral envelope, for comparison with analytical approximations.
    // SSSconfig sets the number of pulses (equal to the number of symbols).
    //

    global MNT MNS MDT;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        Ppeak_mW=5,FWHM_ps=10,f0_GHz=0;Order=1;
    case 1 then
        FWHM_ps=10,f0_GHz=0;Order=1;
    case 2 then
        f0_GHz=0;Order=1;
    case 3 then
        Order=1;
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
select Order
  case 1 then
  B=x*sqrt(log(sqrt(2))); g=sqrt(exp(-((t-t0)/B).^2));
  case 2 then
  B=0.54798*x; g=sqrt(exp(-((t-t0)/B).^4));
  case 3 then
  B=0.53150*x; g=sqrt(exp(-((t-t0)/B).^6));
  case 4 then
  B=0.52344*x; g=sqrt(exp(-((t-t0)/B).^8));
  case 5 then
  B=0.51866*x; g=sqrt(exp(-((t-t0)/B).^10));
end
G=[];
for i=(1:MNS); G=[G g]; end
G=fft(sqrt(Ppeak_mW)/MNT*G);
Out(:,1)=shift(G,f0_GHz*MNT*MDT);
Out(:,2)=0*Out(:,1);
endfunction
