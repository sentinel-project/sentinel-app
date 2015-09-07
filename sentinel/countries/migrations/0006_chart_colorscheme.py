# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('countries', '0005_auto_20150905_1915'),
    ]

    operations = [
        migrations.AddField(
            model_name='chart',
            name='colorscheme',
            field=models.CharField(default='Blues', choices=[('Blues', 'Blues'), ('Greens', 'Greens'), ('Grays', 'Grays'), ('Oranges', 'Oranges'), ('Purples', 'Purples'), ('Reds', 'Reds'), ('BuGn', 'Blue to Green'), ('BuPu', 'Blue to Purple'), ('GnBu', 'Green to Blue'), ('OrRd', 'Orange to Red'), ('PuBu', 'Purple to Blue'), ('PuRd', 'Purple to Red'), ('PuBuGn', 'Purple/Blue/Green'), ('RdPu', 'Red to Purple'), ('YlGn', 'Yellow to Green'), ('YlGnBu', 'Yellow/Green/Blue'), ('YlOrBr', 'Yellow/Orange/Brown'), ('YlOrRd', 'Yellow/Orange/Red')], max_length=20),
        ),
    ]
