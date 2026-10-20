#!/bin/bash

# damit wird nur ein backend geladen. aktuell "brother5"
export SANE_CONFIG_DIR=~/.config/sane.d

scanimage --batch=Scan_$(date +%Y-%m-%d_%H%M%S).jpg --format=jpeg -x 210 -y 297 \
          --source="Automatic Document Feeder(center aligned,Duplex)" \
          --mode="24bit Color[Fast]" --resolution="300" 

