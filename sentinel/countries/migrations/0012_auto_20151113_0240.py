# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0011_chart_default_text'),
    ]

    operations = [
        migrations.CreateModel(
            name='ChartGroup',
            fields=[
                ('id', models.AutoField(serialize=False, primary_key=True, verbose_name='ID', auto_created=True)),
                ('order', models.PositiveIntegerField(db_index=True, editable=False)),
                ('title', models.CharField(max_length=100, unique=True)),
            ],
            options={
                'abstract': False,
                'ordering': ('order',),
            },
        ),
        migrations.AlterModelOptions(
            name='chart',
            options={'ordering': ('order',)},
        ),
        migrations.AddField(
            model_name='chart',
            name='order',
            field=models.PositiveIntegerField(db_index=True, editable=False, default=0),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='chart',
            name='chart_group',
            field=models.ForeignKey(to='countries.ChartGroup', null=True, blank=True),
        ),
    ]
