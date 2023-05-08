{% from "webserver/map.jinja" import vars with context %}

include:
  - webserver.install
  - webserver.config

{{ sls }}.service:
  service.running:
    - name: {{ vars['service'] }}
    - watch:
      - sls: webserver.install
      - sls: webserver.config
