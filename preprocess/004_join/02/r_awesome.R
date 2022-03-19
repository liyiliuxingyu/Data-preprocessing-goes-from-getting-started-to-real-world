library(dplyr)
# 执行后续语句前，必须先使用setwd()设置当前工作目录
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下 
# 该表用于按small_area_name对酒店数进行统计并生成连接键
small_area_mst <-
  hotel_tb %>%
    group_by(big_area_name, small_area_name) %>%

    # -1表示推荐酒店中应去除该酒店自身（因为推荐时肯定不能推荐该酒店自身）
    summarise(hotel_cnt=n() - 1) %>%

    # 当聚合处理结束后，解除group
    ungroup() %>%
    # 当酒店数大于或等于20时，将small_area_name作为join_area_id
    # 当酒店数不足20时，将big_area_name作为join_area_id
    mutate(join_area_id=
             if_else(hotel_cnt >= 20, small_area_name, big_area_name)) %>%
    select(small_area_name, join_area_id)

# 通过将推荐源的酒店表与small_area_mst连接，设置join_area_id
base_hotel_mst <-
  inner_join(hotel_tb, small_area_mst, by='small_area_name') %>%
    select(hotel_id, join_area_id)

# 根据需要释放内存(不是必需操作，可在内存不足时进行)
rm(small_area_mst)

# 推荐候选表
recommend_hotel_mst <-
  bind_rows(
    # 将big_area_name作为join_area_id而得到的推荐候选的主数据 
    hotel_tb %>%
      rename(rec_hotel_id=hotel_id, join_area_id=big_area_name) %>%
      select(join_area_id, rec_hotel_id),

    # 将small_area_name作为join_area_id而得到的推荐候选的主数据
    hotel_tb %>%
      rename(rec_hotel_id=hotel_id, join_area_id=small_area_name) %>%
      select(join_area_id, rec_hotel_id)
  )

# 将base_hotel_mst和recommend_hotel_mst连接，并加入推荐候选的信息
inner_join(base_hotel_mst, recommend_hotel_mst, by='join_area_id') %>%

  # 从推荐候选酒店中去除该酒店自身
  filter(hotel_id != rec_hotel_id) %>%
  select(hotel_id, rec_hotel_id)
