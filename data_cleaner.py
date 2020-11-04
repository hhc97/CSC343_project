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
            countries_dict[cid] = country
    return countries_dict


def get_continent_mapping():
    """
    Returns a dictionary mapping countries to their ID.
    """
    continents_dict = {}
    with open('data/continent_mapping.csv', 'r', newline='') as f:
        reader = csv.reader(f)
        for cid, continent in reader:
            continents_dict[cid] = continent
    return continents_dict


def get_age_mapping():
    """
    Returns a dictionary mapping countries to their ID.
    """
    ages_dict = {}
    with open('data/age_mapping.csv', 'r', newline='') as f:
        reader = csv.reader(f)
        for cid, age in reader:
            ages_dict[cid] = age
    return ages_dict


def clean_suicide_statistics() -> None:
    """
    Cleans the WHO suicide statistics.
    """
    with open('data/who_suicide_statistics.csv', 'r', newline='') as data_in:
        reader = csv.reader(data_in)
        header = next(reader)
        with open('cleaned_data/who_suicide_statistics_cleaned.csv', 'w', newline='') as data_out:
            writer = csv.writer(data_out)
            writer.writerow(header)


if __name__ == '__main__':
    clean_suicide_statistics()
