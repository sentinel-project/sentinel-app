# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0010_auto_20151112_0140'),
    ]

    operations = [
        migrations.AddField(
            model_name='chart',
            name='default_text',
            field=models.TextField(null=True, blank=True, verbose_name='Text to show when no country is selected'),
        ),
    ]
