%% Clasifica el trial seg�n su condicion
function [ condicion ] = f4_ClasificaCondicionesTrials(mechanical_size,perturb_size)    

servo_low_pos=30; servo_ini_pos=57; servo_high_pos=105;
negative_sc=-50; iso=0; positive_sc=50;

if mechanical_size == servo_low_pos && perturb_size == negative_sc
    condicion=1;
elseif mechanical_size == servo_low_pos && perturb_size == iso
    condicion=2;
elseif mechanical_size == servo_low_pos && perturb_size == positive_sc
    condicion=3;
elseif mechanical_size == servo_ini_pos && perturb_size == negative_sc
    condicion=4;    
elseif mechanical_size == servo_ini_pos && perturb_size == iso
    condicion=5;        
elseif mechanical_size == servo_ini_pos && perturb_size == positive_sc
    condicion=6;
elseif mechanical_size == servo_high_pos && perturb_size == negative_sc
    condicion=7;  
elseif mechanical_size == servo_high_pos && perturb_size == iso
    condicion=8;  
elseif mechanical_size == servo_high_pos && perturb_size == positive_sc
    condicion=9;  
end

end