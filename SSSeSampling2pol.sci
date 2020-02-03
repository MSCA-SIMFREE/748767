// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function [y,Index,MaxCo] = SSSeSampling2pol(x1,y1,xref,Ind)
    Ampl=[];
    for j=-45:45
        x=x1*cos(j*%pi/180)-y1*sin(j*%pi/180);
        y=x1*sin(j*%pi/180)+y1*cos(j*%pi/180);
        Ampl=[Ampl mean(abs(x)+abs(y))];
    end
    [Ampl_max,j]=max(Ampl);
    A=j*%pi/180;
    x=x1*cos(A)-y1*sin(A);
    y=x1*sin(A)+y1*cos(A);
    [y0,Index,MaxCo0]= SSSeSampling(x,xref,Ind);
    A=j*%pi/180+%pi/2;
    x=x1*cos(A)-y1*sin(A);
    y=x1*sin(A)+y1*cos(A);
    [y,Index,MaxCo]= SSSeSampling(x,xref,Ind);
    if MaxCo < MaxCo0 then y=y0; MaxCo=MaxCo0; end
endfunction
