"""
A script used to clean data for the CSC343 Databases project.
"""

import csv


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
