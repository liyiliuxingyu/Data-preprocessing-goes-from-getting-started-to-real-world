library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%

  # 在group_by中指定hotel_id和people_num的组合
  group_by(hotel_id, people_num) %>%

  # 将sum函数应用于total_price列，计算住宿费总额
  summarise(price_sum=sum(total_price))
