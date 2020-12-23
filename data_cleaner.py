"""
A script used to clean data for the CSC343 Databases project.
"""

import csv


def get_country_mapping():
    """
    Returns a dictionary mapping countries to their ID.
    """
    countries_dict = {}
    with open('data/country_mapping.csv', 'r', newline='') as f:
        reader = csv.reader(f)
        for cid, country in reader:
            countries_dict[country] = cid
    return countries_dict


def get_continent_mapping():
    """
    Returns a dictionary mapping continents to their ID.
    """
    continents_dict = {}
    with open('data/continent_mapping.csv', 'r', newline='') as f:
        reader = csv.reader(f)
        for cid, continent in reader:
            continents_dict[continent] = cid
    return continents_dict


def get_age_mapping():
    """
    Returns a dictionary mapping age groups to their ID.
    """
    ages_dict = {}
    with open('data/age_mapping.csv', 'r', newline='') as f:
        reader = csv.reader(f)
        for aid, age in reader:
            ages_dict[age] = aid
    return ages_dict


def clean_suicide_statistics() -> None:
    """
    Cleans the WHO suicide statistics.
    """
    ages = get_age_mapping()
    countries = get_country_mapping()
    alternatives = {'Iran (Islamic Rep of)': 'Iran',
                    'Brunei Darussalam': 'Brunei',
                    'Netherlands Antilles': 'Netherlands',
                    'Republic of Korea': 'South Korea',
                    'Republic of Moldova': 'Moldova',
                    'Russian Federation': 'Russia',
                    'Saint Vincent and Grenadines': 'Saint Vincent and the Grenadines',
                    'Syrian Arab Republic': 'Syria',
                    'TFYR Macedonia': 'North Macedonia',
                    'Venezuela (Bolivarian Republic of)': 'Venezuela'}
    with open('data/who_suicide_statistics.csv', 'r', newline='') as data_in:
        reader = csv.reader(data_in)
        next(reader)
        with open('cleaned_data/who_suicide_statistics_cleaned.csv', 'w', newline='') as data_out:
            writer = csv.writer(data_out)
            for row in reader:
                country = row[0]
                country = alternatives.get(country, country)
                year = row[1]
                sex = 'm' if row[2] == 'male' else 'f'
                ageid = ages[row[3]]
                suicides = row[4]
                population = row[5]
                if not suicides or not population or country not in countries:
                    continue
                s_rate = f'{100_000 * (int(suicides) / int(population)):.2f}'
                writer.writerow([countries[country], year, ageid, suicides, population, s_rate, sex])


def get_life_expectancy():
    """
    Returns a mapping of country and year to life expectancy.
    """
    countries = get_country_mapping()
    alternatives = {'Bolivia (Plurinational State of)': 'Bolivia',
                    'Brunei Darussalam': 'Brunei',
                    "CÃ´te d'Ivoire": "Cote d'Ivoire",
                    'Congo': 'Congo (Congo-Brazzaville)',
                    'Czechia': 'Czech Republic',
                    "Democratic People's Republic of Korea": 'South Korea',
                    'Iran (Islamic Republic of)': 'Iran',
                    "Lao People's Democratic Republic": 'Laos',
                    'Micronesia (Federated States of)': 'Micronesia',
                    'Myanmar': 'Myanmar (formerly Burma)',
                    'Republic of Korea': 'North Korea',
                    'Republic of Moldova': 'Moldova',
                    'Russian Federation': 'Russia',
                    'Swaziland': 'Eswatini (fmr. "Swaziland")',
                    'Syrian Arab Republic': 'Syria',
                    'The former Yugoslav republic of Macedonia': 'North Macedonia',
                    'United Kingdom of Great Britain and Northern Ireland': 'Ireland',
                    'United Republic of Tanzania': 'Tanzania',
                    'Venezuela (Bolivarian Republic of)': 'Venezuela',
                    'Viet Nam': 'Vietnam'}
    life_expectancies = {}
    with open('data/life_expectancy_data.csv', 'r', newline='') as data_in:
        reader = csv.reader(data_in)
        next(reader)
        for row in reader:
            country = row[0]
            country = alternatives.get(country, country)
            year = row[1]
            life_expectancy = row[3]
            if country not in countries:
                continue
            life_expectancies[(countries[country], year)] = life_expectancy
    return life_expectancies


def clean_economy_statistics() -> None:
    """
    Cleans the income inequality data.
    """
    countries = get_country_mapping()
    life_expectancies = get_life_expectancy()
    alternatives = {'Cape Verde': 'Cabo Verde',
                    'Congo, Dem. Rep.': 'Democratic Republic of the Congo',
                    'Congo, Rep.': 'Congo (Congo-Brazzaville)',
                    'Swaziland': 'Eswatini (fmr. "Swaziland")',
                    'United States': 'United States of America',
                    'Kyrgyz Republic': 'Kyrgyzstan',
                    'Lao': 'Laos',
                    'Myanmar': 'Myanmar (formerly Burma)',
                    'Palestine': 'Palestine State',
                    'Slovak Republic': 'Slovakia'}
    with open('data/income_inequality.csv', 'r', newline='') as data_in:
        reader = csv.reader(data_in)
        next(reader)
        with open('cleaned_data/income_inequality_cleaned.csv', 'w', newline='') as data_out:
            writer = csv.writer(data_out)
            for row in reader:
                country = row[1]
                country = alternatives.get(country, country)
                year = row[2]
                gdp_capita = row[4]
                gini = row[7]
                if (countries[country], year) not in life_expectancies:
                    continue
                lifespan = life_expectancies[(countries[country], year)]
                demo_index = row[3]
                writer.writerow([countries[country], year, gdp_capita, gini, lifespan, demo_index])


def clean_country_statistics() -> None:
    """
    Cleans the aggregated statistics for each country.
    """
    countries = get_country_mapping()
    continents = get_continent_mapping()
    with open('data/country_continent_government.csv', 'r', newline='') as data_in:
        reader = csv.reader(data_in)
        with open('cleaned_data/countries_cleaned.csv', 'w', newline='') as data_out:
            writer = csv.writer(data_out)
            for cont, country, govid in reader:
                writer.writerow([countries[country], country, continents[cont], govid])


if __name__ == '__main__':
    clean_suicide_statistics()
    clean_economy_statistics()
    clean_country_statistics()
