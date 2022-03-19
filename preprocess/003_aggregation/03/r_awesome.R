library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%
  group_by(hotel_id) %>%

  # 为quantile函数指定total_price和目标值，计算第20百分位数
  summarise(price_max=max(total_price),
            price_min=min(total_price),
            price_avg=mean(total_price),
            price_median=median(total_price),
            price_20per=quantile(total_price, 0.2))
