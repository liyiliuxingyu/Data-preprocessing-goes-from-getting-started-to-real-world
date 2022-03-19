library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production_missing_category()

# 本书刊登内容如下
# 导入knn函数所在的库
library(class)

# 将type转换为factor类型
production_missc_tb$type <- factor(production_missc_tb$type)

# 提取无缺失值的数据
train <- production_missc_tb %>% filter(type != '')

# 提取包含缺失值的数据
test <- production_missc_tb %>% filter(type == '')

# 通过knn填充type值
# k是knn算法的参数，将prob设置为FALSE，将输出作为填充值
test$type <- knn(train=train %>% select(length, thickness),
                 test=test %>% select(length, thickness),
                 cl=factor(train$type), k=3, prob=FALSE)
