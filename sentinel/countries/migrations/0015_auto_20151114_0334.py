# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0014_chart_menu_title'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='chart',
            options={'ordering': ['chart_group', 'order']},
        ),
        migrations.RemoveField(
            model_name='country',
            name='all_mdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='all_xdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='documented_mdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='documented_xdr_text',
        ),
        migrations.RemoveField(
            model_name='country',
            name='reported_text',
        ),
        migrations.AddField(
            model_name='country',
            name='documented_adult_mdr_text',
            field=models.TextField(verbose_name='Text for Publication documenting adult MDR TB case', blank=True, null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='documented_adult_xdr_text',
            field=models.TextField(verbose_name='Text for Publication documenting adult XDR TB case', blank=True, null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='documented_child_mdr_text',
            field=models.TextField(verbose_name='Text for Publication documenting child MDR TB case', blank=True, null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='documented_child_xdr_text',
            field=models.TextField(verbose_name='Text for Publication documenting child XDR TB case', blank=True, null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='pub_mdr_text',
            field=models.TextField(verbose_name='Text for MDR-TB publication category', blank=True, null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='pub_xdr_text',
            field=models.TextField(verbose_name='Text for XDR-TB publication category', blank=True, null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='reported_mdr_text',
            field=models.TextField(verbose_name='Text for reported MDR-TB case', blank=True, null=True),
        ),
        migrations.AddField(
            model_name='country',
            name='reported_xdr_text',
            field=models.TextField(verbose_name='Text for Reported XDR-TB case', blank=True, null=True),
        ),
    ]
