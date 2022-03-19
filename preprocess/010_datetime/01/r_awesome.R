library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# lubridate库
# (包含parse_date_time, parse_date_time2, fast_strptime的库)
library(lubridate)

# 转换为POSIXct类型
as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
as.POSIXct(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
           format='%Y-%m-%d %H:%M:%S')

# 转换为POSIXlt类型
as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
as.POSIXlt(paste(reserve_tb$checkin_date, reserve_tb$checkin_time), 
           format='%Y-%m-%d %H:%M:%S')

# 通过parse_date_time函数转换为POSIXct类型
parse_date_time(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')
parse_date_time(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
                orders='%Y-%m-%d %H:%M:%S')

# 通过parse_date_time2函数转换为POSIXct类型
parse_date_time2(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')
parse_date_time2(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
                 orders='%Y-%m-%d %H:%M:%S')

# 通过strptime函数转换为POSIXlt类型
strptime(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
strptime(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
         format='%Y-%m-%d %H:%M:%S')

# 通过fast_strptime函数转换为POSIXlt类型
fast_strptime(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')
fast_strptime(paste(reserve_tb$checkin_date, reserve_tb$checkin_time),
              format='%Y-%m-%d %H:%M:%S')

# 转换为Date类型
as.Date(reserve_tb$reserve_datetime, format='%Y-%m-%d')
as.Date(reserve_tb$checkin_date, format='%Y-%m-%d')
