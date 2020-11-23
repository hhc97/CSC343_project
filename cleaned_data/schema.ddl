drop schema if exists project343 cascade;
create schema project343;
set search_path to project343;


-- continent names
create domain contName as varchar(15)
    not null
    check (value in ('Africa', 'South America',
                     'Europe', 'North America',
                     'Asia', 'Antarctica', 'Oceania'));

-- some general domains for use in the schema
create domain genericPositiveInt as integer
    not null
    check ( value >= 0 );

create domain genericPositiveReal as real
    not null
    check ( value >= 0 );

create domain contID as smallint
    not null
    check (value >= 1 and value <= 7);

create domain ind100 as real
    not null
    check ( value >= 0 and value <= 100);


-- each continent and their associated ID
create table Continent
(
    contID   contID primary key,
    contName contName
);

-- every type of government and their associated ID
create table Government
(
    govID   genericPositiveInt primary key,
    govType varchar(50) not null
);

-- a table storing every country's name, associated ID,
-- its continent, and government type
create table Country
(
    cID   genericPositiveInt primary key,
    cName varchar(50) not null,
    conID genericPositiveInt,
    govID genericPositiveInt,
    foreign key (conID) references Continent,
    foreign key (govID) references Government
);

-- economy data for some country during some year
create table Economy
(
    cID       genericPositiveInt,
    year      genericPositiveInt,
    GDPcapita genericPositiveReal,
    gini      ind100,
    lifespan  genericPositiveReal,
    demoIndex ind100,
    primary key (cID, year),
    foreign key (cID) references Country
);

-- age groups represented in text mapped to their associated ID
create table AgeGrp
(
    ageID    genericPositiveInt primary key,
    ageGroup varchar(20) not null
);

-- data regarding suicide rates with the following fields:
-- 1. cID: the ID of the country that this entry is about
-- 2. year: the year in which this happened
-- 3. ageID: the age group of this particular statistic
-- 4. suicides: the raw number of suicides within this age group
-- 5. population: the population of the age group, not the country
-- 6. sRate: the number of suicides per 100,000 population in this age group
-- 7. sex: the gender that this statistic is concerning
create table SuicideRates
(
    cID        genericPositiveInt,
    year       genericPositiveInt,
    ageID      genericPositiveInt,
    suicides   genericPositiveInt,
    population genericPositiveInt,
    sRate      genericPositiveReal,
    sex        char(1) not null,
    primary key (cID, year, ageID, sex),
    foreign key (cID) references Country,
    foreign key (ageID) references AgeGrp
);
