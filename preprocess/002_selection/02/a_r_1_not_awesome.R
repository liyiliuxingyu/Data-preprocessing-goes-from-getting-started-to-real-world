library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 通过checkin_date条件表达式，返回判定结果为TRUE或FALSE的向量
# 通过“&”将条件表达式相连，返回元素为TRUE或FALSE的向量，其元素仅当判断结果同时为TRUE时才为TRUE
# 将reserve_tb二维数组的第一维度指定为TRUE或FALSE的向量，提取满足条件的行
# 将reserve_tb二维数组的第二维度设置为空，提取全部的列
reserve_tb[reserve_tb$checkin_date >= '2016-10-12' &
           reserve_tb$checkin_date <= '2016-10-13', ]
