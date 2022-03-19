library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 添加布尔型的列，当sex值为man时，该列元素值为TRUE
# 即使本段代码中不用as.logical函数，sex也会被转换为布尔型
customer_tb$sex_is_man <- as.logical(customer_tb$sex == 'man')

# 将sex转换为分类型
customer_tb$sex_c <- factor(customer_tb$sex, levels=c('man', 'woman'))

# 通过转换为数值，即可获取索引数据的数值
as.numeric(customer_tb$sex_c)

# 使用levels函数即可访问主数据 
levels(customer_tb$sex_c)
