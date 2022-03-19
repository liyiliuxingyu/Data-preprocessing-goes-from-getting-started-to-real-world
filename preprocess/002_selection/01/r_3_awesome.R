library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 利用dplyr包，使用%>%将reserve_tb传递给下一行的函数
reserve_tb %>%

  # 在select函数的参数中设置要提取的列的列名，提取相应的列
  select(reserve_id, hotel_id, customer_id, reserve_datetime,
         checkin_date, checkin_time, checkout_date) %>%

  # 将提取的数据转换为R中的data.frame（后面的例题中会省略这一步操作）
  as.data.frame()

