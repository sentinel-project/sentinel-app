from countries.models import Country
from django.shortcuts import render
from django.views.generic import TemplateView
import csv
from django.http import HttpResponse
from django import forms
from django.contrib import messages


class IndexView(TemplateView):
    template_name = "index.html"


def countries_csv(request):
    # Create the HttpResponse object with the appropriate CSV header.
    # response = HttpResponse(content_type='text/plain')
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="countries.csv"'

    countries = Country.objects.all()
    fields = ('code', 'name', 'mdr_estimated_cases', 'mdr_eval_0',
              'mdr_eval_5', 'mdr_treat_0', 'mdr_treat_5',  'mdr_therapy_0',
              'mdr_therapy_5', 'reported_mdr', 'documented_adult_mdr',
              'documented_child_mdr', 'reported_xdr', 'documented_adult_xdr',
              'documented_child_xdr',)
    writer = csv.DictWriter(response, fields, extrasaction='ignore')
    writer.writeheader()
    for country in countries:
        def convert(val):
            if isinstance(val, bool):
                return int(val)
            else:
                return val
        row = {field: convert(getattr(country, field)) for field in fields}
        writer.writerow(row)

    return response


class UploadFileForm(forms.Form):
    csvfile = forms.FileField()


def import_csv(request, csvfile):
    pass


def bulk_upload(request):
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():
            import_csv(request, request.FILES['csvfile'])
            messages.info(request, "You uploaded a file.")
    else:
        form = UploadFileForm()

    return render(request, "bulk_admin.html", {"form": form})
