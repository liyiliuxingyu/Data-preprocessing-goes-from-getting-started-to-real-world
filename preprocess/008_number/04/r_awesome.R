library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 通过scale对参数的列值进行归一化
# 将center参数设置为TRUE，则转换结果的平均值为0
# 将scale参数设置为TRUE，则转换结果的方差为1 
reserve_tb %>%
  mutate(
    people_num_normalized=scale(people_num, center=TRUE, scale=TRUE),
    total_price_normalized=scale(total_price, center=TRUE, scale=TRUE)
  )
