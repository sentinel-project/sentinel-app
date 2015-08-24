from django.db import models


class Country(models.Model):
    code = models.CharField("Country code", max_length=2, unique=True)
    name = models.CharField("Country name", max_length=255, unique=True)
    mdr_estimated_cases = models.PositiveIntegerField("Estimated MDR-TB cases")
    mdr_eval_0 = models.PositiveIntegerField(
        "0-4 year-olds needing evaluation")
    mdr_eval_5 = models.PositiveIntegerField(
        "5-14 year-olds needing evaluation")
    mdr_treat_0 = models.PositiveIntegerField(
        "0-4 year-olds needing treatment")
    mdr_treat_5 = models.PositiveIntegerField(
        "5-14 year-olds needing treatment")
    mdr_therapy_0 = models.PositiveIntegerField(
        "0-4 year-olds needing preventative therapy")
    mdr_therapy_5 = models.PositiveIntegerField(
        "5-14 year-olds needing preventative therapy")
    reported_mdr = models.BooleanField("Reported MDR-TB case")
    reported_xdr = models.BooleanField("Reported XDR-TB case")
    documented_adult_mdr = models.BooleanField(
        "Publication documenting adult MDR TB case")
    documented_child_mdr = models.BooleanField(
        "Publication documenting child MDR TB case")
    documented_adult_xdr = models.BooleanField(
        "Publication documenting adult XDR TB case")
    documented_child_xdr = models.BooleanField(
        "Publication documenting child XDR TB case")

    class Meta:
        ordering = ('code',)
        verbose_name_plural = 'countries'
