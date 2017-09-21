function [ sujeto,sujeto_number ] = f_DatosSujeto(dir)

%% Numera al sujeto
 if exist(fullfile(dir,'sujetos.mat'),'file')==2
    load('sujetos.mat')
    num_ant=length(sujeto);
    num_actual=num_ant+1;
    sujeto(num_actual).numero=num_actual;
else
    sujeto.numero=1;
    num_actual=1;
 end

%% Pide los datos del sujeto
sujeto(num_actual).nombre = input('Ingrese sus iniciales: ','s');
disp(' ');
sujeto(num_actual).edad = input('Edad: ');
disp(' ');
sujeto(num_actual).genero = input('Genero (0 femenino; 1 masculino):  ');
disp(' ');
sujeto(num_actual).musica = input('Anios de entrenamiento musical: ');
disp(' ');
sujeto(num_actual).obj = input('Actividad o instrumento: ','s');
disp(' ');
sujeto(num_actual).mano = input('Mano dominante (0 izq; 1 der): ');
disp(' ');
sujeto(num_actual).fecha = clock;

% sujeto_number = num2str(length(sujeto));
sujeto_number = length(sujeto);
% mkdir(fullfile(dir,sujeto_number));

end

