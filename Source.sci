// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE

function s = Source(M)
    x1 = ones(M,1);
    y = 0:M-1;
    s = zeros(2*M,M)
    for i = 1:M
        x = (i-1)*x1;
        for m = 1:M
            s(2*m-1,i) = x(m);
            s(2*m,i) = y(m);
        end
    end
    s = matrix(s,2*M*M,1)
endfunction
