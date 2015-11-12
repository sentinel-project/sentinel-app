# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0007_auto_20151112_0123'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='country',
            name='documented_adult_mdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='documented_adult_xdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='documented_child_mdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='documented_child_xdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='reported_mdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='reported_xdr_text',
        ),
        migrations.AddField(
            model_name='country',
            name='pub_mdr_text',
            field=models.TextField(blank=True, verbose_name='Text for MDR Publication Status', null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='pub_xdr_text',
            field=models.TextField(blank=True, verbose_name='Text for MDR Publication Status', null=True),
        ),
    ]
