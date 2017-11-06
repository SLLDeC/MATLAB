function [ angulo ] = alt2ang_servo( altura )
% Convierte a grados el valor en cent�metros de la altura del escal�n
b=[4.1234    0.0028   19.7756   -2.4426]; % calculado de sin_fit

% h(i)=b(1)*sin(2*pi*b(2)*(ang(i)-b(3)))+b(4)

angulo = round(asin((altura-b(4))/b(1))/(2*pi*b(2)) + b(3));

end
