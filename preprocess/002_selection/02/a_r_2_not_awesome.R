library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 在which函数中指定条件表达式，返回判断结果为TRUE的行号向量
# 用intersect函数提取参数中的两个行号向量中同时出现的行号
# 将reserve_tb 二维数组的第一维度指定为行号向量，提取满足条件的行
reserve_tb[
  intersect(which(reserve_tb$checkin_date >= '2016-10-12'),
            which(reserve_tb$checkin_date <= '2016-10-13')), ]
