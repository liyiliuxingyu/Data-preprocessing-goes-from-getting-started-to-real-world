library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%
  mutate(total_price_log=log((total_price / 1000 + 1), 10))
