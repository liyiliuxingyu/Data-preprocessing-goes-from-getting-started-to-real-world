library(dplyr)
source('preprocess/load_data/data_loader.R')
load_production()

# 本书刊登内容如下
# 通过prcomp函数实现主成分分析（采用奇异值分解算法）
# 当scale设置为FALSE时，不进行归一化，直接进行主成分分析
pca <- prcomp(production_tb %>% select(length, thickness), scale=FALSE)

# 通过summary函数确认每个维度的下列值 
# Proportion of Variance：贡献率
# Cumulative Proportion：累计贡献率
summary(pca)

# 将主成分分析的应用结果存储在x中
pca_values <- pca$x

# 使用predict函数实现同样的降纬处理
pca_newvalues <-
  predict(pca, newdata=production_tb %>% select(length, thickness))
