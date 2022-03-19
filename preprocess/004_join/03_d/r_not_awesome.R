library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
library(tidyr)

# 为了在row_number函数中使用reserve_datetime，这里将其转换为POSIXct类型（详见第10章）
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

# 计算过去90天内的住宿费合计值的表
sum_table <-

  # 在不确认reserve_datetime中的日期的情况下，将customer_id相同的数据行全部连接
  inner_join(
    reserve_tb %>%
      select(reserve_id, customer_id, reserve_datetime),
    reserve_tb %>%
      select(customer_id, reserve_datetime, total_price) %>%
      rename(reserve_datetime_before=reserve_datetime),
    by='customer_id') %>%

  # 比较checkin列的日期，仅提取连接了90天内的数据的数据行 
  # 60*60*24*90表示60秒*60分*24时*90天，计算90天的秒数 
  # (关于日期时间型，详见第10章)
  filter(reserve_datetime > reserve_datetime_before &
           reserve_datetime - 60 * 60 * 24 * 90 <= reserve_datetime_before) %>%
  select(reserve_id, total_price) %>%

  # 按reserve_id计算total_price的合计值
  group_by(reserve_id) %>%
  summarise(total_price_90d=sum(total_price)) %>%
  select(reserve_id, total_price_90d)

# 连接计算出的合计值，将合计值信息加入源表中
# 使用replace_na将不存在合计值的记录的值设置为0
left_join(reserve_tb, sum_table, by='reserve_id') %>%
  replace_na(list(total_price_90d=0))
