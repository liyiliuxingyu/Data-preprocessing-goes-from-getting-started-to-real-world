library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%

  # 通过group_by函数将hotel_id指定为聚合单元
  group_by(hotel_id) %>%

  # 使用summarise函数指定聚合处理
  # 使用n函数计算预订记录数
  # 将customer_id 指定给n_distinct 函数，实现customer_id 的唯一值计数
  summarise(rsv_cnt=n(),
            cus_cnt=n_distinct(customer_id))
