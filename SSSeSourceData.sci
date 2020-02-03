// The code was developed under Horizon2020 Framework Programme
// Project: 748767 — SIMFREE


function OUT=SSSeSourceData(Amplitude,OffsetBit,DutyCycle,Sequence_Hex)
    // Generates binary pseudorandom sequence
    //
    // Calling Sequence
    //  OUT=SSSeSourceData(Amplitude,OffsetBit,DutyCycle,Sequence_Hex)
    //
    // Parameters
    //   Amplitude : Difference between '1' and '0' levels
    //   OffsetBit : Value of '0' level
    //   DutyCycle : The fraction of a bit-period that is 'high' for l's
    //   Sequence_Hex : User defined bit sequence in Hex. This is read bit-wise from left to right.
    //   OUT : Electrical Output

    // Description
    // Generates a user defined binary (cyclic) sequence.
    // The Sequence_Hex is set in a string as a Hexadecimal code word.
    // The sequence must be an integer power of two long and will be cyclic.
    // The bit-rate and code length are set in the SSSconfig component.
    // If the user does not wire his own Sequence_Hex then default (pseudorandom) sequence is chosen depending on the value of m set at the SSSconfig.
    //

    global MNT MNS;
    [lhs,rhs]=argn(0);
    select rhs
    case 0 then
        Amplitude=1; OffsetBit=0; DutyCycle=1; Sequence_Hex="";
    case 1 then
        OffsetBit=0; DutyCycle=1; Sequence_Hex="";
    case 2 then
        DutyCycle=1; Sequence_Hex="";
    case 3 then
        Sequence_Hex="";
    end

    function x=hex2bin4(x)
        for i=0:15
            x=strsubst(x,dec2hex(i),dec2bin(i,4));
        end
        x=strsplit(x)';
        x=bin2dec(x);
    endfunction

    if isempty(Sequence_Hex) then
        select log2(round(MNS))
        case 0 then; x=1;
        case 1 then; x=[1 0];
        case 2 then; x=hex2bin4("3");
        case 3 then; x=hex2bin4("17");
        case 4 then; x=hex2bin4("09AF");
        case 5 then; x=hex2bin4("04B3E375");
        case 6 then; x=hex2bin4("0218A7A392DD9ABF");
        case 7 then; x=hex2bin4("0106147916753E87126D6F634BB9957F");
        case 8 then; x=hex2bin4("008E25C0C93720ADACB0FB7AE886C79CC5A452A7767BF4CD460EABE509FE178D");
        case 9 then; x=hex2bin4("0042309CAB0DE9B9142B4FD925BF26A6603194697F458EB2CF1F741ADBB05AFAA814AF2EE073A4F5D448670BDB343BC3FE0F7C5CC8253B479F362A471B571311");
        case 10 then; x=hex2bin4("002048832684A87AEB6C0306CC2B5C6FC479EDA0285AA3EF25826451B703C77F218B74356796C8224C0B14ECE2FD45DAC336A0E9E9A9383E737A2ADF09D1D7DA4214AC73FB08D393C37631EFA4A068CBA5A22CD291876F05CAE77733ABBD944D8872F94CCAA7E635E6B4C4B85EAAFF4152F15EEA6E471FF80E1FB89F19F59649");
        end
    else
        x=hex2bin4(Sequence_Hex);
    end
    if DutyCycle <0 then DutyCycle=0; end;
    if DutyCycle >1 then DutyCycle=1; end;
    d=MNT/MNS;
    OUT=matrix([repmat(x,round(DutyCycle*d),1), zeros(MNS,round((1-DutyCycle)*d))],MNT,1);
    OUT=Amplitude*OUT+OffsetBit;

endfunction
