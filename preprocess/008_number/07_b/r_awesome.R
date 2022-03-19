library(tidyverse)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 本书刊登内容如下
production_missn_tb %>%

  # 通过replace_na函数，在thickness为NULL、NA或NaN时用1填充
  replace_na(list(thickness = 1))
