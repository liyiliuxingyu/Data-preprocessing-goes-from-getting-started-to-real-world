library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 从reserve_tb中获取顾客ID向量，并对顾客ID向量去重
all_id <- unique(reserve_tb$customer_id)

reserve_tb %>%

  # 使用sample函数从唯一的顾客ID中抽样50%，返回采样到的ID
  # 使用filter函数仅提取与采样到的ID对应的行
  filter(customer_id %in% sample(all_id, size=length(all_id) * 0.5))
