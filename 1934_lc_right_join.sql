select s.user_id, round(sum(if(c.action = 'confirmed', 1, 0)) / count(*), 2) as confirmation_rate from confirmations c
right join 
signups s
on s.user_id = c.user_id
group by s.user_id;
