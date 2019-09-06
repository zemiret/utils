#!/bin/bash

# Be careful. You need to run this script with sudo!

systemctl stop ntpd
ntpdate pool.ntp.org

