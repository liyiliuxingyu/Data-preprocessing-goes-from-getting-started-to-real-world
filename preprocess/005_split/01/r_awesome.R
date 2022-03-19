library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production()

# 本书刊登内容如下
# 导入sample.split所在的包
library(caTools)

# 导入cvFolds所在的包
library(cvTools)

# 设置随机数种子。据说71在某些地方被称为幸运数字
set.seed(71)

# 为进行留出验证而执行数据拆分
# production_tb$fault_flg只要是与数据行数等长的向量均可
# test_tf是与数据行数等长的元素为FAISE或TRUE的向量，当数据是训练数据时为FALSE，是验证数据时为TRUE 
# SplitRatio是验证数据的比例
test_tf <- sample.split(production_tb$fault_flg, SplitRatio=0.2)

# 从production_tb中提取留出验证用的训练数据
train <- production_tb %>% filter(!test_tf)

# 从production_tb中提取留出验证用的验证数据
private_test  <- production_tb %>% filter(test_tf)

# 为进行交叉验证而执行数据拆分
cv_no <- cvFolds(nrow(train), K=4)

# 执行cv_no$K（所设置的折数）次重复处理（可并行处理）
for(test_k in 1:cv_no$K){

  # 从production_tb中提取交叉验证用的训练数据
  train_cv <- train %>% slice(cv_no$subsets[cv_no$which!=test_k])

  # 从production_tb中提取交叉验证用的测试数据
  test_cv <- train %>% slice(cv_no$subsets[cv_no$which==test_k])

  # 将train_cv作为训练数据，将test_cv作为验证数据，构建和验证机器学习模型

}

# 汇总交叉验证的结果

# 将train作为训练数据，将private_test作为验证数据，构建和验证机器学习模型
