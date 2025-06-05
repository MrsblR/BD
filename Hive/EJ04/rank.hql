SET hive.auto.convert.join = false;

DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
  name STRING,
  url STRING,
  `time` STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

LOAD DATA LOCAL INPATH '/home/hivehadoop/visits.log'
OVERWRITE INTO TABLE visits;

DROP TABLE IF EXISTS pages;
CREATE TABLE pages (
  url STRING,
  pagerank DECIMAL(3,2)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

LOAD DATA LOCAL INPATH '/home/hivehadoop/pages.log'
OVERWRITE INTO TABLE pages;

DROP TABLE IF EXISTS rank_result;
CREATE TABLE rank_result AS
SELECT pr.name
FROM (
  SELECT v.name, AVG(p.pagerank) AS prank
  FROM visits v
  JOIN pages p ON (v.url = p.url)
  GROUP BY v.name
) pr
WHERE pr.prank > 0.5;
