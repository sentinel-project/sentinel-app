from django.db import models
from django.core.exceptions import ValidationError
from django.contrib.postgres.fields import ArrayField

import re


def validate_chart_name(value):
    if re.fullmatch(r'[a-z_]+', value) is None:
        raise ValidationError('% is not a valid chart name' % value)


class Chart(models.Model):
    ORDINAL = 'ordinal'
    LOG = 'log'
    CONTINUOUS = 'continuous'
    SCALES = (
        (ORDINAL, 'Ordinal'),
        (LOG, 'Logarithmic'),
        (CONTINUOUS, 'Continuous')
    )

    name = models.CharField(unique=True, max_length=25,
                            validators=[validate_chart_name])
    title = models.CharField(max_length=255)
    scale = models.CharField(max_length=20, choices=SCALES)
    ordinals = ArrayField(models.CharField(max_length=100))
    segments = models.PositiveIntegerField(null=True, blank=True)


class Country(models.Model):
    class Meta:
        ordering = ('code',)
        verbose_name_plural = 'countries'

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

    def __str__(self):
        return self.name
