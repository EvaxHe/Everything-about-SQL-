## Sol_1 
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1,
    Logs l2,
    Logs l3
    
WHERE l1.id = l2.id - 1
AND l2.id = l3.id - 1
AND l1.num = l2.num
AND l2.num = l3.num 

## Sol_2

SELECT DISTINCT num AS ConsecutiveNums
FROM(
SELECT id,num, LAG(num)OVER() AS prev, LEAD(num)OVER() AS next
FROM Logs) foo 
WHERE num = prev AND num = next
