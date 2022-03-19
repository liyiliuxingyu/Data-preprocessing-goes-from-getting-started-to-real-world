library(mice)
source('preprocess/load_data/data_loader.R')
load_production_missing_num()

# 本书刊登内容如下
library(mice)

# 为了使用mice函数而进行数据类型转换（因为要在mice函数内部构建模型）
production_missn_tb$type <- as.factor(production_missn_tb$type)

# 由于fault_flg是字符串类型，所以转换为布尔型（详见第9章）
production_missn_tb$fault_flg <- production_missn_tb$fault_flg == 'TRUE'

# 在mice函数中指定pmm，实现多重插补
# m是获取的数据集的数量
# maxit是获取填充值之前的循环次数
production_mice <-
  mice(production_missn_tb, m=10, maxit=50, method='pmm', seed=71)

# 以如下形式存储填充值
production_mice$imp$thickness
