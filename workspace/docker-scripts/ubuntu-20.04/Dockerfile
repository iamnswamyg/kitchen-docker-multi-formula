FROM ubuntu:20.04

RUN    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    && apt update \
    && apt install -y apt-transport-https bash curl gnupg2 python3 unzip vim zip \
    && curl -fsSL https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo "deb https://repo.saltproject.io/py3/ubuntu/20.04/amd64/latest focal main" >/etc/apt/sources.list.d/saltstack.list

RUN    apt update \
    && apt install -y salt-minion
# https://github.com/saltstack/salt/issues/21317
# https://major.io/2016/05/05/preventing-ubuntu-16-04-starting-daemons-package-installed/
#   && rm /usr/sbin/policy-rc.d