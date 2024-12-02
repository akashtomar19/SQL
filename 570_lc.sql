select e.name from employee e
join employee m
on e.id = m.managerId
group by 
e.id
having count(*) > 4

-- initially submitted above but this only work in MySQL
-- and may return indeterminant results

select e.name from employee e
join employee m
on e.id = m.managerId
group by 
e.id, e.name
having count(*) > 4
