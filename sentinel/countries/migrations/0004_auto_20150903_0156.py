# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.postgres.fields


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0003_auto_20150903_0156'),
    ]

    operations = [
        migrations.AlterField(
            model_name='chart',
            name='ordinals',
            field=django.contrib.postgres.fields.ArrayField(size=None, null=True, base_field=models.CharField(max_length=100), blank=True),
        ),
    ]
