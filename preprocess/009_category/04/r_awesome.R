library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
customer_tb %>%
  mutate(sex_and_age=factor(paste(floor(age / 10) * 10, sex, sep='_')))
