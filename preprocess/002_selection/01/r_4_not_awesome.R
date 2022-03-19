library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%

  # 在select 函数的参数中设置要提取的列的列名，提取相应的列
  # 使用starts_with函数抽取以check开头的列
  select(reserve_id, hotel_id, customer_id, reserve_datetime,
         starts_with('check'))
