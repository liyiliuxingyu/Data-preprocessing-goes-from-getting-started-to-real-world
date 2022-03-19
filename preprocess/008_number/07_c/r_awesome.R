library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 本书刊登内容如下
# 去除缺失值，然后计算thickness的平均值
# 通过将na.rm设置为TRUE，可计算去除NA后的聚合值
thickness_mean <- mean(production_missn_tb$thickness, na.rm=TRUE)

# 通过replace_na函数，用去除缺失值后的thickness的平均值进行填充
production_missn_tb %>% replace_na(list(thickness = thickness_mean))
