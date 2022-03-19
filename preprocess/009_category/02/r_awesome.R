library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下

# 导入dummyVars函数所在的库
library(caret)

# 在参数中指定要转换为哑变量的变量
# 当fullRank设置为FALSE时，所有的分类值都会被标志化
dummy_model <- dummyVars(~sex, data=customer_tb, fullRank=FALSE)

# 用predict函数生成哑变量
dummy_vars <- predict(dummy_model, customer_tb)
