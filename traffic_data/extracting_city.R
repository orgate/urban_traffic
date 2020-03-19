csv.data<-read.csv('eventdata_20130430.csv')
Device_id=csv.data[,1]
timestamp=csv.data[,2]
latitude=csv.data[,3]
longitude=csv.data[,4]
speed=csv.data[,5]
distance=csv.data[,6]
road_area_id=csv.data[,7]
bang_ind_lat1=latitude>12
bang_ind_lat2=latitude<14
bang_ind_lat=bang_ind_lat1&bang_ind_lat2
bang_ind_long1=longitude>77
bang_ind_long2=longitude<78
bang_ind_long=bang_ind_long1&bang_ind_long2
bang_ind=bang_ind_lat&bang_ind_long

madras_ind_lat1=latitude>12
madras_ind_lat2=latitude<14
madras_ind_long1=longitude>80
madras_ind_long2=longitude<80.5
madras_ind_lat=madras_ind_lat1&madras_ind_lat2
madras_ind_long=madras_ind_long1&madras_ind_long2
madras_ind=madras_ind_lat&madras_ind_long

delhi_ind_lat1=latitude>28
delhi_ind_lat2=latitude<29
delhi_ind_long1=longitude>76
delhi_ind_long2=longitude<78
delhi_ind_lat=delhi_ind_lat1&delhi_ind_lat2
delhi_ind_long=delhi_ind_long1&delhi_ind_long2
delhi_ind=delhi_ind_lat&delhi_ind_long

bombay_ind_lat1=latitude>18
bombay_ind_lat2=latitude<20
bombay_ind_long1=longitude>72
bombay_ind_long2=longitude<73
bombay_ind_lat=bombay_ind_lat1&bombay_ind_lat2
bombay_ind_long=bombay_ind_long1&bombay_ind_long2
bombay_ind=bombay_ind_lat&bombay_ind_long

pune_ind_lat1=latitude>18.5
pune_ind_lat2=latitude<18.6
pune_ind_long1=longitude>73
pune_ind_long2=longitude<74
pune_ind_lat=pune_ind_lat1&pune_ind_lat2
pune_ind_long=pune_ind_long1&pune_ind_long2
pune_ind=pune_ind_lat&pune_ind_long

bang_device_id=Device_id[bang_ind]
madras_device_id=Device_id[madras_ind]
delhi_device_id=Device_id[delhi_ind]
bombay_device_id=Device_id[bombay_ind]
pune_device_id=Device_id[pune_ind]

bang_timestamp=timestamp[bang_ind]
madras_timestamp=timestamp[madras_ind]
delhi_timestamp=timestamp[delhi_ind]
bombay_timestamp=timestamp[bombay_ind]
pune_timestamp=timestamp[pune_ind]

bang_latitude=latitude[bang_ind]
madras_latitude=latitude[madras_ind]
delhi_latitude=latitude[delhi_ind]
bombay_latitude=latitude[bombay_ind]
pune_latitude=latitude[pune_ind]

bang_longitude=longitude[bang_ind]
madras_longitude=longitude[madras_ind]
delhi_longitude=longitude[delhi_ind]
bombay_longitude=longitude[bombay_ind]
pune_longitude=longitude[pune_ind]

bang_speed=speed[bang_ind]
madras_speed=speed[madras_ind]
delhi_speed=speed[delhi_ind]
bombay_speed=speed[bombay_ind]
pune_speed=speed[pune_ind]


bang_distance=distance[bang_ind]
madras_distance=distance[madras_ind]
delhi_distance=distance[delhi_ind]
bombay_distance=distance[bombay_ind]
pune_distance=distance[pune_ind]


bang_road_area_id=road_area_id[bang_ind]
madras_road_area_id=road_area_id[madras_ind]
delhi_road_area_id=road_area_id[delhi_ind]
bombay_road_area_id=road_area_id[bombay_ind]
pune_road_area_id=road_area_id[pune_ind]

save(bang_road_area_id,bang_distance,bang_speed,bang_longitude,bang_latitude,bang_timestamp,bang_device_id,file="bang_20130430.dat")
save(madras_road_area_id,madras_distance,madras_speed,madras_longitude,madras_latitude,madras_timestamp,madras_device_id,file="madras_20130430.dat")
save(delhi_road_area_id,delhi_distance,delhi_speed,delhi_longitude,delhi_latitude,delhi_timestamp,delhi_device_id,file="delhi_20130430.dat")
save(bombay_road_area_id,bombay_distance,bombay_speed,bombay_longitude,bombay_latitude,bombay_timestamp,bombay_device_id,file="bombay_20130430.dat")
save(pune_road_area_id,pune_distance,pune_speed,pune_longitude,pune_latitude,pune_timestamp,pune_device_id,file="pune_20130430.dat")



