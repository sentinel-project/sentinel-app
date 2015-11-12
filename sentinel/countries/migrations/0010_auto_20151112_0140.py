# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0009_auto_20151112_0130'),
    ]

    operations = [
        migrations.AddField(
            model_name='country',
            name='documented_xdr_text',
            field=models.TextField(blank=True, null=True, verbose_name='Text for XDR-TB publication status'),
        ),
        migrations.AlterField(
            model_name='country',
            name='documented_mdr_text',
            field=models.TextField(blank=True, null=True, verbose_name='Text for MDR-TB publication status'),
        ),
    ]
