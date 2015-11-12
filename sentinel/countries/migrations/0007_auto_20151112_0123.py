# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import countries.models


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0006_chart_colorscheme'),
    ]

    operations = [
        migrations.AddField(
            model_name='country',
            name='documented_adult_mdr_text',
            field=models.TextField(null=True, verbose_name='Text for Publication documenting adult MDR TB case', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='documented_adult_xdr_text',
            field=models.TextField(null=True, verbose_name='Text for Publication documenting adult XDR TB case', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='documented_child_mdr_text',
            field=models.TextField(null=True, verbose_name='Text for Publication documenting child MDR TB case', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='documented_child_xdr_text',
            field=models.TextField(null=True, verbose_name='Text for Publication documenting child XDR TB case', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='mdr_estimated_cases_text',
            field=models.TextField(null=True, verbose_name='Text for Estimated MDR-TB cases', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='mdr_eval_0_text',
            field=models.TextField(null=True, verbose_name='Text for 0-4 year-olds needing evaluation', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='mdr_eval_5_text',
            field=models.TextField(null=True, verbose_name='Text for 5-14 year-olds needing evaluation', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='mdr_therapy_0_text',
            field=models.TextField(null=True, verbose_name='Text for 0-4 year-olds needing preventative therapy', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='mdr_therapy_5_text',
            field=models.TextField(null=True, verbose_name='Text for 5-14 year-olds needing preventative therapy', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='mdr_treat_0_text',
            field=models.TextField(null=True, verbose_name='Text for 0-4 year-olds needing treatment', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='mdr_treat_5_text',
            field=models.TextField(null=True, verbose_name='Text for 5-14 year-olds needing treatment', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='reported_mdr_text',
            field=models.TextField(null=True, verbose_name='Text for Reported MDR-TB case', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='reported_xdr_text',
            field=models.TextField(null=True, verbose_name='Text for Reported XDR-TB case', blank=True),
        ),
        migrations.AlterField(
            model_name='chart',
            name='name',
            field=models.CharField(editable=False, max_length=25, unique=True, validators=[countries.models.validate_chart_name]),
        ),
        migrations.AlterField(
            model_name='chart',
            name='scale',
            field=models.CharField(choices=[('ordinal', 'Ordinal'), ('log', 'Logarithmic')], max_length=20),
        ),
        migrations.AlterField(
            model_name='chart',
            name='segments',
            field=models.PositiveIntegerField(null=True, choices=[(3, '1-9; 10-99; 100+'), (4, '1-9; 10-99; 100-999; 1,000+'), (5, '1-9; 10-99; 100-999; 1,000-9,999; 10,000+'), (6, '1-9; 10-99; 100-999; 1,000-9,999; 10,000-99,999; 100,000+'), (7, '1-9; 10-99; 100-999; 1,000-9,999; 10,000-99,999; 100,000-999,999; 1,000,000+'), (8, '1-9; 10-99; 100-999; 1,000-9,999; 10,000-99,999; 100,000-999,999; 1,000,000-9,999,999; 10,000,000+'), (9, '1-9; 10-99; 100-999; 1,000-9,999; 10,000-99,999; 100,000-999,999; 1,000,000-9,999,999; 10,000,000-99,999,999; 100,000,000+')], blank=True),
        ),
    ]
