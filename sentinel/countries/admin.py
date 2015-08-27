from django.contrib import admin

from .models import Country
from .views import bulk_upload

admin.site.register_view(
    'bulk/',
    view=bulk_upload,
    name="Upload CSV to update data",
    urlname='bulk_admin')

admin.site.register(Country)
