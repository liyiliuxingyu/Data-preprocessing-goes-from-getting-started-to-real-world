library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%

  # 在filter函数中指定checkin_date的条件表达式，提取满足条件的行
  filter(checkin_date >= '2016-10-12' & checkin_date <= '2016-10-13')
