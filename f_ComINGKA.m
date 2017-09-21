function [ ingka ] = f_ComINGKA( os )
% Conecta con ingka segun el sistema operativo.
id=1;% Identificador mega=0, SAD=1

if os == 1 % Windows
    [ port ] = COM_id( id );
    ingka = serial(port,'BaudRate',115200);
elseif   os == 3 % Mac os x
    ingka = serial('/dev/tty.usbserial-A9007Qr6');
elseif os == 2 % Linux   
   [ dev_port ] = TTY_id( id );
    ingka = serial(dev_port);

end

fopen(ingka);
% pause(5);	

fprintf(ingka,'#0001\n');
fgetl(ingka);
fprintf(ingka,'#0031 462815232 1943863296 831782912 1421148160 \n');
fgetl(ingka);
fprintf(ingka,'#0033 239589820 3486795892 3188765557 2136465651 \n');
fgetl(ingka);
fprintf(ingka,'#0005 0 1 27 4 5 1 0 0 0 0 0 0 0 0 \n');
fgetl(ingka);
fprintf(ingka,'#0005 2 10 10 7 5 1 0 0 0 0 0 0 0 0 \n');
fgetl(ingka);
fprintf(ingka,'#0017\n');
fgetl(ingka);

end

