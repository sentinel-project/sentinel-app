# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import countries.models


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0015_auto_20151114_0334'),
    ]

    operations = [
        migrations.AddField(
            model_name='country',
            name='t2m1',
            field=models.PositiveIntegerField(default=0, verbose_name='Targets 2 Map 1 data'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='country',
            name='t2m1_text',
            field=models.TextField(blank=True, verbose_name='Text for Targets 2 Map 1 data', null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='t2m2',
            field=models.PositiveIntegerField(default=0, verbose_name='Targets 2 Map 2 data'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='country',
            name='t2m2_text',
            field=models.TextField(blank=True, verbose_name='Text for Targets 2 Map 2 data', null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='t2m3',
            field=models.PositiveIntegerField(default=0, verbose_name='Targets 2 Map 3 data'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='country',
            name='t2m3_text',
            field=models.TextField(blank=True, verbose_name='Text for Targets 2 Map 3 data', null=True),
        ),
        migrations.AlterField(
            model_name='chart',
            name='colorscheme',
            field=models.CharField(choices=[('Sequential', (('Blues', 'Blues'), ('Greens', 'Greens'), ('Grays', 'Grays'), ('Oranges', 'Oranges'), ('Purples', 'Purples'), ('Reds', 'Reds'))), ('Diverging', (('BrBG', 'Brown to Blue'), ('PiYG', 'Pink to Green'), ('PRGn', 'Purple to Green'), ('PuOr', 'Purple to Orange'), ('RdBu', 'Red to Blue'), ('RdGy', 'Red to Gray'), ('Spectral', 'Spectral'))), ('Qualitative', (('Accent', 'Accent'), ('Dark2', 'Dark2'), ('Paired', 'Paired'), ('Pastel1', 'Pastel1'), ('Pastel2', 'Pastel2'), ('Set1', 'Set1'), ('Set2', 'Set2'), ('Set3', 'Set3')))], default='Blues', max_length=20),
        ),
        migrations.AlterField(
            model_name='chart',
            name='name',
            field=models.CharField(validators=[countries.models.validate_chart_name], unique=True, max_length=25),
        ),
    ]
