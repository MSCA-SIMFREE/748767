// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function Out=SSSFiberLinear(In,Fiber)
    // Linear Fiber
    //
    // Calling Sequence
    //  Out=SSSFiberLinear(In,Fiber)
    //
    // Parameters
    //   In : Optical Input
    //   Fiber : Fiber Parameters list (Length [km], Attenuation [dB/km], Dispersion [ps/nm/km], Dispersion Slope [ps/nm^2/km])
    //   Out : Optical Output
    //
    // Description
    // This is a model for linear propagation in fiber that is not polarization dependent, i.e. signals propagate the same in both the X and the Y polarizations.
    // The Dispersion Slope describes the change of the dispersion away from the band center.
    // The model employs a frame of reference moving at the group velocity of signals at the center of the optical spectrum; i.e. signals at the center of the optical spectrum experience zero propagation delay.
    //

    global MFR MLA;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Fiber=list(50,0.2,17,0.085);
        z_km=Fiber(1);
        a_dBkm=Fiber(2);
        D_psnmkm=Fiber(3);
        S_ps2nmkm=Fiber(4);
    end
    z_km=Fiber(1);
    a_dBkm=Fiber(2);
    D_psnmkm=Fiber(3);
    S_ps2nmkm=Fiber(4);
    c = 299792458;
    L = 1e-9*MLA;
    z = 1e3*z_km;
    alpha = log(10)*1e-4*a_dBkm;
    D =1e-6 * D_psnmkm;
    S = 1e3 * S_ps2nmkm;
    betap(1) = 0;
    betap(2) = -2*%pi*D*L.^2/c;
    betap(3) =2*%pi* (S*L.^4+2*D*L.^3)/(c^2);
    w =1e9*MFR;
    operL = -alpha/2;
    for ii = 1:length(betap)
        operL = operL - %i*betap(ii)*w.^ii/factorial(ii);
    end
    Out(:,1)= exp(operL*z).*In(:,1);
    Out(:,2)= exp(operL*z).*In(:,2);
endfunction
