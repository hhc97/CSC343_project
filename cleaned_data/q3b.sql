-- average suicide rates across countries with different democracy indexes

set search_path to project343;


select e.year,
       case
           when e.demoIndex < 40 then 'low'
           when e.demoIndex >= 40 and e.demoIndex < 70 then 'medium'
           when e.demoIndex >= 70 then 'high'
           else 'unknown' end as democracy_index,
       avg(sRate)             as avgrates
from SuicideRates rates,
     Economy e
where rates.cID = e.cID
  and rates.year = e.year
group by e.year, democracy_index
order by democracy_index, e.year;
