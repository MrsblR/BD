
DROP TABLE IF EXISTS word_count;

DROP TABLE IF EXISTS docs;

CREATE TABLE docs (line STRING);

LOAD DATA LOCAL INPATH '/home/hivehadoop/wordcount.txt' OVERWRITE INTO TABLE docs;

CREATE TABLE word_count AS
SELECT word, count(1) AS count
FROM (
  SELECT explode(split(line, ' ')) AS word
  FROM docs
) w
GROUP BY word
ORDER BY word;

SELECT * FROM word_count;
