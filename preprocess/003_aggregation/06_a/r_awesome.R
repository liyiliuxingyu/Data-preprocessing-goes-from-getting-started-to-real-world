library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 为使用rownumber函数进行排序，将数据类型由字符串转换为POSIXct类型（详见第10章）
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

reserve_tb %>%

  # 使用group_by函数指定聚合单元
  group_by(customer_id) %>%

  # 使用mutate函数添加新列log_no
  # 使用row_number函数基于预订时间计算位次
  mutate(log_no=row_number(reserve_datetime))
