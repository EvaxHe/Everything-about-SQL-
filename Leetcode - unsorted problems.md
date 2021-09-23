## [1193.Monthly Transaction](https://leetcode.com/problems/monthly-transactions-i/)
- CASE WHEN & DATE MANIPULATION (extract month and year) 
> DATE_FORMAT(col, '%Y %m')

```Mysql
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country,
COUNT(*) AS trans_count,
SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END ) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions 
GROUP BY  country, DATE_FORMAT(trans_date, '%Y-%m')
```
## [1107.New Users Daily Count](https://leetcode.com/problems/new-users-daily-count/submissions/)
- Window Function 

```Mysql
WITH temp AS( 
    SELECT *, RANK()OVER (PARTITION BY user_id ORDER BY activity_date) AS rnk
    FROM Traffic
    WHERE activity = 'login'
)

SELECT activity_date AS login_date, COUNT(DISTINCT user_id) AS user_count
FROM temp
WHERE rnk = 1 AND activity_date >= '2019-06-30' - INTERVAL 90 Day
GROUP BY activity_date
ORDER BY activity_date
--- OR use ROW_NUMBER ()OVER instead of DISTINCT to aviod overcount the users who login multiple times in a day
```
## [1699. Number of Calls Between Two Persons](https://leetcode.com/problems/number-of-calls-between-two-persons/)
- UNION ALL
```Mysql
SELECT from_id AS person1, to_id AS person2, COUNT(*)AS call_count, SUM(duration)AS Total_duration
FROM 
(
SELECT from_id, to_id, duration 
FROM Calls
WHERE from_id < to_id 
UNION ALL
SELECT to_id AS from_id,from_id AS to_id, duration
FROM Calls 
WHERE from_id > to_id 

) temp

GROUP BY 1,2 
```
## [1211. Queries Quality and Percentage] (https://leetcode.com/problems/queries-quality-and-percentage/)
- CASE WHEN (COUNT -> ELSE NULL; SUM -> ELSE 0)
```Mysql
SELECT query_name, ROUND(AVG(rating/position) ,2)AS quality, 
ROUND( (COUNT(CASE WHEN rating < 3 THEN rating ELSE NULL END) *100 / COUNT(rating)), 2) AS poor_query_percentage 
FROM Queries 
GROUP BY query_name 
```
