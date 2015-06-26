#!/bin/bash -x
set -e

sudo yum -y install httpd
sudo service httpd start
