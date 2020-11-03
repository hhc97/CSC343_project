drop schema if exists project343 cascade;
create schema project343;
set search_path to project343;


create table Continent
(
    conID   integer primary key,
    conName varchar(50) not null
);

create table Government
(
    govID   integer primary key,
    govType varchar(50) not null
);

create table Country
(
    cID      integer primary key,
    cName    varchar(50) not null,
    conID    integer     not null,
    govID    integer     not null,
    landArea real        not null,
    foreign key (conID) references Continent,
    foreign key (govID) references Government
);

create table Economy
(
    cID        integer not null,
    year       integer not null,
    GDP        integer not null,
    population integer not null,
    GDPcapita  real    not null,
    gini       real    not null,
    lifespan   real    not null,
    demoIndex  real    not null,
    primary key (cID, year),
    foreign key (cID) references Country
);

create table Age
(
    ageID      integer primary key,
    ageGroup   varchar(20) not null,
    population integer     not null
);

create table SuicideRates
(
    cID        integer not null,
    year       integer not null,
    ageID      integer not null,
    suicides   integer not null,
    population integer not null,
    sRate      real    not null,
    primary key (cID, year, ageID),
    foreign key (cID) references Country,
    foreign key (ageID) references Age
);
