function [ current_folder, fecha, filename_mat, mat ] = f1_NomArchDEMO( subject )
% Pide los datos del sujeto y genera nombres de archivos y carpetas

mkdir(subject)
current_folder=pwd;
fecha = datestr(fix(clock),'yyyy-mm-dd-HH-MM');           
filename_mat = [ subject '-' 'demo-' fecha '.mat'];            % Nombre archivo .mat
mat = fullfile(current_folder,subject,filename_mat);

end

