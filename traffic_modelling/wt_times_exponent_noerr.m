function bat = wt_times_exponent_noerr(i_str)

    i = str2num(i_str);
    
    if(i>0 && i<=21)
        pfil = load(['wt_times_fig3_sig_' num2str(i) '.mat']);
        tempwt = pfil.wt;
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)

        if(length(tempwt)>0)
            [alpha, xmin, l] = plfit1(tempwt,'nosmall');%fixing the xmin to be 3.0
        end
        save(['alphas_noerr_sig_' num2str(i) '.mat'],'alpha','xmin','l');
        
    end
    
    
    
    if(i>21 && i<=32)
        pfil = load(['wt_times_fig3_dr_' num2str(i-21) '.mat']);
        tempwt = pfil.wt;
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)

        if(length(tempwt)>0)
            [alpha, xmin, l] = plfit1(tempwt,'nosmall');%fixing the xmin to be 3.0
        end
        save(['alphas_noerr_dr_' num2str(i) '.mat'],'alpha','xmin','l');
        
    end

    if(i>32 && i<=51)
        pfil = load(['wt_times_fig3_P_' num2str(i-32) '.mat']);
        tempwt = pfil.wt;
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)

        if(length(tempwt)>0)
            [alpha, xmin, l] = plfit1(tempwt,'nosmall');%fixing the xmin to be 3.0
        end
        save(['alphas_noerr_P_' num2str(i) '.mat'],'alpha','xmin','l');
        
    end
    
    bat = 1;
    
end