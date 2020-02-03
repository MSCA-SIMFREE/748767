// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [Out,Steps_km]=SSSFiberLEM(In, Fiber, StepCtrl, g_Wkm, ShowDist?)
    // Nonlinear Fiber
    //
    // Calling Sequence
    //  [Out,Steps_km]=SSSFiberLEM(In, Fiber, StepCtrl, g_Wkm, ShowDist?)
    //
    // Parameters
    //   In : Optical Input
    //   Fiber : Fiber Parameters list (Length [km], Attenuation [dB/km], Dispersion [ps/nm/km], Dispersion Slope [ps/nm^2/km])
    //   StepCtrl : Step control list (min. accurancy, max. initial step [m])
    //   g_Wkm: Nonlinearity coefficient [1/W/km]
    //   ShowDist? : If ShowDist? = True  simulation progress is shown in a box.
    //   Out : Optical Output
    //   Steps_km : Simulation steps output [km]
    //
    // Description
    // This is similar to the SSSFiberLinear component, but in addition it models Kerr nonlinearity  for fields in the X-polarization state of the fiber.
    // Fields in the Y-polarization are simply propagated linearly.
    // Split Step Fourier Local Error Method (LEM) is used.
    //

    global MNT MDT MLA;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Fiber=list(50, 0.2, 17, 0.085); StepCtrl=list(1e-4, 5); g_Wkm=1.5; ShowDist?=%F;
    case 2 then
        StepCtrl=list(1e-4, 5); g_Wkm=1.5;ShowDist?=%F;
    case 3 then
        g_Wkm=1.5;ShowDist?=%F;
    case 4 then
        ShowDist?=%F;
    end
    z_km=Fiber(1);
    a_dBkm=Fiber(2);
    D_psnmkm=Fiber(3);
    S_ps2nmkm=Fiber(4);
    tol=StepCtrl(1);
    h=StepCtrl(2);

    function UcF = SSFMcF(U,operL,h,Gamma)
        halfs = exp(operL*h/2);
        uvF = fft(halfs.*U,1);
        UcF = halfs.*fft(uvF.* exp(-%i*uvF.*conj(uvF)*Gamma*h));
    endfunction

    function UfF = SSFMfF(U,operL,h,Gamma)
        halfs = exp(operL*h/4);
        uvF = fft(halfs.*U,1);
        U = halfs.*fft(uvF.* exp(-%i*uvF.*conj(uvF)*Gamma*h/2));
        uvF = fft(halfs.*U,1);
        U = halfs.*fft(uvF.* exp(-%i*uvF.*conj(uvF)*Gamma*h/2));
        UfF = U;
    endfunction

    function y = rms(x)
        y = sqrt(sum(abs(x.*conj(x)))/size(x,1));
    endfunction

    c = 299792458;
    dt = MDT*1e-9;
    L = MLA*1e-9;
    z = 1e3*z_km;
    alpha = log(10)*1e-4*a_dBkm;
    D = 1e-6 * D_psnmkm;
    S = 1e3 * S_ps2nmkm;
    betap(1) = 0;
    betap(2) = -D*L^2/(2*%pi*c);
    betap(3) = (S*L^4+2*D*L^3)/(2*%pi*c)^2;
    Gamma = 1e-6*g_Wkm*MNT^2;

    w = 2*%pi*[0:MNT/2 -MNT/2+1:-1]'/(dt*MNT);
    operL = -alpha/2;
    for ii = 1:length(betap);
        operL = operL - %i*betap(ii)*(w).^ii/factorial(ii);
    end
    
    if ShowDist? then winH = waitbar('Distance simulated'); end
    iter = 0;
    zremind = z;
    zready = 0;
    Steps_km=[];
    while zremind > 0
        iter = iter+1;
        A = %f; B = %f; C = %f; D = %f;
        while ~(A|B|C|D)
            UcF = SSFMcF(In(:,1),operL,h,Gamma);
            UfF = SSFMfF(In(:,1),operL,h,Gamma);
            U2 = (4*UfF - UcF)/3;
            tolA = rms(UcF - UfF)/rms(UfF);
            A = tolA <= tol/2;
            if A
                hprev = h;
                h = h*2^(1/3);
            else
                B = tolA <= tol;
                if B
                    hprev = h;
                else
                    C = tolA <= tol*2;
                    if C
                        hprev = h;
                        h = h*2^(-1/3);
                    else
                        h = h/2;
                        hprev = h;
                        UcF = SSFMcF(In(:,1),operL,h,Gamma);
                        UfF = SSFMfF(In(:,1),operL,h,Gamma);
                        U2 = (4*UfF - UcF)/3;
                        D = rms(UcF - UfF)/rms(UfF) <= tol;
                    end
                end
            end
            In(:,1) = U2;
        end
        zready = zready + hprev;
        zremind = z - zready;
        if h > zremind
            h = zremind;

        end
        Steps_km=[Steps_km; hprev*1e-3];
        if ShowDist? then waitbar(zready/z,winH); end
    end
    if ShowDist? then close(winH); end
    Out(:,1) = In(:,1);
    Out(:,2)= exp(operL*z).*In(:,2);
endfunction
