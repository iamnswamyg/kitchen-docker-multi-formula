#!/usr/bin/env python3.8

import requests

def test_apache_service(host):
    ''' To check Http Service '''
    assert host.service('httpd')

def test_index_file(host):
    ''' To check index.html file '''
    index = host.file('/var/www/html/index.html')
    assert index.contains('Demo SaltStack TestKitchen')

def test_website_200(url):
    ''' To check status code '''
    assert requests.get(url).status_code == 200

def test_website_content(url):
    ''' To validate content of webserver'''
    assert 'Demo SaltStack TestKitchen' in requests.get(url).text
