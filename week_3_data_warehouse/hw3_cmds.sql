-- HW setup
CREATE OR REPLACE EXTERNAL TABLE `aerial-garden-376120.de_course_us.ny_taxi_data`
OPTIONS (
  format = 'CSV',
  uris = ['gs://dezoomcamp-data/hw3/fhv_tripdata_2019-*.csv.gz']
);

CREATE OR REPLACE TABLE `aerial-garden-376120.de_course_us.bq_ny_taxi_data`
AS SELECT * FROM `aerial-garden-376120.de_course_us.ny_taxi_data`;

-- Q1 answer
SELECT count(*) FROM `aerial-garden-376120.de_course_us.ny_taxi_data`;

-- Q2 answer
SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `aerial-garden-376120.de_course_us.ny_taxi_data`;

SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `aerial-garden-376120.de_course_us.bq_ny_taxi_data`;

-- Q3 answer 
SELECT count(*) FROM  `aerial-garden-376120.de_course_us.bq_ny_taxi_data`
WHERE PUlocationID IS null and DOlocationID IS null;

-- Q5 answer
CREATE OR REPLACE TABLE `aerial-garden-376120.de_course_us.partitioned_ny_taxi_data`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY Affiliated_base_number AS (
  SELECT * FROM `aerial-garden-376120.de_course_us.ny_taxi_data`
);

SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `aerial-garden-376120.de_course_us.bq_ny_taxi_data`
WHERE pickup_datetime BETWEEN '2019-03-01' AND '2019-03-31'

SELECT COUNT(DISTINCT(Affiliated_base_number)) FROM `aerial-garden-376120.de_course_us.partitioned_ny_taxi_data`
WHERE pickup_datetime BETWEEN '2019-03-01' AND '2019-03-31'