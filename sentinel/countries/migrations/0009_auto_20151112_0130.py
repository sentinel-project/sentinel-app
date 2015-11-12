# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0008_auto_20151112_0126'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='country',
            name='pub_mdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='pub_xdr_text',
        ),
        migrations.AddField(
            model_name='country',
            name='all_mdr_text',
            field=models.TextField(null=True, verbose_name='Text for all MDR-TB data', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='all_xdr_text',
            field=models.TextField(null=True, verbose_name='Text for all MDR-TB data', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='documented_mdr_text',
            field=models.TextField(null=True, verbose_name='Text for XDR-TB publication status', blank=True),
        ),
        migrations.AddField(
            model_name='country',
            name='reported_text',
            field=models.TextField(null=True, verbose_name='Text for reported TB cases', blank=True),
        ),
    ]
