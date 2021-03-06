from django.contrib import admin
from ordered_model.admin import OrderedModelAdmin

from .models import Country, Chart, ChartGroup
from .views import bulk_upload, admin_embed

admin.site.register_view(
    'bulk/',
    view=bulk_upload,
    name="Upload CSV to update data",
    urlname='bulk_admin')

admin.site.register_view(
    'embed/',
    view=admin_embed,
    name="Get JavaScript embed code",
    urlname="admin_embed"
)


class CountryAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['code', 'name']}),
        ('Map the Gap', {'fields': [
            'reported_mdr',
            'reported_mdr_text',
            'reported_xdr',
            'reported_xdr_text',
            'documented_adult_mdr',
            'documented_adult_mdr_text',
            'documented_child_mdr',
            'documented_child_mdr_text',
            'documented_adult_xdr',
            'documented_adult_xdr_text',
            'documented_child_xdr',
            'documented_child_xdr_text',
            'pub_mdr_text',
            'pub_xdr_text',
        ]}),
        ('Targets', {'fields': [
            'mdr_estimated_cases',
            'mdr_estimated_cases_text',
            'mdr_eval_0',
            'mdr_eval_0_text',
            'mdr_eval_5',
            'mdr_eval_5_text',
            'mdr_treat_0',
            'mdr_treat_0_text',
            'mdr_treat_5',
            'mdr_treat_5_text',
            'mdr_therapy_0',
            'mdr_therapy_0_text',
            'mdr_therapy_5',
            'mdr_therapy_5_text',
        ]}),
        ('Targets 2', {'fields': [
            't2m1',
            't2m1_text',
            't2m2',
            't2m2_text',
            't2m3',
            't2m3_text',
        ]}),
    ]

class ChartGroupAdmin(OrderedModelAdmin):
    list_display = ('title', 'move_up_down_links')
    prepopulated_fields = {"slug": ("title",)}

class ChartAdmin(OrderedModelAdmin):
    list_display = ('title', 'chart_group', 'move_up_down_links')

admin.site.register(ChartGroup, ChartGroupAdmin)
admin.site.register(Chart, ChartAdmin)
admin.site.register(Country, CountryAdmin)

from django.contrib.auth.models import Group

admin.site.unregister(Group)
