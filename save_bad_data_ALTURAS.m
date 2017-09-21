function [ o,r,bad,temporal ] = save_bad_data_ALTURAS(temporal,step,r,o,stim,resp,asyn,error,t_acc,x_acc,y_acc,z_acc,t_pr,pr,mech_size,mech_bip,bad,B_laps )

bad(r).order = o;
bad(r).trial = r;

for h=1:length(B_laps);
    if ismember(r,[B_laps(h)-9:B_laps(h)])==1
        bad(r).block=h;
    else
    end
end

bad(r).mech_size = mech_size;
bad(r).mech_bip = mech_bip;
bad(r).stim = stim;
bad(r).resp = resp;
bad(r).asyn = asyn;
bad(r).type = error;
bad(r).x_acc(1,:) = x_acc;
bad(r).x_acc(2,:) = t_acc;
bad(r).y_acc(1,:) = y_acc;
bad(r).y_acc(2,:) = t_acc;
bad(r).z_acc(1,:) = z_acc;
bad(r).z_acc(2,:) = t_acc;
bad(r).pr(1,:) = pr;
bad(r).pr(2,:) = t_pr;

o=o+1;
r=r+1;

if step==1
    temporal.ent_bad=bad;
elseif step==2
       temporal.exp_bad=bad;
end


save('temporal.mat','temporal')

end

