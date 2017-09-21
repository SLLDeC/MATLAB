function [ ] = Entrenamiento_LP( n N_stim factorial temp_bip_range mech_bip_range mech_sizes servo_ini_pos temp_sizes)

mech_sizes=horzcat(mech_sizes,servo_ini_pos);
temp_sizes=horzcat(temp_sizes,0);
cond_mech=max(size(mech_sizes));
cond_temp=max(size(temp_sizes));

if factorial==0
    N = n*(cond_temp+cond_mech);
    C = repmat([temp_sizes ones(1,cond_mech)*0; ones(1,cond_temp)*servo_ini_pos mech_sizes ],1,n);
elseif factorial ==1
    N = n*cond_temp*cond_mech; % Numero total de trials
    C=(repmat(CombVec(temp_sizes,mech_sizes),1,n)); % Matriz de condiciones
end

L = C(:,randperm(size(C,2)));
temp_bip_list = round((max(temp_bip_range)-min(temp_bip_range)).*rand(N,1) + min(temp_bip_range));
mech_bip_list = round((max(mech_bip_range)-min(mech_bip_range)).*rand(N,1) + min(mech_bip_range));

baseline_tau = 500;
max_line_lenght = 70;
buffer_size = 5*max_line_lenght*N_stim*2;
[ current_folder, fecha, filename_mat, mat ] = f_NomArch(subject);   % Crea carpetas y archivos
r=1;o=1; bad=[];

end

