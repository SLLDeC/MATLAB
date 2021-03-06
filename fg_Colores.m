function [lineprops] = fg_Colores(c)

    dark_blue=[0 0 0.4];
    blue=[0 0.1 0.8];
    light_blue=[0 0.5 1];
    
    dark_red=[0.3 0 0];
    red=[0.7 0 0];
    light_red=[0.9 0.5 0.5];
    
    orange = [1 0.5 0.2];
    black=[0 0 0];
    
    dark_green=[0 0.3 0];
    green=[0.3 0.5 0];
    light_green=[0.6 0.9 0.5];
    
    if c==1
        lineprops.col{1}=dark_blue;
    elseif c==2
        lineprops.col{1}=blue;
    elseif c==3
        lineprops.col{1}=light_blue;
    elseif c==4
        lineprops.col{1}=dark_red;
    elseif c==5
        lineprops.col{1}=red;
        lineprops.edgestyle = '-';
    elseif c==6
        lineprops.col{1}=light_red;
    elseif c==7
        lineprops.col{1}=dark_green;
    elseif c==8
        lineprops.col{1}=green;
        elseif c==9
        lineprops.col{1}=light_green;
    end
    
    color=[dark_blue blue light_blue dark_red red light_red dark_green green light_green];

end