library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()
load_holiday_mst()

# 本书刊登内容如下
# 与休息日主数据连接
inner_join(reserve_tb, holiday_mst, by=c('checkin_date'='target_day'))
