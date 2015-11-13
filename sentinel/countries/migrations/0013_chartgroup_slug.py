# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0012_auto_20151113_0240'),
    ]

    operations = [
        migrations.AddField(
            model_name='chartgroup',
            name='slug',
            field=models.SlugField(unique=True, default=''),
            preserve_default=False,
        ),
    ]
