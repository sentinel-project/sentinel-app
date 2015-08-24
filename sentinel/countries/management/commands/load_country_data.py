from django.core.management.base import BaseCommand
from django.conf import settings
from ...models import Country
import csv

class Command(BaseCommand):
    help = "Load country data"

    def handle(self, *args, **options):
        tb_csv = settings.BASE_DIR + "/tb_publications.csv"
        targets_csv = settings.BASE_DIR + "/crude_evaluation_targets.csv"

        countries = {}

        with open(tb_csv, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                code = row["Country code"]
                try:
                    country = Country.objects.get(code=code)
                except Country.DoesNotExist:
                    country = Country(code=code)
                country.name = row["Country/ territory"]
                country.reported_mdr = True if row["Reported MDR TB case\n(0=no, 1=yes)"] == "1" else False
                country.reported_xdr = True if row["Reported XDR TB case\n(0=no, 1=yes)"] == "1" else False
                country.documented_adult_mdr = True if row["Publication documenting adult MDR TB case\n(0=no, 1=yes)"] == "1" else False
                country.documented_child_mdr = True if row["Publication documenting child MDR TB case\n(0=no, 1=yes)"] == "1" else False
                country.documented_adult_xdr = True if row["Publication documenting adult XDR TB case\n(0=no, 1=yes)"] == "1" else False
                country.documented_child_xdr = True if row["Publication documenting child XDR TB case\n(0=no, 1=yes)"] == "1" else False
                countries[code] = country

        with open(targets_csv, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                code = row["Country code"]
                country = countries[code]
                country.name = row["Country"]
                country.mdr_estimated_cases = row["Estimated MDR-TB cases"]
                country.mdr_eval_0 = row["0-4 year olds needing evaluation"]
                country.mdr_eval_5 = row["5-14 year olds needing evaluation"]
                country.mdr_treat_0 = row["0-4 year olds needing treatment"]
                country.mdr_treat_5 = row["5-14 year olds needing treatment"]
                country.mdr_therapy_0 = row["0-4 year olds needing preventive therapy"]
                country.mdr_therapy_5 = row["5-14 year olds needing preventive therapy"]
                country.save()
