function bat = data_exponent(i_str)

%    i = str2num(i_str);
   i = i_str;
    
    
    switch i,
        case 1, load(['wait_time_bang_day_avg5_2013_fullyear.mat'],'y1a');
            [alp, alp_var, xmin, n] = plvar1(y1a,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_bang_day_avg5_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 2, load(['wait_time_bang_night_avg5_2013_fullyear.mat'],'y1b');
            [alp, alp_var, xmin, n] = plvar1(y1b,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_bang_night_avg5_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 3, load(['wait_time_bang_day_avg7_5_2013_fullyear.mat'],'fy2a');
            [alp, alp_var, xmin, n] = plvar1(fy2a,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_bang_day_avg7_5_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 4, load(['wait_time_bang_night_avg7_5_2013_fullyear.mat'],'fy2b');
            [alp, alp_var, xmin, n] = plvar1(fy2b,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_bang_night_avg7_5_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 5, load(['wait_time_bang_day_avg10_2013_fullyear.mat'],'y2a');
            [alp, alp_var, xmin, n] = plvar1(y2a,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_bang_day_avg10_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 6, load(['wait_time_bang_night_avg10_2013_fullyear.mat'],'y2b');
            [alp, alp_var, xmin, n] = plvar1(y2b,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_bang_night_avg10_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 7, load(['wait_time_del_day_avg5_2013_fullyear.mat'],'z1a');
            [alp, alp_var, xmin, n] = plvar1(z1a,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_del_day_avg5_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 8, load(['wait_time_del_night_avg5_2013_fullyear.mat'],'z1b');
            [alp, alp_var, xmin, n] = plvar1(z1b,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_del_night_avg5_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 9, load(['wait_time_del_day_avg7_5_2013_fullyear.mat'],'fz2a');
            [alp, alp_var, xmin, n] = plvar1(fz2a,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_del_day_avg7_5_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 10, load(['wait_time_del_night_avg7_5_2013_fullyear.mat'],'fz2b');
            [alp, alp_var, xmin, n] = plvar1(fz2b,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_del_night_avg7_5_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 11, load(['wait_time_del_day_avg10_2013_fullyear.mat'],'z2a');
            [alp, alp_var, xmin, n] = plvar1(z2a,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_del_day_avg10_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        case 12, load(['wait_time_del_night_avg10_2013_fullyear.mat'],'z2b');
            [alp, alp_var, xmin, n] = plvar1(z2b,'reps',20,'silent');%fixing the xmin to be 3.0
            save(['alphas_del_night_avg10_2013_fullyear.mat'],'alp','alp_var','xmin','n');
        otherwise print('Error');
    end
    
            
    bat = 1;
    
end