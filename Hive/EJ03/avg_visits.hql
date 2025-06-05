DROP TABLE IF EXISTS pages;
DROP TABLE IF EXISTS avg_visit;

CREATE TABLE pages (name STRING, url STRING, `time` STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ' ';

LOAD DATA LOCAL INPATH '/home/hivehadoop/visits.log'
OVERWRITE INTO TABLE pages;

CREATE TABLE avg_visit AS
SELECT name, count(*) AS num_pages
FROM pages
GROUP BY name;

SELECT * FROM avg_visit;
