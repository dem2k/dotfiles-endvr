#!/bin/bash

# Dieses Skript generiert einen QR-Code aus dem Inhalt der Zwischenablage
# und zeigt ihn direkt im Terminal an.

# Benötigte Programme prüfen
if ! command -v qrencode &> /dev/null; then
    echo "Fehler: 'qrencode' ist nicht installiert."
    echo "Bitte installieren Sie es mit Ihrem Paketmanager (z.B. 'sudo apt install qrencode')."
    exit 1
fi

if ! command -v xclip &> /dev/null; then
    echo "Fehler: 'xclip' ist nicht installiert."
    echo "Bitte installieren Sie es mit Ihrem Paketmanager (z.B. 'sudo apt install xclip')."
    exit 1
fi

# Inhalt aus der Zwischenablage holen
clipboard_content=$(xclip -o -selection clipboard)

# Prüfen, ob die Zwischenablage leer ist
if [ -z "$clipboard_content" ]; then
    echo "Die Zwischenablage ist leer. Bitte kopieren Sie zuerst einen Text."
    exit 1
fi

# QR-Code im Terminal mit ANSI-Zeichen generieren
echo "${clipboard_content:0:76}..." # Zeige ersten Zeichen
qrencode -m2 -t ansi256utf8 "$clipboard_content"

