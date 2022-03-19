library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 本书刊登内容如下
# 通过drop_na函数删除thickness为NULL、NA或NaN的记录
production_missn_tb %>% drop_na(thickness)

# 无论是哪个列，只要包含NULL、NA或NaN，即删除整条记录
# na.omit(production_missn_tb)
