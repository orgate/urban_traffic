function bat = wt_times_exponent(i_str)

    i = str2num(i_str);
%   i = i_str;%str2num(i_str);
    
   sigcyc = [10,13,16,20,25,32,40,50,63,79,100,126,158,200,251,316,398,501,631,794,1000];
   
    if(i>0 && i<=21)
        pfil = load(['wt_times_fig3_less_sig_' num2str(sigcyc(i)) '.mat']);
        tempwt = pfil.wt{1,1};
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)

        if(length(tempwt)>0)
            [alp, alp_var, xmin, n] = plvar1(tempwt,'reps',5);%fixing the xmin to be 3.0
        end
        save(['alphas_less_sig_' num2str(i) '.mat'],'alp','alp_var','xmin','n');
        
    end
    
    
    
    if(i>21 && i<=32)
        pfil = load(['wt_times_fig3_less_dr_' num2str(i-22) '.mat']);
        tempwt = pfil.wt{1,1};
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)

        if(length(tempwt)>0)
            [alp, alp_var, xmin, n] = plvar1(tempwt,'reps',5);%fixing the xmin to be 3.0
        end
        save(['alphas_less_dr_' num2str(i) '.mat'],'alp','alp_var','xmin','n');
        
    end

    if(i>32 && i<=51)
        pfil = load(['wt_times_fig3_less_P_' num2str((i-32)*10) '.mat']);
        tempwt = pfil.wt{1,1};
        tempwt(abs(tempwt)>1e10) = [];%removing blown up values of the order of 1e153 (that's caused due to decimal truncation of floating point numbers in matlab)

        if(length(tempwt)>0)
            [alp, alp_var, xmin, n] = plvar1(tempwt,'reps',5);%fixing the xmin to be 3.0
        end
        save(['alphas_less_P_' num2str(i) '.mat'],'alp','alp_var','xmin','n');
        
    end
    
    bat = i;
    
end