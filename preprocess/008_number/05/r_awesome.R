library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%
  filter(abs(total_price - mean(total_price)) / sd(total_price) <= 3)
