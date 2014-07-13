#!/bin/sh

[ -r index.html ] && mv index.html index.html.prev
wget `cat url.txt` 2>/dev/null || echo error

