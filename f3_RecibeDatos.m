% function [stim,resp,force,asyn,error,data] = f3_RecibeDatos(ardu) %Descarga los datos del trial
function [stim,resp,asyn,error,data] = f3_RecibeDatos(ardu) %Descarga los datos del trial

aux = fgetl(ardu);
stim = [];stim_num = 1;
resp = [];resp_num = 1;
force = [];force_num = 1;
asyn = [];asyn_num = 1;
data = [];error = [];
a1=[];a2=[];
counter = 1;

while (~strcmp(aux(1),'E'))
    data{counter} = aux;
    aux = fgetl(ardu);
    counter = counter + 1;
end

for i = 1:counter-1
    aux = data{i};
    if aux(1) == 'S'
        ind1 = find(aux==' ',1);
        ind2 = find(aux=='(')-1;
        stim_num = str2num(aux(ind1:ind2));
        ind3 = find(aux==':')+2;
        ind4 = find(aux==';')-1;
        stim(1,stim_num) = str2num(aux(ind3:ind4));
        ind5 = find(aux=='(')+1;
        ind6 = find(aux==')')-1;
        stim(2,stim_num) = str2num(aux(ind5:ind6));
        
    elseif aux(1) == 'R'
        ind1 = find(aux==' ',1);
        ind2 = find(aux=='(')-1;
        resp_num = str2num(aux(ind1:ind2));
        ind3 = find(aux==':')+2;
        ind4 = find(aux==';')-1;
        resp(1,resp_num) = str2num(aux(ind3:ind4));
        ind5 = find(aux=='(')+1;
        ind6 = find(aux==')')-1;
        resp(2,resp_num) = str2num(aux(ind5:ind6));
        
        elseif aux(1) == 'F'
        ind1 = find(aux==' ',1);
        ind2 = find(aux=='(')-1;
        force_num = str2num(aux(ind1:ind2));
        ind3 = find(aux==':')+2;
        ind4 = find(aux==';')-1;
        force(1,force_num) = str2num(aux(ind3:ind4));
        ind5 = find(aux=='(')+1;
        ind6 = find(aux==')')-1;
        force(2,force_num) = str2num(aux(ind5:ind6));
        
    elseif aux(1) == 'A'
        ind1 = find(aux==' ',1);
        ind2 = find(aux=='(')-1;
        asyn_num = str2num(aux(ind1:ind2));
        ind3 = find(aux==':')+2;
        ind4 = find(aux==';')-1;
        asyn(1,asyn_num) = str2num(aux(ind3:ind4));
        ind5 = find(aux=='(')+1;
        ind6 = find(aux==')')-1;
        asyn(2,asyn_num) = str2num(aux(ind5:ind6));
        
    elseif aux(1) == 'M'
        error = 'missing' ;
        
    elseif aux(1) == 'X'
        error = 'extra' ;
        
    elseif aux(1) == 'B'
        error = 'bad' ;
        
    end
end

end
