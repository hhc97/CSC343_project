-- average suicide rates across countries with different Gini index

set search_path to project343;


select e.year,
       case
           when e.gini < 35 then 'low'
           when e.gini >= 35 and e.gini < 50 then 'medium'
           when e.gini >= 50 then 'high'
           else 'unknown' end as gini_rating,
       avg(sRate)             as avgrates

from SuicideRates rates,
     Economy e
where rates.cID = e.cID
  and rates.year = e.year
group by e.year, gini_rating
order by gini_rating, e.year;
