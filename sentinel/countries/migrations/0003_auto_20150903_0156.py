# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0002_auto_20150902_0306'),
    ]

    operations = [
        migrations.AlterField(
            model_name='chart',
            name='segments',
            field=models.PositiveIntegerField(null=True, blank=True),
        ),
    ]
