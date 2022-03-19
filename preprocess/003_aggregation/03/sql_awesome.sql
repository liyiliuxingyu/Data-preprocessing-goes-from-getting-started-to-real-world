SELECT
  hotel_id,

  -- 计算total_price的最大值
  MAX(total_price) AS price_max,

  -- 计算total_price的最小值
  MIN(total_price) AS price_min,

  -- 计算total_price的平均值
  AVG(total_price) AS price_avg,

  -- 计算total_price的中位数
  MEDIAN(total_price) AS price_med,
  
  -- 为PERCENTILE_CONT函数指定0.2，计算第20百分位数
  -- 为ORDEY BY语句指定total_price，指定要计算百分位数的目标列和数据的排序方法
  PERCENTILE_CONT(0.2) WITHIN GROUP(ORDER BY total_price) AS price_20per

FROM work.reserve_tb
GROUP BY hotel_id
