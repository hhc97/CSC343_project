-- average suicide rates for both genders

set search_path to project343;

select sex,
       avg(sRate)
from SuicideRates
group by sex;
