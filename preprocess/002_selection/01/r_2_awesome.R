library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 将二维数组reserve_tb 的第二维度指定为字符串向量，提取相应的列
reserve_tb[, c('reserve_id', 'hotel_id', 'customer_id', 'reserve_datetime',
               'checkin_date', 'checkin_time', 'checkout_date')]
