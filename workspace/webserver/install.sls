{% from "webserver/map.jinja" import vars with context %}

{{ sls }}.pkg:
  pkg.installed:
    - name: {{ vars['package'] }}

{{ sls }}.group:
  group.present:
    - name: {{ pillar['app_user'] }}
    - gid: {{ pillar['gid'] }}
    - require:
      - pkg: {{ sls }}.pkg

{{ sls }}.user:
  user.present:
    - name: {{ pillar['app_user'] }}
    - uid: {{ pillar['uid'] }}
    - gid: {{ pillar['gid'] }}
    - home: {{ pillar['doc_root'] }}
    - shell: /bin/nologin
    - allow_uid_change: true
    - require:
      - group: {{ sls }}.group
