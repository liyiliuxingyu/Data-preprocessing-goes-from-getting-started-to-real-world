library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 导入roll_sum函数对应的库
library(RcppRoll)

reserve_tb %>%

  # 按customer_id对数据行分组
  group_by(customer_id) %>%

  # 对每个customer_id的数据按reserve_datetime进行排序
  arrange(reserve_datetime) %>%

  # 通过RcppRoll库的roll_sum函数滚动计算合计值
  mutate(price_sum=roll_sum(total_price, n=3, align='right', fill=NA))
