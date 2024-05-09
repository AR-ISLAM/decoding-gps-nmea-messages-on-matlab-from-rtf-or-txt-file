%
%
% Project Title: Decoding GPS NMEA Messages on MATLAB From .rtf or .txt File
% Developer: Engineer MD ARRAHMANUL ISLAM (伊兰沐), BSc, MSc
%
% 
% Contact Info: ar.islam.web@gmail.com, https://www.linkedin.com/in/ar-islam/
% Github: https://github.com/AR-ISLAM
%


clc;
clear;
close all;

%% Solution Number 1

% Reading the data from .rtf File
filename = 'Commix1.rtf';
fid = fopen(filename);

this_line = 0;
all={};
while this_line ~=-1
    this_line = fgetl(fid);
    if this_line ~= -1
        all = [all; this_line];
    end
end

my_line = all(end-2);

% Convert Imported Message to String
Message = string(my_line);

% Decode NMEA Message
pnmea = nmeaParser("MessageID","RMC");
unparsedRMCLine= Message;
rmcData = pnmea(unparsedRMCLine);

% Convert Decoded Data into Table
gps_data = struct2table(rmcData);

% Export Table to .xlsx file
writetable(gps_data, "Decode_data.xlsx")



%% Solution No 2

for i = 1:2

    % Reading the Data from .txt file
    if i == 1
        Data = importdata("Message1.txt");
    else
        Data = importdata("Message2.txt");
    end

    % Convert Imported Message to String
    Message = string(Data);

    % Decode NMEA Message
    pnmea = nmeaParser("MessageID","RMC");
    unparsedRMCLine= Message;
    rmcData = pnmea(unparsedRMCLine);

    if i == 1
        gps_1 = struct2table(rmcData);
        writetable(gps_1, "Decode_1.xlsx")
    else
        gps_2 = struct2table(rmcData);
        writetable(gps_2, "Decode_2.xlsx")
    end
end

