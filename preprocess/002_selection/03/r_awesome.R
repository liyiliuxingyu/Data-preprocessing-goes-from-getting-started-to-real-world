library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 从reserve_tb中采样50%
sample_frac(reserve_tb, 0.5)
