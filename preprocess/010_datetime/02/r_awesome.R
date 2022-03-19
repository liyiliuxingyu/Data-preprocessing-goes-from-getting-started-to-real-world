library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
library(lubridate)

# 将reserve_datetime转换为POSIXct类型
reserve_tb$reserve_datetime_ct <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# 将reserve_datetime转换为POSIXlt类型
reserve_tb$reserve_datetime_lt <-
  as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

# 如果是POSIXct类型与Date类型，则使用函数获取特定的日期时间元素
# （在内部进行用于获取日期时间元素的计算）
# 如果是POSIXlt 类型，则可以直接获取特定的日期时间元素

# 获取年份
year(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$year

# 获取月份
month(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$mon

# 获取日期
days_in_month(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$mday

# 以数值形式获取星期（0=星期日，1＝星期一）
wday(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$wday

# 以字符串形式获取星期
weekdays(reserve_tb$reserve_datetime_ct)

# 获取时间中的时
hour(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$hour

# 获取时间中的分
minute(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$min

# 获取时间中的秒
second(reserve_tb$reserve_datetime_ct)
reserve_tb$reserve_datetime_lt$sec

# 转换为指定格式的字符串
format(reserve_tb$reserve_datetime_ct, '%Y-%m-%d %H:%M:%S')
