-- average suicide rates across different continents

set search_path to project343;


select contName   continent,
       avg(sRate) avgrates
from SuicideRates rates,
     Country cntry,
     Continent cont
where rates.cID = cntry.cID
  and cntry.conID = cont.contID
group by contName
order by avgrates;
