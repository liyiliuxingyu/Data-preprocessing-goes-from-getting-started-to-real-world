library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 将reserve_datetime转换为POSIXlt类型
reserve_tb$reserve_datetime_lt <-
  as.POSIXlt(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

# 用于将月份转换为对应季节的函数
to_season <-function(month_num){
  case_when(
    month_num >= 3 & month_num < 6  ~ 'spring',
    month_num >= 6 & month_num < 9  ~ 'summer',
    month_num >= 9 & month_num < 12 ~ 'autumn',
    TRUE                            ~ 'winter'
  )
}

# 转换为季节
reserve_tb$reserve_datetime_season <-
  sapply(reserve_tb$reserve_datetime_lt$mon, to_season)

# 转换为分类型
reserve_tb$reserve_datetime_season <-
  factor(reserve_tb$reserve_datetime_season,
         levels=c('spring', 'summer', 'autumn', 'winter'))
