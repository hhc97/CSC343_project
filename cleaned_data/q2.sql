-- suicide rates for both genders grouped by age group

set search_path to project343;

select sex,
       cats.ageGroup,
       avg(sRate) avgrate
from SuicideRates rates,
     AgeGrp cats
where rates.ageID = cats.ageID
group by sex, cats.ageGroup
order by sex, cats.ageGroup;
