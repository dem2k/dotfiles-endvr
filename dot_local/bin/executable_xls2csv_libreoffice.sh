#!/bin/bash

# Check if file parameter is provided
if [ $# -eq 0 ]; then
    echo "Fehler: Keine Datei angegeben"
    echo "Verwendung: $0 <xls-datei>"
    exit 1
fi

XLS_FILE="$1"

# Check if file exists
if [ ! -f "$XLS_FILE" ]; then
    echo "Fehler: Datei '$XLS_FILE' nicht gefunden"
    exit 1
fi

# Convert XLS to CSV with semicolon delimiter
echo "Konvertiere '$XLS_FILE' zu CSV mit Semikolon-Delimiter..."
libreoffice --headless --convert-to csv:"Text - txt - csv (StarCalc)":59,34,76,1 --outdir . "$XLS_FILE"

if [ $? -eq 0 ]; then
    echo "Konvertierung erfolgreich abgeschlossen"
else
    echo "Fehler bei der Konvertierung"
    exit 1
fi
