% function [S, A] = f3_RecibeDatosINGKA(ingka,ardu) %Descarga los datos del trial
function [t_acc,x_acc,y_acc,z_acc,t_pr,pr] = f3_RecibeDatosINGKA(ingka,ardu) %Descarga los datos del trial

ingka_buff = [];
aux = ' ';
counter2 = 0;
c_0=1;
c_2=1;


flushinput(ingka);

fprintf(ingka,'#0007\n');
fgetl(ingka);

while isempty(strfind(aux,'A'))
    
    if ardu.BytesAvailable
        aux = fgetl(ardu);
    else
        aux2 = fgetl(ingka);
        counter2=counter2+1;
        ingka_buff{counter2} = aux2;
    end
end

fprintf(ingka,'#0009\n')
fgetl(ingka);

flushinput(ingka);

for kk = 1:length(ingka_buff)
            
            if strcmp(ingka_buff{kk}(1),'0')
                
                aux = sscanf(ingka_buff{kk},'%d\t%lu\t%d');
                
                if length(aux)==3
                    c_0 = c_0+1;
                    t_pr(c_0) = aux(2);
                    pr(c_0) = aux(3);
                end
                
            elseif strcmp(ingka_buff{kk}(1),'2')
                
                aux = sscanf(ingka_buff{kk},'%d\t%lu\t%d\t%d\t%d');
                
                if length(aux)==5
                    c_2 = c_2+1;
                    t_acc(c_2) = aux(2);
                    x_acc(c_2) = aux(3);
                    y_acc(c_2) = aux(4);
                    z_acc(c_2) = aux(5);
                end
                
            end
            
end
        
end