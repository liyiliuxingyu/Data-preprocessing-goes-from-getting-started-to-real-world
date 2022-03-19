library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下 
# 为了在row_number函数中使用reserve_datetime，这里将其转换为POSIXct类型（详见第10章）
reserve_tb$reserve_datetime <-
  as.POSIXct(reserve_tb$reserve_datetime, format='%Y-%m-%d %H:%M:%S')

reserve_tb %>%
  group_by(customer_id) %>%
  arrange(reserve_datetime) %>%

  # 通过lag函数计算total_price列中当前记录上面的3 条记录的合计值
  # 组合运用if_else函数和rank函数，判断已经计算了多少条记录的合计值
  # 由于事先进行了排序，所以order_by=reserve_datetime并非必不可少
  # 当已计算合计值的记录数为0时，除数为0，因此price_avg会变成NAN
  mutate(price_avg=
           (  lag(total_price, 1, order_by=reserve_datetime, default=0)
            + lag(total_price, 2, order_by=reserve_datetime, default=0)
            + lag(total_price, 3, order_by=reserve_datetime, default=0))
           / if_else(row_number(reserve_datetime) > 3,
                     3, row_number(reserve_datetime) - 1))
