-- average suicide rates across countries with different GDP

set search_path to project343;


select e.year,
       case
           when e.GDPcapita < 10000 then 'low'
           when e.GDPcapita >= 10000 and e.GDPcapita <= 30000 then 'medium'
           when e.GDPcapita > 30000 then 'high'
           else 'unknown' end as income,
       avg(sRate)             as avgrates

from SuicideRates rates,
     Economy e
where rates.cID = e.cID
  and rates.year = e.year
group by e.year, income
order by income, e.year;
