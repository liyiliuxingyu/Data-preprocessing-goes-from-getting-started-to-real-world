library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
library(tidyverse)

# 生成要计算的目标年月的data.frame
month_mst <- data.frame(year_month=
  # 生成2017-01-01、2017-02-01和2017-03-01，然后用format函数将格式转换为年月
  # （关于日期时间型，详见第10章）
  format(seq(as.Date('2017-01-01'), as.Date('2017-03-01'), by='months'),
         format='%Y%m')
)

# 将顾客ID和要计算的全部年月对象连接后生成的表
customer_mst <-

  # 对全部顾客ID和年月主表执行交叉连接
  merge(customer_tb %>% select(customer_id), month_mst) %>%

  # 由于merge指定的连接键的数据类型已经被转换为分类型，所以这里要将其转换回字符串类型
  # （关于分类型数据，详见第9章）
  mutate(customer_id=as.character(customer_id),
         year_month=as.character(year_month))

# 按月计算住宿费总额
left_join(
  customer_mst,

  # 在预订记录表中准备年月的连接键
  reserve_tb %>%
    mutate(checkin_month = format(as.Date(checkin_date), format='%Y%m')),

  # 按相同的customer_id和年月执行连接
  by=c('customer_id'='customer_id', 'year_month'='checkin_month')
) %>%

  # 按customer_id和年月执行聚合
  group_by(customer_id, year_month) %>%

  # 计算住宿费总额 
  summarise(price_sum=sum(total_price)) %>%

  # 将不存在预订记录时的住宿费总额由空值转换为0 
  replace_na(list(price_sum=0))
