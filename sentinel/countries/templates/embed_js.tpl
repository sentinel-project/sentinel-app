{% load staticfiles %}
document.write("<script src='{{ request.scheme }}://{{ request.get_host }}{% static 'iframeResizer.min.js' %}'></scr" + "ipt>");
document.write('<iframe src="{{ request.scheme }}://{{ request.get_host }}{% url 'index' %}" style="width:100%; border:0;" scrolling="no"></iframe>');
document.write('<scr' + 'ipt>iFrameResize();</scr' + 'ipt>');