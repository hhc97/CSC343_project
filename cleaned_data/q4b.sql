-- average suicide rates across different continents

set search_path to project343;


select year,
       avg(sRate) avgrates
from SuicideRates rates
group by year
order by year;
