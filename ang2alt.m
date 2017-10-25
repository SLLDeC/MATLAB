function [ altura ] = ang2alt( angulo )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if angulo==33
                altura=-1.5;
            elseif angulo==40
                altura=-1;
            elseif angulo==48
                altura=-0.5;
            elseif angulo==57
                altura=0;
            elseif angulo==65
                altura=0.5;
            elseif angulo==75
                altura=1;
            elseif angulo==100
                altura=1.5;
            end



end

