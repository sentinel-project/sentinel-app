# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0004_auto_20150903_0156'),
    ]

    operations = [
        migrations.AlterField(
            model_name='chart',
            name='segments',
            field=models.PositiveIntegerField(null=True, choices=[(3, '3'), (4, '4'), (5, '5'), (6, '6'), (7, '7'), (8, '8'), (9, '9'), (10, '10'), (11, '11'), (12, '12')], blank=True),
        ),
        migrations.AlterField(
            model_name='country',
            name='code',
            field=models.CharField(max_length=3, verbose_name='Country code 3-char', unique=True),
        ),
    ]
