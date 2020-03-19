#splitting the data with taxi wise
rm(list=ls())
load('bang_20130402.dat')
i=1#counting the number of taxi in the date of bang city
while(length(bang_device_id)>0)
{ ind=bang_device_id==bang_device_id[1];bang_device_id=bang_device_id[-ind];
  a=bang_timestamp[ind];bang_timestamp=bang_timestamp[-ind];
  b=bang_latitude[ind];bang_latitude=bang_latitude[-ind];
  c=bang_longitude[ind];bang_longitude=bang_longitude[-ind];
  d=bang_speed[ind];bang_speed=bang_speed[-ind];
  e=bang_distance[ind];bang_distance[-ind];
  x=cbind(a,b,c,d,e);
  assign(paste("tx_", i, sep= ""),x);
  i=i+1;
  }

rm(bang_timestamp,bang_road_area_id,bang_latitude,bang_longitude,bang_speed,bang_distance,bang_device_id,x,i,a,b,c,d,e,ind)
save.image(file="bang_txwise_20130402.dat")

