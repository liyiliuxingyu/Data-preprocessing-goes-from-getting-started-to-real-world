library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 对reserve_table和hotel_tb以hotel_id为键执行内连接
inner_join(reserve_tb, hotel_tb, by='hotel_id') %>%
  
  # 仅抽取people_num为1且is_business为True的数据
  filter(people_num == 1, is_business)
