---NETFLIX PROJECT---
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
			show_id VARCHAR(66),
			type VARCHAR (150),	
			title VARCHAR (208),
			director VARCHAR(208),
			casts VARCHAR(1000),	
			country	VARCHAR(150),
			date_added	VARCHAR(66),
			release_year INT,
			rating	VARCHAR(66),
			duration VARCHAR(66),	
			listed_in VARCHAR(100),	
			description VARCHAR(250)
);

SELECT * FROM netflix;

SELECT COUNT (*) FROM netflix;

SELECT DISTINCT TYPE FROM netflix;

---15 BUSINESS PROBLEMS

--1. Count the Number of Movies vs TV Shows
SELECT * FROM netflix;
SELECT type, 
COUNT(*) FROM netflix
GROUP BY type;

--2.Find the Most Common Rating for Movies and TV Shows
SELECT 	type, rating FROM
(SELECT
   type, 
   rating,
   COUNT (*),
   RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
   FROM netflix
   GROUP BY 1,2)
   WHERE ranking = 1

--3. List All Movies Released in a Specific Year (e.g., 2020)
SELECT * FROM netflix
WHERE
    type='Movie'
	AND
	release_year=2020

--4. Find the Top 5 Countries with the Most Content on Netflix
SELECT 
UNNEST(STRING_TO_ARRAY(country,',')),
   COUNT(show_id)
   FROM netflix
   GROUP BY 1;

--5. Identify the Longest Movie
SELECT * FROM netflix
WHERE
type='Movie'
AND
duration =(SELECT MAX(duration) FROM netflix)

--6. Find Content Added in the Last 5 Years
SELECT *
FROM netflix
WHERE
   TO_DATE(date_added,'Month DD,YYYY') >= CURRENT_DATE- INTERVAL '5 years'


--7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'
SELECT * FROM netflix
WHERE director LIKE '%Rajiv Chilaka%'

--List All TV Shows with More Than 5 Seasons
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;

--9. Count the Number of Content Items in Each Genre
SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
    COUNT(*) AS total_content
FROM netflix
GROUP BY 1;

--10.Find All Content Without a Director
SELECT * 
FROM netflix
WHERE director IS NULL;


