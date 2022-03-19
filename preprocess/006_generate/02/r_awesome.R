source('preprocess/load_data/data_loader.R')
load_production()

# 本书刊登内容如下
# 导入ubBalance函数所在的库
library(unbalanced)
library(tidyverse)
# 计算percOver的设置值
t_num <- production_tb %>% filter(fault_flg==True)%>% summarize(t_num=n())
f_num <- production_tb %>% filter(fault_flg==False)%>% summarize(f_num=n())
percOver <- round(f_num / t_num) * 100 - 100

# 将纠正不平衡状态的对象转换为factor类型（注意不是logical类型）
# （详见第9章） 
production_tb$fault_flg <- as.factor(production_tb$fault_flg)

# 用ubBalance函数实现过采样
# 将type设置为ubSMOTE# 
# positive指定的是分类中少数类的类别值（不指定也是可以的，但会显示警告）
# 把percOver参数设置为基于源数据增加百分之多少
# （当percOver值为200时增加为原来的3（200/100 + 1）倍，当值为500时增加为原来的6（500/100 + 1）倍，不足100的值舍去）
# 在进行欠采样时，必须向percUnder传入参数，若不进行欠采样，则设置参数为0
# k是smote的k参数
production_balance <-
  ubBalance(production_tb[,c('length', 'thickness')],
            production_tb$fault_flg,
            type='ubSMOTE', positive='True',
            percOver=percOver, percUnder=0, k=5)

# 将生成的fault_flg为True的数据与源数据中fault_flg为False的数据合并
bind_rows(

  # 在production_balance$X中存储生成的length和thickness的data.frame
  production_balance$X %>%

    # 在production_balance$Y中存储生成的fault_flg的向量
    mutate(fault_flg=production_balance$Y),

  # 获取源数据中fault_flg为False的数据
  production_tb %>%

    # 由于production_tb是factor类型，所以可通过匹配判断来获取
    filter(fault_flg == 'False') %>%
    select(length, thickness, fault_flg)
)
