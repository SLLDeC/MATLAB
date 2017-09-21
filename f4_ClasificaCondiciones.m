function [ condicion, cond_order ] = f4_ClasificaCondiciones( temporal_sizes, mechanical_sizes, perturb_size, mechanical_size )
% Clasifica trials según su número de condición

temporal_sizes=[0 50];
mechanical_sizes=[50 100 150];
total_cond=length(temporal_sizes)*length(mechanical_sizes);
num_cond=(1:total_cond);
cond_order=[reshape(num_cond,length(temporal_sizes),length(mechanical_sizes))]';

fila=find(mechanical_sizes==mechanical_size);
columna=find(temporal_sizes==temporal_size);

condicion=cond_order(fila,columna);

end
