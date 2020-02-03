// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [EyeOpening,bRe,bIm]=SSSeQPSKdecoder(xI,xQ,bits)
    global MNT MNS;
    x=complex(xI,xQ);
xI0=2*SSSeSourceData()-1;
//przesunięcie momentu próbkowania przez maksymalizację korelacji xI z xI0
    xI2=[xI;xI];
    function c=Kor(x,y)
        cx = size(x, "*");
        ry = size(y, "*");
        x=matrix(x,1,cx);
        y=matrix(y,ry,1);
        mx = mean(x);
        my = mean(y);
        sx = sqrt(sum((x-mx).^2))
        sy = sqrt(sum((y-my).^2))
        c = (x-mx)*(y-my)/(sx*sy);
    endfunction
    Co=[];
    for i=1:MNT
        Co=[Co Kor(xI0,xI2(i:i+MNT-1))];
    end
    [Max,Index]=max(Co);
    x=[x;x];
    x=x(Index:Index+MNT-1);
    //pozostawienie tylko próbek
    x=x(MNT/MNS/2+3:$);
    x=x(1:MNT/MNS:$);
    //normalizacja amplitudy x=1,y=1
    k=mean(abs(x))/sqrt(2);
    x=x/k;
    //rozdzielenie bitów na punkty konstelecji kodowej
    b0=[];b1=[];b2=[];b3=[];
    for i=1:MNS
        select bits(i)
        case 0; b0=[b0 x(i)];
        case 1; b1=[b1 x(i)];
        case 2; b2=[b2 x(i)];
        case 3; b3=[b3 x(i)];
        end
    end
    //wyznaczenie kąta obrotu konstelacji
    fi0=2*mean(atan(imag(b0),real(b0)))/%pi+1.5;
    fi1=2*mean(atan(imag(b1),real(b1)))/%pi+0.5;
    fi2=2*mean(atan(imag(b2),real(b2)))/%pi-0.5;
    fi3=2*mean(atan(imag(b3),real(b3)))/%pi-1.5;
    fi=(fi0+fi1+fi2+fi3)/4;
    //korekcja kąta obrotu
    function y=FiRot(x,fi)
        y=abs(x).*exp(%i*(atan(imag(x),real(x))-fi*%pi/2));
    endfunction
    b0=FiRot(b0,fi);
    b1=FiRot(b1,fi);
    b2=FiRot(b2,fi);
    b3=FiRot(b3,fi);
    //przesunięcie wszystkich punktów konstelacji do punktu 0,0
    bE=[b0-(-1-%i),b1-(1-%i),b2-(1+%i),b3-(-1+%i)];
    EyeOpening=(1-mean(abs(bE)))*k;
    if EyeOpening <=0 then; EyeOpening=%nan; end
    b=[b0,b1,b2,b3];
    //zobrazowanie konstelacji kodowej
    bRe=real(b);bIm=imag(b);
    //plot2d(bRe,bIm,-3,rect=[-1.5,-1.5,1.5,1.5]);
endfunction

