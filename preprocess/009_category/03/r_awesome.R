library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
customer_tb$age_rank <- factor(floor(customer_tb$age / 10) * 10)

# 在主数据中添加'60岁以上'
levels(customer_tb$age_rank) <- c(levels(customer_tb$age_rank), '60岁以上')


# 更改要聚合的数据
# 分类型仅能进行“==”或“!=”的判断
# 使用in函数实现替换
customer_tb[customer_tb$age_rank %in% c('60', '70', '80'), 'age_rank'] <-  '60岁以上'

# 删除未使用的主数据(60,70,80)
customer_tb$age_rank <- droplevels(customer_tb$age_rank)
