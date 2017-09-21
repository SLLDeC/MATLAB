function [ o,trial,temporal ] = save_good_data_ALTURAS(temporal,step,j,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,trial,B_laps )

trial(j).order = o;
trial(j).trial = j;

for h=1:length(B_laps);
    if ismember(j,[B_laps(h)-9:B_laps(h)])==1
        trial(j).block=h;
    else
    end
end

trial(j).mech_size = mech_size;
trial(j).mech_bip = mech_bip;
trial(j).stim = stim;
trial(j).resp = resp;
trial(j).asyn = asyn;
trial(j).x_acc(1,:) = x_acc;
trial(j).x_acc(2,:) = t_acc;
trial(j).y_acc(1,:) = y_acc;
trial(j).y_acc(2,:) = t_acc;
trial(j).z_acc(1,:) = z_acc;
trial(j).z_acc(2,:) = t_acc;
trial(j).pr(1,:) = pr;
trial(j).pr(2,:) = t_pr;

o=o+1;

if step==1
     save('temporal_ent.mat','trial')
elseif step==2
    save('temporal_exp.mat','trial')
end

end