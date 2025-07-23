#!/bin/bash

scanimage --batch=Scan_page%03d.tiff --progress --format=tiff -x 210 -y 297 \
          --source="Automatic Document Feeder(center aligned,Duplex)" \
          --mode="24bit Color[Fast]" --resolution="300" \
    && img2pdf Scan_page*.tiff -o Scan_$(date +%Y-%m-%d_%H%M%S).pdf

