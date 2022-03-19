library(dplyr)
# 本书此处省略

# 本书刊登内容如下
library(tidyr)
library(RPostgreSQL)

# 用SQL获取分析对象数据
con <- dbConnect(dbDriver('PostgreSQL'),
                 host='IP地址或主机名',
                 port='连接的端口号',
                 dbname='数据库名',
                 user='连接的用户名',
                 password='连接的密码')
sql <- paste(readLines('01_select_base_log.sql'), collapse='\n')
base_log <- dbGetQuery(con,sql)

# 生成年龄的分类
base_log$age_rank <- as.factor(floor(base_log$age/10)*10)
levels(base_log$age_rank) <- c(levels(base_log$age_rank),'60岁以上')
base_log[base_log$age_rank %in% c('60', '70', '80'), 'age_rank'] <- '60岁以上'
base_log$age_rank <- droplevels(base_log$age_rank)

# 按年龄和性别把握趋势
age_sex_summary <- 
  base_log %>%
    group_by(age_rank, sex) %>%
    summarise(customer_cnt=n_distinct(customer_id),
              rsv_cnt=n(),
              people_num_avg=mean(people_num),
              price_per_person_avg=mean(total_price/people_num)
    )

# 按每个指标将性别横向展开
age_sex_summary %>%
  select(age_rank, sex, customer_cnt) %>% 
  spread(age_rank, customer_cnt)

age_sex_summary %>%
  select(age_rank, sex, rsv_cnt) %>% 
  spread(age_rank, rsv_cnt)

age_sex_summary %>%
  select(age_rank, sex, people_num_avg) %>% 
  spread(age_rank, people_num_avg)

age_sex_summary %>%
  select(age_rank, sex, price_per_person_avg) %>% 
  spread(age_rank, price_per_person_avg)