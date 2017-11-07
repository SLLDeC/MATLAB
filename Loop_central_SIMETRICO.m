function [trial,bad,mech_sizes,temp_sizes] = Loop_central_SIMETRICO(conditions,exp,temp_sizes,step,N_stim,n,n_entrenamiento,n_calibracion,servo_ini_pos,cond_mech,mech_sizes,mech_bip_range)

[ os ] = SYS_id(  ); % detecta el sistema operativo
isi=500;

if step==1
    n=n_entrenamiento;
elseif step==2
    n=n_calibracion;
end

if strcmp(conditions,'full')==1 ||  strcmp(conditions,'full-iso')==1 
    mech_sizes(length(mech_sizes)+1)=57;
    temp_sizes(length(temp_sizes)+1)=0;
end
cond_mech = max(size(mech_sizes));
cond_temp = max(size(temp_sizes));
N = n*cond_temp*cond_mech; % Numero total de trials

mech_sizes_list=shuffle(repmat(mech_sizes,1,n));
temp_sizes_list=shuffle(repmat(temp_sizes,1,n));

mech_bip_list = round((max(mech_bip_range)-min(mech_bip_range)).*rand(N,1) + min(mech_bip_range));

%Matriz de perturbaciones
C=(repmat(CombVec(temp_sizes,mech_sizes),1,n)); % Matriz de 2xN de condiciones
C((min(size(C)))+1,:)=mech_bip_list; % Matriz de 2xN de condiciones
L=C(:,randperm(size(C,2)));
N=length(L);
%Definicion de bloques
div = 1:N;
D=div(~(rem(N,div)));
N_B = max(D(D>=10 & D<=20));
B_laps=[N_B:N_B:N];

if strcmp(conditions,'full-iso')==1
    Ctemp=L(1,:)==0;
    Cmech=L(2,:)==57;
    Cond=Cmech & Ctemp;
    L(:,Cond)=[];
    N=length(L);
    N_B = 20; % Numero de trials por bloque
    B_laps=[N_B:N_B:N];
end

max_line_lenght = 70;
buffer_size = 5*max_line_lenght*N_stim*2;
o=1;r=1;bad=struct([]);trial=struct([]);
% %% Start communication with Ingka
% [ ingka ] = f_ComINGKA( os );
%% start communication with Arduino
[ ardu ] = f_ComArdu( os, buffer_size );

if step==1
    disp('ATENCION: Comienzo del entrenamiento!!');
elseif step==2
    disp('ATENCION: Comienzo del experimento!!');
elseif step==3
    disp('ATENCION: Continuación del experimento!!');
end

for j=1:N
    
    % Perturbaciones del trial j
    temp_size = L(1,j);
    mech_size = L(2,j);
    mech_bip = L(3,j);
    
    disp(['INICIO de trial: ' num2str(j)]);
    %% Send parameters to ardu
    fprintf(ardu,'ARDU;I%d;N%d;p%d;P%d;S%d;M%d;m%d;X',[isi N_stim mech_bip temp_size servo_ini_pos mech_size mech_bip]);	% send parameters
    
    %     %% Take data from ingka
    %     [t_acc,x_acc,y_acc,z_acc,t_pr,pr] = f3_RecibeDatosINGKA(ingka,ardu); %Descarga los datos del trial
    %     %     disp(['FIN de trial']);
    %% Take data from ardu
    [stim,resp,asyn,error,data] = f3_RecibeDatos(ardu);
    
    if isempty(error)==0
        if exist('x_acc','var')==0
            t_acc=[];x_acc=[];y_acc=[];z_acc=[];t_pr=[];pr=[];
        end
        [ o,r,bad ] = save_bad_data_ALTURAS(exp,trial,step,r,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,bad,B_laps,temp_size);
        
        if strcmp(error,'missing')==1
            disp('Error en el trial: Faltó una respuesta');
        elseif strcmp(error,'extra')==1
            disp('Error en el trial: Respuesta extra');
        elseif strcmp(error,'bad')==1
            disp('Error en el trial: Asincronía atípica');
        end
    else
        if exist('x_acc','var')==0
            t_acc=[];x_acc=[];y_acc=[];z_acc=[];t_pr=[];pr=[];
        end
        [ o,trial ] = save_good_data_ALTURAS(exp,bad,step,j,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,trial,B_laps,temp_size);
        disp('FIN de trial');
    end
    
    while isempty(error)==0
        
        pause(1);
        
        disp(['INICIO de trial: ' num2str(j)]);
        %% Send parameters to ardu
        fprintf(ardu,'ARDU;I%d;N%d;p%d;P%d;S%d;M%d;m%d;X',[isi N_stim mech_bip 0 servo_ini_pos mech_size mech_bip]);	% send parameters
        %         %% Take data from ingka
        %         [t_acc,x_acc,y_acc,z_acc,t_pr,pr] = f3_RecibeDatosINGKA(ingka,ardu); %Descarga los datos del trial
        %% Take data from ardu
        [stim,resp,asyn,error,data] = f3_RecibeDatos(ardu);
        
        if isempty(error)==0
            if exist('x_acc','var')~=0
                t_acc=[];x_acc=[];y_acc=[];z_acc=[];t_pr=[];pr=[];
            end
            [ o,r,bad ] = save_bad_data_ALTURAS(exp,trial,step,r,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,bad,B_laps,temp_size);
            if strcmp(error,'missing')==1
                disp('Error en el trial: Faltó una respuesta');
            elseif strcmp(error,'extra')==1
                disp('Error en el trial: Respuesta extra');
            elseif strcmp(error,'bad')==1
                disp('Error en el trial: Asincronía atípica');
            end
        else
            if exist('x_acc','var')==0
                t_acc=[];x_acc=[];y_acc=[];z_acc=[];t_pr=[];pr=[];
            end
            [ o,trial ] = save_good_data_ALTURAS(exp,bad,step,j,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,trial,B_laps,temp_size);
            disp('FIN de trial');
        end
        
        pause((rand+2))
    end
    
    if step==3
        if (sum(find(j==B_laps))==0)==0
            disp(['Fin del Bloque # ' num2str(find(B_laps==j)) ' . Para continuar presione una tecla (ATENCION: el trial comenzará inmediatamente)' ]);
            pause()
        else
            pause((rand+2))
        end
    else
    end
end

fclose(ardu);% f_CierraIngka( ingka );

end