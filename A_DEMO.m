%% DEMO -- Experimento Motor Piloto --
% Funciona con 2 arduinos: master_tone.ino y slave_servo.ino
% Funciona con NomArch.m, ComArdu.m, RecibeDatos.m
clear all;
delete(instrfind);

%% Definiciones

% OS win=1, mac=2 o linux=3
os = 1;
% Numero de bips por trial.
N_stim = 20;
% Perturbaciones
temporal_bip = [10 15];     
mechanical_bip = [10 15];    
% Posiciones del Servo
servo_ini_pos=57;             %posicion inicial del servo
servo_low_pos=30;             %posicion inicial del servo
servo_high_pos=105;             %posicion inicial del servo           

%% Pide los datos del sujeto
subject = input('Ingrese número de sujeto: ','s');    % subject = 'rrr';
disp(' ');

%% No tocar!
L = [0 0 -50 50 0 0; servo_ini_pos servo_high_pos servo_low_pos servo_low_pos servo_high_pos servo_low_pos];
N = max(size(L)); % Numero total de trials
temporal_bip_list = round((max(temporal_bip)-min(temporal_bip)).*rand(N,1) + min(temporal_bip));
mechanical_bip_list = round((max(mechanical_bip)-min(mechanical_bip)).*rand(N,1) + min(mechanical_bip));
baseline_tau = 500;
max_line_lenght = 70;
buffer_size = 5*max_line_lenght*N_stim*2;
[ current_folder, fecha, filename_mat, mat ] = f1_NomArchDEMO(subject);   % Crea carpetas y archivos
r=1;o=1; bad=[];
%% start communication with Arduino
[ ardu ] = f2_ComArdu( os, buffer_size );                        % Comunica con arduino

%% Main Loop

disp(['ATENCION: Comienzo del experimento!!']);
disp(' ');

for j=1:N
    
    % Parametros del trial j
    perturb_bip = temporal_bip_list(j);
    perturb_size = L(1,j);
    mechanical_size = L(2,j);
    
    if perturb_size~=0 && mechanical_size~=0 % Si cambian temp y mech que sea en el mismo bip
        mechanical_bip=perturb_bip;
    else
        mechanical_bip = mechanical_bip_list(j);
    end
    
    fprintf(ardu,'ARDU;I%d;N%d;p%d;P%d;S%d;M%d;m%d;X',[baseline_tau N_stim perturb_bip perturb_size servo_ini_pos mechanical_size mechanical_bip]);	% send parameters
    
    [stim,resp,asyn,error,data] = f3_RecibeDatos(ardu);
    
    if isempty(error)==0
        
        bad(r).subject = subject;
        bad(r).order = o;
        bad(r).trial = r;
        bad(r).perturb_size = perturb_size;
        bad(r).perturb_bip = perturb_bip;
        bad(r).mechanical_size = mechanical_size;
        bad(r).mechanical_bip = mechanical_bip;
        bad(r).stim = stim;
        bad(r).resp = resp;
        bad(r).asyn = asyn;
        bad(r).type = error;
        
        o=o+1;
        r=r+1;
        
    else
        trial(j).subject = subject;
        trial(j).order = o;
        trial(j).trial = j;
        trial(j).perturb_size = perturb_size;
        trial(j).perturb_bip = perturb_bip;
        trial(j).mechanical_size = mechanical_size;
        trial(j).mechanical_bip = mechanical_bip;
        trial(j).stim = stim;
        trial(j).resp = resp;
        trial(j).asyn = asyn;
        trial(j).type = error;
        
        o=o+1;
    end
   
   
    while isempty(error)==0
        
        pause(1);
        fprintf(ardu,'ARDU;I%d;N%d;p%d;P%d;S%d;M%d;m%d;X',[baseline_tau N_stim perturb_bip perturb_size servo_ini_pos mechanical_size mechanical_bip]);	% send parameters
        
        [stim,resp,asyn,error,data] = f3_RecibeDatos(ardu); %Descarga los datos del trial
        
        if isempty(error)==0
            
            bad(r).subject = subject;
            bad(r).order = o;
            bad(r).trial = r;
            bad(r).perturb_size = perturb_size;
            bad(r).perturb_bip = perturb_bip;
            bad(r).mechanical_size = mechanical_size;
            bad(r).mechanical_bip = mechanical_bip;
            bad(r).stim = stim;
            bad(r).resp = resp;
            bad(r).asyn = asyn;
            bad(r).type = error;
                       
            o=o+1;
            r=r+1;
            
        else
            trial(j).subject = subject;
            trial(j).order = o;
            trial(j).trial = j;
            trial(j).perturb_size = perturb_size;
            trial(j).perturb_bip = perturb_bip;
            trial(j).mechanical_size = mechanical_size;
            trial(j).mechanical_bip = mechanical_bip;
            trial(j).stim = stim;
            trial(j).resp = resp;
            trial(j).asyn = asyn;
            trial(j).type = error;
            
            o=o+1;
        end
        
        pause((rand+2))
    end
    
    pause((rand+2))   
end

if  isempty(bad) == 0
    save(mat, 'trial','bad');   % Guarda todo el experimento en .mat
else
    save(mat, 'trial');     % Guarda todo el experimento en .mat
end

fclose(ardu);

disp(['Su efectividad fue: ' num2str((j/(j+r))*100) '%' ]);
disp(' ');

filename_dat = [ subject '-demo.dat'];
fid = fopen(fullfile(current_folder,subject,filename_dat), 'wt');     
fprintf(fid, '%s\n', num2str((j/(j+r))*100));        
fclose(fid);
