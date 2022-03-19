library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%

  # 使用as.Date函数将字符串型转换为日期型（详见10-1节）
  # 使用between函数指定checkin_date值的范围
  filter(between(as.Date(checkin_date),
                 as.Date('2016-10-12'), as.Date('2016-10-13')))
