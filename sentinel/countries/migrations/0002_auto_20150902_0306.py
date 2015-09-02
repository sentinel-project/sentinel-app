# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.postgres.fields
import countries.models


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Chart',
            fields=[
                ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True, serialize=False)),
                ('name', models.CharField(unique=True, max_length=25, validators=[countries.models.validate_chart_name])),
                ('title', models.CharField(max_length=255)),
                ('scale', models.CharField(choices=[('ordinal', 'Ordinal'), ('log', 'Logarithmic'), ('continuous', 'Continuous')], max_length=20)),
                ('ordinals', django.contrib.postgres.fields.ArrayField(base_field=models.CharField(max_length=100), size=None)),
                ('segments', models.PositiveIntegerField()),
            ],
        ),
        migrations.AlterModelOptions(
            name='country',
            options={'verbose_name_plural': 'countries', 'ordering': ('code',)},
        ),
    ]
