function [ ardu ] = f_ComArdu( os, buffer_size )
% Conecta con arduino segun el sistema operativo.

id=0; % Identificador mega=0, SAD=1

if os == 1 % Windows
    
        [ port ] = COM_id( id );
        ardu = serial(port);	
        
elseif  os == 3 % Mac os x  
    
        ardu = serial('/dev/tty.usbserial-A9007Qr6');	
        
elseif os == 2 % Linux

        [ dev_port ] = TTY_id( id );

        ardu = serial(dev_port);
        %ardu = serial('/dev/ttyUSB0');  
        %ardu = serial('/dev/ttyS0');
        
end

set(ardu,'inputbuffersize',buffer_size);

% if N_stim > 40
    set(ardu,'Timeout',100);
% else
%     set(ardu,'Timeout',30);
% end

fopen(ardu);
pause(2);							% espera a que fopen termine

end

