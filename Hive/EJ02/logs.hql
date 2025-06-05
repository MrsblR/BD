DROP TABLE IF EXISTS logs;
DROP TABLE IF EXISTS result;

CREATE TABLE logs (
  user_a STRING,
  visit_time STRING,
  query STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH '/home/hivehadoop/excite-small.log'
OVERWRITE INTO TABLE logs;

CREATE TABLE result AS
SELECT user_a, COUNT(1) AS log_entries
FROM logs
GROUP BY user_a
ORDER BY user_a;

SELECT * FROM result;
