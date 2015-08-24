# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Country',
            fields=[
                ('id', models.AutoField(auto_created=True, verbose_name='ID', primary_key=True, serialize=False)),
                ('code', models.CharField(max_length=2, unique=True, verbose_name='Country code')),
                ('name', models.CharField(max_length=255, unique=True, verbose_name='Country name')),
                ('mdr_estimated_cases', models.PositiveIntegerField(verbose_name='Estimated MDR-TB cases')),
                ('mdr_eval_0', models.PositiveIntegerField(verbose_name='0-4 year-olds needing evaluation')),
                ('mdr_eval_5', models.PositiveIntegerField(verbose_name='5-14 year-olds needing evaluation')),
                ('mdr_treat_0', models.PositiveIntegerField(verbose_name='0-4 year-olds needing treatment')),
                ('mdr_treat_5', models.PositiveIntegerField(verbose_name='5-14 year-olds needing treatment')),
                ('mdr_therapy_0', models.PositiveIntegerField(verbose_name='0-4 year-olds needing preventative therapy')),
                ('mdr_therapy_5', models.PositiveIntegerField(verbose_name='5-14 year-olds needing preventative therapy')),
                ('reported_mdr', models.BooleanField(verbose_name='Reported MDR-TB case')),
                ('reported_xdr', models.BooleanField(verbose_name='Reported XDR-TB case')),
                ('documented_adult_mdr', models.BooleanField(verbose_name='Publication documenting adult MDR TB case')),
                ('documented_child_mdr', models.BooleanField(verbose_name='Publication documenting child MDR TB case')),
                ('documented_adult_xdr', models.BooleanField(verbose_name='Publication documenting adult XDR TB case')),
                ('documented_child_xdr', models.BooleanField(verbose_name='Publication documenting child XDR TB case')),
            ],
            options={
                'ordering': ('code',),
            },
        ),
    ]
