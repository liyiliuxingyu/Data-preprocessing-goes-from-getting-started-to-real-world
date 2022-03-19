library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 将二维数组reserve_tb的第一维度设置为空，提取所有的行
# 将reserve_tb的第二维度指定为数值向量，提取多个列
reserve_tb[, c(1, 2, 3, 4, 5, 6, 7)]
