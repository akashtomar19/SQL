SELECT * FROM t1
LEFT JOIN t2 ON t1.id = t2.id
UNION ALL
SELECT * FROM t1
RIGHT JOIN t2 ON t1.id = t2.id
WHERE t1.id IS NULL

-- It will return duplicates as well
-- https://stackoverflow.com/questions/4796872/how-can-i-do-a-full-outer-join-in-mysql


Using a union query will remove duplicates, and this is different than the behavior of full outer join that never removes any duplicates:

[Table: t1]        [Table: t2]
value              value
-----------        -------
1                  1
2                  2
4                  2
4                  5

Left Join result
t1_value	t2_value
  1	            1
  2	            2
  4	            NULL
  4	            NULL

Right join result with filter
t1_value	t2_value
NULL	     5

This is the expected result of a full outer join:

value | value
------+-------
1     | 1
2     | 2
2     | 2
Null  | 5
4     | Null
4     | Null
This is the result of using left and right join with union:

value | value
------+-------
Null  | 5
1     | 1
2     | 2
4     | Null
SQL Fiddle

My suggested query is:

select
    t1.value, t2.value
from t1
left outer join t2
  on t1.value = t2.value
union all      -- Using `union all` instead of `union`
select
    t1.value, t2.value
from t2
left outer join t1
  on t1.value = t2.value
where
    t1.value IS NULL