// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function y=SSSeLPF(x,fh_GHz,Order,Type)
    // Electrical Low-Pass Filter
    //
    // Calling Sequence
    //  y=SSSeLPF(x,fh_GHz,Order,Type)
    //
    // Parameters
    //   x : Electrical Input
    //   fh_GHz : The 3 dB Bandwidth (GHz)
    //   Order : The Filter Order (1-20)
    //   Type : 0 - Bessel (default), 1 - Butterworth
    //   y : Electrical Output
    //
    // Description
    // Electrical Low-Pass Filter.
    //

    global MDT;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        error("Expect at least one argument");
    case 1 then
        fh_GHz=8; Order=4;Type=0;
    case 2 then
        Order=4;Type=0;
    case 3 then
        Type=0;
    end
    if Order >20 then; Order=20; end
    if Order <1 then; Order=1; end
    cr=[1.2021;0.8824;0.7652;0.7125;0.6793;0.6629;0.6458;0.6383;0.6322;0.6261;0.6225;0.621;0.6181;0.6169;0.6163;0.6167;0.6136;0.6132;0.6155;0.6142];
    Fs=1/MDT;
    fl0=fh_GHz/Fs;
    if Type==1 then
        hz=iir(Order,"lp","butt",fl0,[]);
        NO=coeff(hz(3))/coeff(hz(3),Order);
        DE=coeff(hz(2))/coeff(hz(3),Order);
        NO=flipdim(NO',1)';
        DE=flipdim(DE',1)';
        y=filter(DE,NO, x);
    else
        function y=fct(n), y=1, if n~=0, for i=1:n, y=y*i, end, end, endfunction
        c=1:Order+1;
        for i=0:Order
            c(i+1)=fct(2*Order-i)./(2.^(Order-i).*fct(i).*fct(Order-i))
        end
        w=2*tan(%pi*fl0)*cr(Order-1);
        s=poly(0,"s");
        HS=c(1)/poly(c,"s","c");
        Hs=horner(HS,s/w);
        Hz=horner(Hs,2*(s-1)/(s+1));
        NO=coeff(Hz(3))/coeff(Hz(3),Order);
        DE=coeff(Hz(2))/coeff(Hz(3),Order);
        NO=flipdim(NO',1)';
        DE=flipdim(DE',1)';
    end
    [y,zi]=filter(DE,NO, x);
    y=filter(DE,NO, x,zi);
endfunction
