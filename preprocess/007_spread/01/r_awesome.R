library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 将people_num更改为分类型（factor），以便在更改为横向显示时获取列名 
# 关于分类型数据，详见第9章
reserve_tb$people_num <- as.factor(reserve_tb$people_num)

reserve_tb %>%
  group_by(customer_id, people_num) %>%
  summarise(rsv_cnt=n()) %>%

  # 用spread函数将数据更改为横向显示
  # 用fill 设置当相应值为空时的填充值
  spread(people_num, rsv_cnt, fill=0)
