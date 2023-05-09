{% set hugo_version = pillar['hugo_deployment_data']['version'] %}

wget-package:
  pkg.installed:
    - name: wget

hugo-download:
  cmd.run:
    - name: |
        cd /tmp && \
        wget https://github.com/gohugoio/hugo/releases/download/v{{ hugo_version }}/hugo_extended_{{ hugo_version }}_Linux-64bit.tar.gz && \
        tar -xf hugo_extended_{{ hugo_version }}_Linux-64bit.tar.gz && \
        mv hugo /usr/local/bin/hugo && \
        rm hugo_extended_{{ hugo_version }}_Linux-64bit.tar.gz

nginx_pkg:
  pkg.installed:
    - name: nginx

git_pkg:
  pkg.installed:
    - name: git

hugo-version:
  cmd.run:
    - name: hugo version


