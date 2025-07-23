#!/bin/bash

SCANDIR=/tmp/scanner

mkdir $SCANDIR 2>/dev/null

cd $SCANDIR && rm $SCANDIR/{*.tiff,*.pdf} 2>/dev/null

/home/dk/.local/bin/scan-duplex-black-and-white-auto.sh \
    # && img2pdf Scan_page*.tiff -o Scan_$(date +%Y-%m-%d_%H%M%S).pdf

scp $SCANDIR/Scan_*.pdf paperless:/root/scanner \
    && ssh paperless "mv /root/scanner/Scan_*.pdf /opt/paperless/consume"

