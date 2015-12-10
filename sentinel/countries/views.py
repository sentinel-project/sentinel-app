from io import TextIOWrapper
import csv
import json
import chardet


from django.shortcuts import render, redirect
from django.http import HttpResponse
from django import forms
from django.contrib import messages

from countries.models import Country, Chart, ChartGroup

csv_fields = ('code',
              'name',
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
              't2m1',
              't2m1_text',
              't2m2',
              't2m2_text',
              't2m3',
              't2m3_text',
              )

integer_fields = ('mdr_estimated_cases', 'mdr_eval_0', 'mdr_eval_5',
                  'mdr_treat_0', 'mdr_treat_5', 'mdr_therapy_0',
                  'mdr_therapy_5', 't2m1', 't2m2', 't2m3')

boolean_fields = ('reported_mdr', 'documented_adult_mdr',
                  'documented_child_mdr', 'reported_xdr',
                  'documented_adult_xdr', 'documented_child_xdr',)


def index(request):
    charts = Chart.objects.all()
    charts_dict = {}
    for chart in charts:
        if chart.default_text:
            default_text = chart.default_text.strip().replace("\n", "<br />")
        else:
            default_text = "This chart needs default text."
        charts_dict[chart.name] = {
            "title": chart.title,
            "scale": chart.scale,
            "ordinals": chart.ordinals,
            "segments": chart.segments,
            "colorscheme": chart.colorscheme,
            "defaultText": default_text,
        }
    charts_json = json.dumps(charts_dict)
    return render(request, "index.html", {"chart_groups": ChartGroup.objects.all(), "charts_json": charts_json})


def example(request):
    return render(request, "example.html")


def embed_js(request):
    return render(request, "embed_js.tpl",
                  content_type="application/javascript")


def countries_csv(request):
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="countries.csv"'

    countries = Country.objects.all()
    writer = csv.DictWriter(response, csv_fields, extrasaction='ignore')
    writer.writeheader()
    for country in countries:
        def convert(val):
            if isinstance(val, bool):
                return int(val)
            else:
                return val

        row = {field: convert(getattr(country, field)) for field in csv_fields}
        writer.writerow(row)

    return response


class UploadFileForm(forms.Form):
    csvfile = forms.FileField()


def import_csv(request, csvfile):
    def convert(attr, value):
        if attr in integer_fields:
            return value
        elif attr in boolean_fields:
            return (value == "1")
        return value

    # Detect encoding before parsing file
    rawdata = csvfile.file.read()
    encoding = chardet.detect(rawdata)
    csvfile.file.seek(0)

    # Parse file
    csvtext = TextIOWrapper(csvfile.file, encoding=encoding['encoding'])
    reader = csv.DictReader(csvtext)
    if reader.fieldnames != list(csv_fields):
        return False
    else:
        for row in reader:
            data = {attr: convert(attr, value) for attr, value in row.items()}
            try:
                country = Country.objects.get(code=row['code'])
                for attr, value in data.items():
                    setattr(country, attr, value)
            except Country.DoesNotExist:
                country = Country(**data)
            country.save()
        return True


def bulk_upload(request):
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():
            valid = import_csv(request, request.FILES['csvfile'])
            if valid:
                messages.info(request, "Your file was imported successfully.")
                return redirect('/admin/')
            else:
                messages.error(request, "Your file was invalid.")
    else:
        form = UploadFileForm()

    return render(request, "bulk_admin.html", {"form": form})


def admin_embed(request):
    return render(request, "admin_embed.html")
