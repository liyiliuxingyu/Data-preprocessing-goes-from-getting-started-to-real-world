library(dplyr)
source('preprocess/load_data/data_loader.R')
load_monthly_index()

# 本书刊登内容如下
# 导入createTimeSlices所在的库
library(caret)

# 设置随机数种子
set.seed(71)

# 基于年月进行数据排序
target_data <- monthly_index_tb %>% arrange(year_month) %>% as.data.frame()

# 通过createTimeSlices函数，获取拆分后的训练数据和验证数据的行号
# 把initialWindow设置为训练数据的条数
# 把horizon设置为验证数据的条数
# 把skip设置为“滑动次数-1”的值
# 把fixedWindow设置为TRUE，表示在不增加训练数据的条数的前提下进行滑动
timeSlice <-
  createTimeSlices(1:nrow(target_data), initialWindow=24, horizon=12,
                   skip=(12 - 1), fixedWindow=TRUE)

# 用for语句循环“拆分数据的份数”次
for(slice_no in 1:length(timeSlice$train)){

  # 指定行号，从源数据中获取训练数据
  train <- target_data[timeSlice$train[[slice_no]], ]

  # 指定行号，从源数据中获取验证数据
  test <- target_data[timeSlice$test[[slice_no]], ]

  # 将train作为训练数据，将test作为验证数据，构建并验证机器学习模型
}

# 汇总交叉验证的结果
