library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
library(lubridate)

# 将reserve_datetime转换为POSIXct类型
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# 将checkin_datetime转换为POSIXct类型
reserve_tb$checkin_datetime <-
  as.POSIXct(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
             format='%Y-%m-%d %H:%M:%S')

# 计算年份差(不考虑月及其以后的时间元素) 
year(reserve_tb$checkin_datetime_lt) - year(reserve_tb$reserve_datetime)

# 获取月份差 (不考虑天及其以后的时间元素)
(year(reserve_tb$checkin_datetime) * 12
 + month(reserve_tb$checkin_datetime)) -
(year(reserve_tb$reserve_datetime) * 12
 + month(reserve_tb$reserve_datetime))

# 以天为单位计算差值
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='days')

# 以时为单位计算差值
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='hours')

# 以分为单位计算差值
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='mins')

# 以秒为单位计算差值
difftime(reserve_tb$checkin_datetime, reserve_tb$reserve_datetime,
         units='secs')
