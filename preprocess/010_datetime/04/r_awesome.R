library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
library(lubridate)

# 将reserve_datetime转换为POSIXct类型
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# 将reserve_date转换为Date类型
reserve_tb$reserve_date <-
  as.Date(reserve_tb$reserve_datetime, format='%Y-%m-%d')

# 将reserve_datetime加上1天
reserve_tb$reserve_datetime + days(1)

# 将reserve_datetime加上1时
reserve_tb$reserve_datetime + hours(1)

# 将reserve_datetime加上1分
reserve_tb$reserve_datetime + minutes(1)

# 将reserve_datetime加上1秒
reserve_tb$reserve_datetime + seconds(1)

# 将reserve_date加上1天
reserve_tb$reserve_date + days(1)
