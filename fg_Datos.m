function [ data_site, n_trial, local, ubication, fecha, nombre_archivo ] = fg_Datos()

% Pide sujeto
data_site = input('Ingrese número de sujeto ','s');    % subject = '999';
disp(' ');

% Pide trial
n_trial = input('Ingrese número de trial (Si quiere graficar todos 000) ','s');    % trial = '3';

local=pwd;
ubication=fullfile(local,data_site);
sdir=strcat(ubication,'\*data*.mat');
files=dir(sdir);
fecha = datestr(fix(clock),'yyyy-mm-dd');
nombre_archivo=fullfile(ubication,files.name);

end
