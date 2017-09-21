function [trial,bad] = Loop_central_ALTURAS(step,N_stim,n,n_entrenamiento,servo_ini_pos,cond_mech,mech_sizes,mech_bip_range)

[ os ] = SYS_id(  );
isi=500;

if step==1
    n=n_entrenamiento;
else
end

N = n*cond_mech; % Numero total de trials
% B = min(n,cond_mech);
B=7; % Numero de bloques
N_B = N/B; % Numero de trials por bloque
B_laps=[N_B:N_B:N];

mech_sizes_list=shuffle(repmat(mech_sizes,1,n));
mech_bip_list = round((max(mech_bip_range)-min(mech_bip_range)).*rand(N,1) + min(mech_bip_range));

max_line_lenght = 70;
buffer_size = 5*max_line_lenght*N_stim*2;
o=1;r=1;bad=struct([]);trial=struct([]);;temporal=struct([]);
%% Start communication with Ingka
[ ingka ] = f_ComINGKA( os );
%% start communication with Arduino
[ ardu ] = f_ComArdu( os, buffer_size );

if step==1
    disp('ATENCION: Comienzo del entrenamiento!!');
elseif step==2
    disp('ATENCION: Comienzo del experimento!!');
end

for j=1:N
    
    % Parametros del trial j
    mech_size = mech_sizes_list(j);
    mech_bip = mech_bip_list(j);
    
    disp(['INICIO de trial: ' num2str(j)]);
    %% Send parameters to ardu
    fprintf(ardu,'ARDU;I%d;N%d;p%d;P%d;S%d;M%d;m%d;X',[isi N_stim mech_bip 0 servo_ini_pos mech_size mech_bip]);	% send parameters
    %% Take data from ingka
    [t_acc,x_acc,y_acc,z_acc,t_pr,pr] = f3_RecibeDatosINGKA(ingka,ardu); %Descarga los datos del trial
    %     disp(['FIN de trial']);
    %% Take data from ardu
    [stim,resp,asyn,error,data] = f3_RecibeDatos(ardu);
    
    if isempty(error)==0
        [ o,r,bad,temporal ] = save_bad_data_ALTURAS(temporal,step,r,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,bad,B_laps );
          if strcmp(error,'missing')==1
            disp('Error en el trial: Faltó una respuesta');
          elseif strcmp(error,'extra')==1
            disp('Error en el trial: Respuesta extra');
          elseif strcmp(error,'bad')==1
            disp('Error en el trial: Asincronía atípica');
          end
    else
        [ o,trial,temporal ] = save_good_data_ALTURAS(temporal,step,j,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,trial,B_laps );
        disp('FIN de trial');
    end
    
    while isempty(error)==0
        
        pause(1);
        
        disp(['INICIO de trial: ' num2str(j)]);
        %% Send parameters to ardu
        fprintf(ardu,'ARDU;I%d;N%d;p%d;P%d;S%d;M%d;m%d;X',[isi N_stim mech_bip 0 servo_ini_pos mech_size mech_bip]);	% send parameters
        %% Take data from ingka
        [t_acc,x_acc,y_acc,z_acc,t_pr,pr] = f3_RecibeDatosINGKA(ingka,ardu); %Descarga los datos del trial
        %% Take data from ardu
        [stim,resp,asyn,error,data] = f3_RecibeDatos(ardu);
        
        if isempty(error)==0
            [ o,r,bad,temporal ] = save_bad_data_ALTURAS(temporal,step,r,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,bad,B_laps );
            if strcmp(error,'missing')==1
                disp('Error en el trial: Faltó una respuesta');
            elseif strcmp(error,'extra')==1
                disp('Error en el trial: Respuesta extra');
            elseif strcmp(error,'bad')==1
                disp('Error en el trial: Asincronía atípica');
            end
        else
            [ o,trial,temporal ] = save_good_data_ALTURAS(temporal,step,j,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,trial,B_laps );
            disp('FIN de trial');
        end
        
        pause((rand+2))
    end
    
    if step==2
        if (sum(find(j==B_laps))==0)==0
            disp(['Fin del Bloque # ' num2str(find(B_laps==j)) ' . Para continuar presione una tecla (ATENCION: el trial comenzará inmediatamente' ]);
            pause()
        else
            pause((rand+2))
        end
    else
    end
end

fclose(ardu);
f_CierraIngka( ingka );
end