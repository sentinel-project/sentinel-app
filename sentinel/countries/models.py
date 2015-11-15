import re

from django.db import models
from django.core.exceptions import ValidationError
from django.contrib.postgres.fields import ArrayField
from ordered_model.models import OrderedModel


def validate_chart_name(value):
    if re.fullmatch(r'[a-z0-9_]+', value) is None:
        raise ValidationError('%s is not a valid chart name' % value)


def duple(x):
    return (x, x,)


def log_to_option(max_power):
    labels = []
    for i in range(max_power - 1):
        labels.append("{:,}-{:,}".format(10 ** i, 10 ** (i + 1) - 1))
    labels.append("{:,}+".format(10 ** (max_power - 1)))
    return "; ".join(labels)


class ChartGroup(OrderedModel):
    title = models.CharField(max_length=100, unique=True)
    slug = models.SlugField(unique=True)

    def __str__(self):
        return self.title


class Chart(OrderedModel):
    ORDINAL = 'ordinal'
    LOG = 'log'
    SCALES = (
        (ORDINAL, 'Ordinal'),
        (LOG, 'Logarithmic'),
    )

    SEGMENTS = [(n, log_to_option(n)) for n in range(3, 10)]

    COLORSCHEMES = (
        ('Sequential', (
            duple('Blues'),
            duple('Greens'),
            duple('Grays'),
            duple('Oranges'),
            duple('Purples'),
            duple('Reds'),
        )),
        ('Diverging', (
            ('BrBG', 'Brown to Blue'),
            ('PiYG', 'Pink to Green'),
            ('PRGn', 'Purple to Green'),
            ('PuOr', 'Purple to Orange'),
            ('RdBu', 'Red to Blue'),
            ('RdGy', 'Red to Gray'),
            duple('Spectral'),
        )),
        ('Qualitative', (
            duple('Accent'),
            duple('Dark2'),
            duple('Paired'),
            duple('Pastel1'),
            duple('Pastel2'),
            duple('Set1'),
            duple('Set2'),
            duple('Set3'),
        ))
    )

    name = models.CharField(unique=True, max_length=25,
                            validators=[validate_chart_name],
                            help_text="<strong>Do not edit this unless you are sure of what you are doing.</strong>"
                            )
    title = models.CharField("Title on top of page", max_length=255)
    menu_title = models.CharField(
        "Title in menu",
        max_length=255, blank=True, null=True,
        help_text="You can leave this blank if you want the same title as on top of page.")
    chart_group = models.ForeignKey(ChartGroup, blank=True, null=True)
    scale = models.CharField(max_length=20, choices=SCALES)
    ordinals = ArrayField(models.CharField(max_length=100), null=True, blank=True,
                          help_text="List the options separated by commas with no spaces.")
    segments = models.PositiveIntegerField(null=True, blank=True, choices=SEGMENTS,
                                           help_text="Only select this for logarithmic charts.")
    colorscheme = models.CharField(max_length=20, choices=COLORSCHEMES, default='Blues',
                                   help_text="See <a href='http://colorbrewer2.org/' target='_blank'>Colorbrewer</a>"
                                             " to see the color schemes.")
    default_text = models.TextField("Text to show when no country is selected", blank=True, null=True)

    order_with_respect_to = 'chart_group'

    class Meta(OrderedModel.Meta):
        ordering = ['chart_group', 'order']

    def __str__(self):
        return self.title


class Country(models.Model):
    class Meta:
        ordering = ('code',)
        verbose_name_plural = 'countries'

    code = models.CharField("Country code 3-char", max_length=3, unique=True)
    name = models.CharField("Country name", max_length=255, unique=True)

    mdr_estimated_cases = models.PositiveIntegerField("Estimated MDR-TB cases")
    mdr_estimated_cases_text = models.TextField("Text for Estimated MDR-TB cases", null=True, blank=True)

    mdr_eval_0 = models.PositiveIntegerField(
        "0-4 year-olds needing evaluation")
    mdr_eval_0_text = models.TextField(
        "Text for 0-4 year-olds needing evaluation", null=True, blank=True)

    mdr_eval_5 = models.PositiveIntegerField(
        "5-14 year-olds needing evaluation")
    mdr_eval_5_text = models.TextField(
        "Text for 5-14 year-olds needing evaluation", null=True, blank=True)

    mdr_treat_0 = models.PositiveIntegerField(
        "0-4 year-olds needing treatment")
    mdr_treat_0_text = models.TextField(
        "Text for 0-4 year-olds needing treatment", null=True, blank=True)

    mdr_treat_5 = models.PositiveIntegerField(
        "5-14 year-olds needing treatment")
    mdr_treat_5_text = models.TextField(
        "Text for 5-14 year-olds needing treatment", null=True, blank=True)

    mdr_therapy_0 = models.PositiveIntegerField(
        "0-4 year-olds needing preventative therapy")
    mdr_therapy_0_text = models.TextField(
        "Text for 0-4 year-olds needing preventative therapy", null=True, blank=True)

    mdr_therapy_5 = models.PositiveIntegerField(
        "5-14 year-olds needing preventative therapy")
    mdr_therapy_5_text = models.TextField(
        "Text for 5-14 year-olds needing preventative therapy", null=True, blank=True)

    reported_mdr = models.BooleanField("Reported MDR-TB case")
    reported_mdr_text = models.TextField("Text for reported MDR-TB case", null=True, blank=True)

    reported_xdr = models.BooleanField("Reported XDR-TB case")
    reported_xdr_text = models.TextField("Text for Reported XDR-TB case", null=True, blank=True)

    documented_adult_mdr = models.BooleanField(
        "Publication documenting adult MDR TB case")
    documented_adult_mdr_text = models.TextField(
        "Text for Publication documenting adult MDR TB case", null=True, blank=True)
    documented_child_mdr = models.BooleanField(
        "Publication documenting child MDR TB case")
    documented_child_mdr_text = models.TextField(
        "Text for Publication documenting child MDR TB case", null=True, blank=True)
    documented_adult_xdr = models.BooleanField(
        "Publication documenting adult XDR TB case")
    documented_adult_xdr_text = models.TextField(
        "Text for Publication documenting adult XDR TB case", null=True, blank=True)
    documented_child_xdr = models.BooleanField(
        "Publication documenting child XDR TB case")
    documented_child_xdr_text = models.TextField(
        "Text for Publication documenting child XDR TB case", null=True, blank=True)

    pub_mdr_text = models.TextField(
        "Text for MDR-TB publication category", null=True, blank=True)
    pub_xdr_text = models.TextField(
        "Text for XDR-TB publication category", null=True, blank=True)

    t2m1 = models.PositiveIntegerField("Targets 2 Map 1 data")
    t2m1_text = models.TextField(
        "Text for Targets 2 Map 1 data", null=True, blank=True)
    t2m2 = models.PositiveIntegerField("Targets 2 Map 2 data")
    t2m2_text = models.TextField(
        "Text for Targets 2 Map 2 data", null=True, blank=True)
    t2m3 = models.PositiveIntegerField("Targets 2 Map 3 data")
    t2m3_text = models.TextField(
        "Text for Targets 2 Map 3 data", null=True, blank=True)

    def __str__(self):
        return self.name
