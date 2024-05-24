        # Write your MySQL query statement below
        with recursive t1 as(
            select num, 1 as occurrence, frequency from numbers
            union all
            select num, occurrence + 1, frequency from t1
            where occurrence < frequency
        ),

        t2 as (
            select num, row_number() over (order by num) as r from t1
        )
        select avg(num) as median from t2
        where r >= (select sum(frequency) from numbers)/2 and r <= ((select sum(frequency) from numbers))/2 + 1
        -- select sum(frequency)/2 from numbers
        -- union all
        --  select sum(frequency)/2 + 1 from numbers