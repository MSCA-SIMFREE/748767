// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [Out,Steps_km]=SSSFiberLEM2pol_v1(In, Fiber, StepCtrl, g_Wkm, ShowDist)
    global MNT MDT MLA;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        Fiber=list(50, 0.2, 17, 0.085); StepCtrl=list(1e-4, 5); g_Wkm=1.5; ShowDist=%F;
    case 2 then
        StepCtrl=list(1e-4, 5); g_Wkm=1.5; ShowDist=%F;
    case 3 then
        g_Wkm=1.5; ShowDist=%F;
    case 4 then
        ShowDist=%F;
    end
    [Out,Steps_km]=SSSFiberLEM(In, Fiber, StepCtrl, g_Wkm, ShowDist);
    Ux=In(:,1);
    Uy=In(:,2);
    z_km=Fiber(1);
    a_dBkm=Fiber(2);
    D_psnmkm=Fiber(3);
    S_ps2nmkm=Fiber(4);
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

    function [UxcF,UycF] = SSFM2pol(Ux,Uy,operL,h,Gamma)
        halfs=exp(operL*h/2);
        A=(1/sqrt(2));
        uxvF=fft(halfs.*Ux,1);
        uyvF=fft(halfs.*Uy,1);
        xv=uxvF;
        uxvF=A*(xv+%i*uyvF);
        uyvF=A*(xv-%i*uyvF);
        Px=(abs(uxvF)).^2;
        Py=(abs(uyvF)).^2;
        uxvF=uxvF.*exp(-%i*Gamma*h*(Px+2*Py));
        uyvF=uyvF.*exp(-%i*Gamma*h*(Py+2*Px));
        UxcF=fft(A*(uxvF+uyvF)).*halfs;
        UycF=fft(A*%i*(uyvF-uxvF)).*halfs;
    endfunction
      
    if ShowDist then winH = waitbar('Distance simulated'); end
    h=1e3*Steps_km;
    Steps=length(h);
    for i=1:Steps
        [Ux,Uy] = SSFM2pol(Ux,Uy,operL,h(i),Gamma)
        if ShowDist then waitbar(i/Steps,winH); end
    end
    if ShowDist then close(winH); end
    Out= [Ux,Uy]
endfunction
