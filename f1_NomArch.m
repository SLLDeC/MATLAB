function [ current_folder, fecha, filename_mat, mat ] = f_NomArch(subject)
% Pide los datos del sujeto y genera nombres de archivos y carpetas

mkdir(subject)
current_folder=pwd;
fecha = datestr(fix(clock),'yyyy-mm-dd-HH-MM');           
filename_mat = [ subject '-' 'data-' fecha '.mat'];            % Nombre archivo .mat
mat = fullfile(current_folder,subject,filename_mat);

end

