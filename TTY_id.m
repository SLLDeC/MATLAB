function [ dev_port ] = TTY_id( id )

[~, output] = system('bash /home/sabrina/Dropbox/Doc/MATLAB/Funciones/find_arduino.sh');
output = textscan(output, '%s', 'delimiter', sprintf('\n'));
output = output{1};

for n = 1:numel(output)
   
    aux = output{n};
    
    if isempty( strfind(aux,'Mega') )==0

        ix = strfind(aux,' ');
        dev_mega = aux(1:ix-1);

    end

    if isempty( strfind(aux,'Leonardo') )==0

        ix = strfind(aux,' ');
        dev_ingka = aux(1:ix-1);

    end
  
end

if id==0

    dev_port=dev_mega; 
    
elseif id==1
    
    dev_port=dev_ingka;
end

end

