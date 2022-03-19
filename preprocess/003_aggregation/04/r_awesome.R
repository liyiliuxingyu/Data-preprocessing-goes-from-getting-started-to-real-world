library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%
  group_by(hotel_id) %>%

  # 在var函数中指定total_price，计算方差
  # 在sd函数中指定total_price，计算标准差
  # 当数据条数为1时，值NA
  # 通过coalesce函数将NA替换为0
  summarise(price_var=coalesce(var(total_price), 0),
            price_std=coalesce(sd(total_price), 0))
