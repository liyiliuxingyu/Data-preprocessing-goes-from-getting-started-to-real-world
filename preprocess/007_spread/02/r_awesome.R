library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 导入sparseMatrix函数所在的包 
library(Matrix)

cnt_tb <-
  reserve_tb %>%
    group_by(customer_id, people_num) %>%
    summarise(rsv_cnt=n())

# 将sparseMatrix的行和列所对应的值转换为分类型（factor）
# 关于分类型数据，详见第9章 
cnt_tb$customer_id <- as.factor(cnt_tb$customer_id)
cnt_tb$people_num <- as.factor(cnt_tb$people_num)

# 生成稀疏矩阵
# 在第1个到第3个参数中指定横向显示的数据 
# 第1个参数：行号；第2个参数：列号；第3个参数：设置指定的矩阵所对应的值的向量
# 在dims中指定稀疏矩阵的维度（设置为行数和列数的向量）
# （as.numeric(cnt_tb$customer_id)用于返回索引号）
# （length(levels(cnt_tb$customer_id))用于对customer_id进行唯一值计数）
sparseMatrix(as.numeric(cnt_tb$customer_id), as.numeric(cnt_tb$people_num),
             x=cnt_tb$rsv_cnt,
             dims=c(length(levels(cnt_tb$customer_id)),
                    length(levels(cnt_tb$people_num))))
