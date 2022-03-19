library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下 
reserve_tb %>%

  # 通过group_by函数，按customer_id对数据进行分组
  # 注意列名customer_id不加引号
  group_by(customer_id) %>%

  # 使用lag函数获取往前数第2条记录的total_price，将其作为before_price
  # 将lag函数引用的分组内的数据指定为按reserve_datetime的时间先后排序
  mutate(before_price=lag(total_price, n=2,
                          order_by=reserve_datetime, default=NA))
