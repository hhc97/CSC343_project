-- average suicide rates across countries with different government types

set search_path to project343;


select g.govType,
       avg(sRate) avgrates
from SuicideRates rates,
     Country c,
     Government g
where rates.cID = c.cID
  and c.govID = g.govID
group by g.govType
order by avg(sRate);
