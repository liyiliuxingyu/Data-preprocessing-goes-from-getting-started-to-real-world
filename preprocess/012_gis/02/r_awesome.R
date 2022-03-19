library(dplyr)
source('preprocess/load_data/data_loader.R')
load_hotel_reserve()

# 导入处理Spatial对象的sp包
library(sp)

# 获取customer_tb表中家庭的经纬度信息
home_locations <- customer_tb %>% select(home_longitude, home_latitude)

# 定义将分秒转换为度的函数
convert_to_continuous <- function(x){
  x_min <- (x * 100 - as.integer(x * 100)) * 100
  x_sec <- (x - as.integer(x) - x_min / 10000) * 100
  return(as.integer(x) + x_sec / 60 + x_min / 60 / 60)
}

# 将分秒转换为度
home_locations['home_longitude'] <-
  sapply(home_locations['home_longitude'], convert_to_continuous)
home_locations['home_latitude'] <-
  sapply(home_locations['home_latitude'], convert_to_continuous)

# 转换为Spatial对象（经纬度集合的数据类型）
coordinates(home_locations) <- c('home_longitude', 'home_latitude')

# 设置日本坐标系
# 由于版面关系，将语句分割并用paste0函数拼接
proj4string(home_locations) <-CRS(
  paste0('+proj=longlat +ellps=bessel ',
         '+towgs84=-146.336,506.832,680.254,0,0,0,0 +no_defs')
)

# 转换为世界坐标系（WGS84）
# 在spTransform函数内部使用rgdal包
home_locations <-
  spTransform(home_locations,
              CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'))

# 转换为data.frame
home_locations <- data.frame(home_locations)

# 将customer_tb的经纬度信息更新为世界坐标系
customer_tb$home_longitude <- home_locations$home_longitude
customer_tb$home_latitude <- home_locations$home_latitude


# 本书刊登内容如下
library(geosphere)

# 这里省略了部分代码（到将经纬度修正为日本坐标系为止的部分）

# 将顾客主表和酒店主表连接到预定记录表
reserve_all_tb <- inner_join(reserve_tb, hotel_tb, by='hotel_id')
reserve_all_tb <- inner_join(reserve_all_tb, customer_tb, by='customer_id')

# 计算方位角
bearing(reserve_all_tb[, c('home_longitude', 'home_latitude')],
        reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# 使用Haversine公式计算距离
distHaversine(reserve_all_tb[, c('home_longitude', 'home_latitude')],
              reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# 使用Vincenty公式计算距离
distVincentySphere(reserve_all_tb[, c('home_longitude', 'home_latitude')],
                   reserve_all_tb[, c('hotel_longitude', 'hotel_latitude')])

# 定义Hubeny公式的函数
distHubeny <- function(x){
  a=6378137
  b=6356752.314245
  e2 <- (a ** 2 - b ** 2) / a ** 2
  points <- sapply(x, function(x){return(x * (2 * pi) / 360)})
  lon1 <- points[[1]]
  lat1 <- points[[2]]
  lon2 <- points[[3]]
  lat2 <- points[[4]]
  w = 1 - e2 * sin((lat1 + lat2) / 2) ** 2
  c2 = cos((lat1 + lat2) / 2) ** 2
  return(sqrt((b ** 2 / w ** 3) * (lat1 - lat2) ** 2
              + (a ** 2 / w) * c2 * (lon1 - lon2) ** 2))
}

# 使用Hubeny公式计算距离
apply(
  reserve_all_tb[, c('home_longitude', 'home_latitude',
                     'hotel_longitude', 'hotel_latitude')],
  distHubeny, MARGIN=1
)

