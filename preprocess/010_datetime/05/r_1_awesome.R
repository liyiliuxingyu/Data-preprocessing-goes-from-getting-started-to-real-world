library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 将reserve_datetime转换为POSIXct类型
reserve_tb$reserve_datetime_ct <-
  as.POSIXct(reserve_tb$reserve_datetime, orders='%Y-%m-%d %H:%M:%S')

# 用于将月份转换为对应季节的函数（也可以直接在mutate函数内定义）
to_season <- function(month_num){
  case_when(
    month_num >= 3 & month_num < 6  ~ 'spring',
    month_num >= 6 & month_num < 9  ~ 'summer',
    month_num >= 9 & month_num < 12 ~ 'autumn',
    TRUE                            ~ 'winter'
  )
}

# 转换为季节
reserve_tb <-
  reserve_tb %>%
    mutate(reserve_datetime_season=to_season(month(reserve_datetime_ct)))

# 转换为分类型
reserve_tb$reserve_datetime_season <-
  factor(reserve_tb$reserve_datetime_season,
         levels=c('spring', 'summer', 'autumn', 'winter'))
