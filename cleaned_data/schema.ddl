drop schema if exists project343 cascade;
create schema project343;
set search_path to project343;


create domain contName as varchar(20)
    not null
    check (value in ('Africa', 'South America',
                     'Europe', 'North America',
                     'Asia', 'Antarctica', 'Oceania'));

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


create table Continent
(
    contID   contID primary key,
    contName contName
);

create table Government
(
    govID   genericPositiveInt primary key,
    govType varchar(50) not null
);

create table Country
(
    cID      genericPositiveInt primary key,
    cName    varchar(50) not null,
    conID    genericPositiveInt,
    govID    genericPositiveInt,
    landArea genericPositiveReal,
    foreign key (conID) references Continent,
    foreign key (govID) references Government
);

create table Economy
(
    cID        genericPositiveInt,
    year       genericPositiveInt,
    GDP        genericPositiveInt,
    population genericPositiveInt,
    GDPcapita  genericPositiveReal,
    gini       ind100,
    lifespan   genericPositiveReal,
    demoIndex  ind100,
    primary key (cID, year),
    foreign key (cID) references Country
);

create table AgeGrp
(
    ageID    genericPositiveInt primary key,
    ageGroup varchar(20) not null
);

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
