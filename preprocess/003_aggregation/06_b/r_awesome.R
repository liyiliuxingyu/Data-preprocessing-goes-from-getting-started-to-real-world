library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
reserve_tb %>%

  # 为了按酒店计算预订次数，这里将hotel_id指定为聚合单元
  group_by(hotel_id) %>%
  
  # 计算数据条数，并按酒店计算预订次数
  summarise(rsv_cnt=n()) %>%

  # 基于预订次数计算位次，通过desc函数将排列方式更改为降序排列
  # 通过transmute函数生成rsv_cnt_rank列
  # 仅提取所需的hotel_id和rsv_cnt_rank列
  transmute(hotel_id, rsv_cnt_rank=min_rank(desc(rsv_cnt)))
