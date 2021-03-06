"""sentinel URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from countries.views import index, countries_csv, example, embed_js
from django.conf.urls import include, url
from django.contrib import admin
from adminplus.sites import AdminSitePlus

admin.site = AdminSitePlus()
admin.autodiscover()

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', index, name="index"),
    url(r'^example/$', example, name="example"),
    url(r'^embed.js$', embed_js, name="embed_js"),
    url(r'^countries.csv$', countries_csv, name="countries_csv"),
]
