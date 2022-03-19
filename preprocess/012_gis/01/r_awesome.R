library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 本书刊登内容如下
# 导入用于处理Spatial对象的sp包
library(sp)

# 返回顾客主表中家的纬度和经度
home_locations <- customer_tb %>% select(home_longitude, home_latitude)

# 定义用于将分、秒转换为度的函数
convert_to_continuous <- function(x){
  x_min <- (x * 100 - as.integer(x * 100)) * 100
  x_sec <- (x - as.integer(x) - x_min / 10000) * 100
  return(as.integer(x) + x_sec / 60 + x_min / 60 / 60)
}

# 将分、秒转换为度
home_locations['home_longitude'] <-
  sapply(home_locations['home_longitude'], convert_to_continuous)
home_locations['home_latitude'] <-
  sapply(home_locations['home_latitude'], convert_to_continuous)

# 转换为Spatial对象（即经纬度集合形式的数据类型）
coordinates(home_locations) <- c('home_longitude', 'home_latitude')

# 设置日本坐标系
# 限于篇幅关系，将语句切分并用paste0函数进行拼接
proj4string(home_locations) <-CRS(
  paste0('+proj=longlat +ellps=bessel ',
         '+towgs84=-146.336,506.832,680.254,0,0,0,0 +no_defs')
)

# 转换为世界坐标系(WGS84)
# 在spTransform函数中使用rgdal包
home_locations <-
  spTransform(home_locations,
              CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))

# 转换为data.frame
home_locations <- data.frame(home_locations)

# 将customer_tb的经纬度更新为世界坐标系
customer_tb$home_longitude <- home_locations$home_longitude
customer_tb$home_latitude <- home_locations$home_latitude
