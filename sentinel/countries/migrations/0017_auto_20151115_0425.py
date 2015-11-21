# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.postgres.fields
import countries.models


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0016_auto_20151115_0340'),
    ]

    operations = [
        migrations.AlterField(
            model_name='chart',
            name='colorscheme',
            field=models.CharField(max_length=20, help_text="See <a href='http://colorbrewer2.org/' target='_blank'>Colorbrewer</a> to see the color schemes.", default='Blues', choices=[('Sequential', (('Blues', 'Blues'), ('Greens', 'Greens'), ('Grays', 'Grays'), ('Oranges', 'Oranges'), ('Purples', 'Purples'), ('Reds', 'Reds'))), ('Diverging', (('BrBG', 'Brown to Blue'), ('PiYG', 'Pink to Green'), ('PRGn', 'Purple to Green'), ('PuOr', 'Purple to Orange'), ('RdBu', 'Red to Blue'), ('RdGy', 'Red to Gray'), ('Spectral', 'Spectral'))), ('Qualitative', (('Accent', 'Accent'), ('Dark2', 'Dark2'), ('Paired', 'Paired'), ('Pastel1', 'Pastel1'), ('Pastel2', 'Pastel2'), ('Set1', 'Set1'), ('Set2', 'Set2'), ('Set3', 'Set3')))]),
        ),
        migrations.AlterField(
            model_name='chart',
            name='menu_title',
            field=models.CharField(max_length=255, help_text='You can leave this blank if you want the same title as on top of page.', null=True, blank=True, verbose_name='Title in menu'),
        ),
        migrations.AlterField(
            model_name='chart',
            name='name',
            field=models.CharField(max_length=25, help_text='<strong>Do not edit this unless you are sure of what you are doing.</strong>', unique=True, validators=[countries.models.validate_chart_name]),
        ),
        migrations.AlterField(
            model_name='chart',
            name='ordinals',
            field=django.contrib.postgres.fields.ArrayField(help_text='List the options separated by commas with no spaces.', size=None, null=True, blank=True, base_field=models.CharField(max_length=100)),
        ),
        migrations.AlterField(
            model_name='chart',
            name='segments',
            field=models.PositiveIntegerField(help_text='Only select this for logarithmic charts.', null=True, blank=True, choices=[(3, '1-9; 10-99; 100+'), (4, '1-9; 10-99; 100-999; 1,000+'), (5, '1-9; 10-99; 100-999; 1,000-9,999; 10,000+'), (6, '1-9; 10-99; 100-999; 1,000-9,999; 10,000-99,999; 100,000+'), (7, '1-9; 10-99; 100-999; 1,000-9,999; 10,000-99,999; 100,000-999,999; 1,000,000+'), (8, '1-9; 10-99; 100-999; 1,000-9,999; 10,000-99,999; 100,000-999,999; 1,000,000-9,999,999; 10,000,000+'), (9, '1-9; 10-99; 100-999; 1,000-9,999; 10,000-99,999; 100,000-999,999; 1,000,000-9,999,999; 10,000,000-99,999,999; 100,000,000+')]),
        ),
        migrations.AlterField(
            model_name='chart',
            name='title',
            field=models.CharField(max_length=255, verbose_name='Title on top of page'),
        ),
    ]
