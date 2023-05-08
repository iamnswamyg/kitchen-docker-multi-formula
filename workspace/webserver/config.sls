{% from "webserver/map.jinja" import vars with context %}

include:
  - webserver.install

{{ sls }}.index.html:
  file.managed:
    - name: {{ pillar['doc_root'] }}/index.html
    - source: salt://webserver/files/index.html
    - require:
      - sls: webserver.install

{{ sls }}.server.conf:
  file.managed:
    - name: {{ pillar['server_conf'] }}
    - source: salt://webserver/templates/httpd.conf.j2
    - template: jinja
    - require:
      - sls: webserver.install
