library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 通过round函数将total_price列以1000为单位四舍五入
# 通过table函数按计算出的金额计算预订记录数
# （向量的属性信息names是计算出的金额，向量值是预订记录数）
# 通过which.max函数获取预订记录数最大的向量元素
# 通过names函数获取预订记录数最大的向量元素的属性信息（names）
names(which.max(table(round(reserve_tb$total_price, -3))))
