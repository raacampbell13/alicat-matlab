function OUT=readMFC(quiet)
% function OUT=readMFC(quiet)
%
% Read data from the alicat.
% Quiet is optional. On by default.
%
% Rob Campbell - March 20th 2008 - CSHL

% Example of the data format is:
% fprintf(aliConnect,'A10000'); fscanf(aliConnect)
%
%ID; pressure in; temp; vol flow ; mass flow;  set point ; gas
%A +014.61 +023.30 +00.000 +00.000 00.156     Air



global aliComm;
if isempty(aliComm), aliComm=connectAlicat; end


if nargin<1, quiet=1; end

try
    
IN=fscanf(aliComm);
[...
    OUT.ID, ...
    OUT.pressure,...
    OUT.temp,...
    OUT.volumetricFlow,...
    OUT.massFlow,...
    OUT.setPoint,...
    OUT.gas...
    ]=...
    strread(IN,'%s%f%f%f%f%f%s', 'delimiter', ' ');


OUT.ID  = cell2mat(OUT.ID) ;
OUT.gas = cell2mat(OUT.gas);
OUT.time = now;

catch
    if ~quiet
    disp('Problem reading from serial port')
    end
    OUT=[];
end
