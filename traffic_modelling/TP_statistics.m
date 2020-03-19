% To find the TP statistics 
% As described in Pisarekko and Sornette, Physica A, 366 (2006) 387-400
%
% function [u,y,y_std]=TP_statistics(data_p,x_min,x_max)

%Default x_min=min(data), 
%Default logbase=2  %% must be >= 1 %%
%Default n_bin=10 %% number of bins %%
%Give dummy for calculation, else limits of data

%function [u,y,y_std]=TP_statistics(data,u_min,u_max,u_lim)
function [u,y,y_std]=TP_statistics(data,u_min,u_max)
%if (nargin < 3 )
%  x_min=min(data_p);
%end
%if (nargin < 4)
%    logbase = 2
%end
%if (nargin < 5 )
%    n_bin=10;
%end


local=0;
u1=u_min;
while u1 <= u_max,
    local=local+1;
    sum1=0;
    sum2=0;

    x=data(data > u1) ;
    size1=length(x);

    for k = 1:size1,
        sum1=sum1+log(x(k)/u1);
        sum2=sum2+log(x(k)/u1)^2;
    end
    u(local)=u1;
    sum1=sum1/size1;
    sum2=sum2/size1;
    y(local)=sum1^2-sum2/2;
    
    
    %sum3=zeros(1,size1);
    %sum4=sum2/(2*size1)-2*(sum1/size1)^2;
    %for k = 1:size1,
    %    sum3(k)=sum4+(2*(sum1/size1)*log(x(k)/u1) - 0.5*log(x(k)/u1)^2)/size1;
    %end
    %y_std(local)=std(sum3);

    sum3=0;
    for k = 1:size1,
        sum3=sum3+(2*sum1*log(x(k)/u1) - 0.5*log(x(k)/u1)^2-sum2/2)^2;
    end
    sum3=sqrt(sum3/size1);
    y_std(local)=sum3/sqrt(size1);

 %   u1=u1*u_lim;
    end
    

        
