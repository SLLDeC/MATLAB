function [temp_sizes,esc_sizes] = Parametros_calibracion_exp(cat_M,sujeto_number,sujeto,out_limit,mech_sizes)
%% Fiteo de los datos de calibracion
% Calibracion con 2 lineales de los puntos extremos

s=sujeto_number;
n_cond=length(mech_sizes)+1;
n_cal=length(sujeto(s).cal);
pre_baseline_bips=1;
ASYN=nan(n_cal,n_cond);

for t=1:length(sujeto(s).cal)
    pert_bip=sujeto(s).cal(t).mech_bip; % #bip perturbado 
    pert_indx=find(sujeto(s).cal(t).asyn(2,:)==pert_bip); %indice del bip perturbado
    % calculo el prebaseline como el promedio de 'prebaseline_bips' asyn previas a la
    % perturbación
    pre_baseline=mean(sujeto(s).cal(t).asyn(1,pert_indx-pre_baseline_bips:pert_indx));
    c=find(sujeto(s).cal(t).mech_size==mech_sizes); % numero de condicion experimental
    % Si el trial no tiene una asyn outlier (asyn-baseline>limite
    % permitido), completa la matriz con el valor de asyn-bs (-M y +M) y bs
    % (M=0)
    if isempty(find(abs(sujeto(s).cal(t).asyn(1,:)-pre_baseline)>=out_limit))==1
        ASYN(t,c)=sujeto(s).cal(t).asyn(1,pert_indx+1)-pre_baseline;
        ASYN(t,n_cond)=pre_baseline;
    end
end

asyn=nanmean(ASYN);

% Fiteo lineal
fitType='poly1'; % Funciï¿½n de fiteo

x_down=[ang2alt_servo(min(mech_sizes)) 0]';
y_down=[asyn(1) 0]';

x_up=[0 ang2alt_servo(max(mech_sizes))]';
y_up=[0 asyn(2)]';

[fiteo_up,gof_up] = fit(x_up,y_up,fitType);
[fiteo_down,gof_down] = fit(x_down,y_down,fitType);

% asincronía límite
if abs(fiteo_up.p1)>=abs(fiteo_down.p1) %NORMALMENTE!! Si m_up es mayor a m_down
asyn_max=fiteo_down.p1*x_down(1); % asincronia -M

for k=length(cat_M):1
    if asyn_max>=cat_M(k){
        asyn_max=cat_M(k);
        break}
    end
end

esc_max=x_down(1);

asyn_sim=-asyn_max; % asincronia simetrica
esc_sim=asyn_sim/fiteo_up.p1;
else
asyn_max=fiteo_up.p1*x_up(2); % asincronia -M
esc_max=x_up(2);
asyn_sim=-asyn_max; % asincronia simetrica
esc_sim=asyn_sim/fiteo_down.p1;
end

if asyn_max


temp_sizes=round([asyn_max asyn_sim]);
esc_sizes=[esc_sim esc_max];
end