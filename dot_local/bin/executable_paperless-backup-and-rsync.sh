#!/bin/bash

ssh paperless "rm -rf /opt/paperless/backup/export-*.zip && cd /opt/paperless/src && /opt/paperless/src/manage.py document_exporter -p -sm -z /opt/paperless/backup" \
    && rsync -ravhP paperless:/opt/paperless/backup/ .
