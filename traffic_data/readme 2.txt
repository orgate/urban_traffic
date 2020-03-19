Figures for the COMSNETS paper created with 
Calculation_wt_data_dist.m (see the other Bamgalore data folder)

Following suggestions that we should only use data for taxis which
are moving (by using their lat long position) the following program
was created

calc_congestion_time.m

It uses the data file
bangalore_latlong_data.mat

that contains data for latitude and longitude of all taxis moving on a
particular day

The structure Strt_ind contains information about the number of taxis
on each day (129 on Day 1, 119 on Day 2, etc.) and the corresponding
indices in e.g., Strt_ind{1,1} tells us which indices in the Lat 
and Long correspond to which taxi on the 1st day
e.g., entries 1 to 1569 corresponds to the 1st taxi

