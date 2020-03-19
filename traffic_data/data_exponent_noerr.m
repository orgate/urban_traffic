function bat = data_exponent_noerr(i_str)

%    i = str2num(i_str);
   i = i_str;
    
    
    switch i,
        case 1, load(['wait_time_bang_day_avg5_2013_fullyear.mat'],'y1a');
            [alpha, xmin, l] = plfit1(y1a,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_bang_day_avg5_2013_fullyear.mat'],'alpha','xmin','l');
        case 2, load(['wait_time_bang_night_avg5_2013_fullyear.mat'],'y1b');
            [alpha, xmin, l] = plfit1(y1b,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_bang_night_avg5_2013_fullyear.mat'],'alpha','xmin','l');
        case 3, load(['wait_time_bang_day_avg7_5_2013_fullyear.mat'],'fy2a');
            [alpha, xmin, l] = plfit1(fy2a,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_bang_day_avg7_5_2013_fullyear.mat'],'alpha','xmin','l');
        case 4, load(['wait_time_bang_night_avg7_5_2013_fullyear.mat'],'fy2b');
            [alpha, xmin, l] = plfit1(fy2b,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_bang_night_avg7_5_2013_fullyear.mat'],'alpha','xmin','l');
        case 5, load(['wait_time_bang_day_avg10_2013_fullyear.mat'],'y2a');
            [alpha, xmin, l] = plfit1(y2a,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_bang_day_avg10_2013_fullyear.mat'],'alpha','xmin','l');
        case 6, load(['wait_time_bang_night_avg10_2013_fullyear.mat'],'y2b');
            [alpha, xmin, l] = plfit1(y2b,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_bang_night_avg10_2013_fullyear.mat'],'alpha','xmin','l');
        case 7, load(['wait_time_del_day_avg5_2013_fullyear.mat'],'z1a');
            [alpha, xmin, l] = plfit1(z1a,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_del_day_avg5_2013_fullyear.mat'],'alpha','xmin','l');
        case 8, load(['wait_time_del_night_avg5_2013_fullyear.mat'],'z1b');
            [alpha, xmin, l] = plfit1(z1b,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_del_night_avg5_2013_fullyear.mat'],'alpha','xmin','l');
        case 9, load(['wait_time_del_day_avg7_5_2013_fullyear.mat'],'fz2a');
            [alpha, xmin, l] = plfit1(fz2a,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_del_day_avg7_5_2013_fullyear.mat'],'alpha','xmin','l');
        case 10, load(['wait_time_del_night_avg7_5_2013_fullyear.mat'],'fz2b');
            [alpha, xmin, l] = plfit1(fz2b,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_del_night_avg7_5_2013_fullyear.mat'],'alpha','xmin','l');
        case 11, load(['wait_time_del_day_avg10_2013_fullyear.mat'],'z2a');
            [alpha, xmin, l] = plfit1(z2a,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_del_day_avg10_2013_fullyear.mat'],'alpha','xmin','l');
        case 12, load(['wait_time_del_night_avg10_2013_fullyear.mat'],'z2b');
            [alpha, xmin, l] = plfit1(z2b,'nosmall');%fixing the xmin to be 3.0
            save(['alphas_noerr_del_night_avg10_2013_fullyear.mat'],'alpha','xmin','l');
        otherwise print('Error');
    end
    
            
    bat = 1;
    
end