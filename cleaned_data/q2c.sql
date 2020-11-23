-- average suicide rates across countries with different life expectancy

set search_path to project343;


select e.year,
       case
           when e.lifespan < 60 then 'low'
           when e.lifespan >= 60 and e.lifespan < 80 then 'medium'
           when e.lifespan >= 80 then 'high'
           else 'unknown' end as life_expectancy,
       avg(sRate)             as avgrates
from SuicideRates rates,
     Economy e
where rates.cID = e.cID
  and rates.year = e.year
group by e.year, life_expectancy
order by life_expectancy, e.year;
