#!/bin/bash

EXCLUDE_FILE="/home/dk/.config/restic/wd4tb-excludes.txt"
# Mount-Punkt und Repository-Pfad
MOUNT_POINT="/mnt/WD4TB"
BACKUP_DIR="$MOUNT_POINT/EQR6BKP"

# Prüfen, ob das Mount-Verzeichnis existiert, falls nicht erstellen
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Mount-Punkt $MOUNT_POINT existiert nicht. Erstelle Verzeichnis..."
    sudo mkdir -p "$MOUNT_POINT"
fi

# Prüfen, ob die Festplatte bereits eingehängt ist
if ! mountpoint -q "$MOUNT_POINT"; then
    echo "Festplatte ist nicht eingehängt. Versuche zu mounten..."
    
    # Annahme: Die Festplatte hat den Label "WD4TB" oder eine eindeutige UUID
    # Diese Zeile müsstest du möglicherweise anpassen, je nach deinem System und der Festplatte
    sudo mount /dev/disk/by-label/WD4TB "$MOUNT_POINT" || sudo mount -L WD4TB "$MOUNT_POINT"
    
    # Prüfen, ob das Mounten erfolgreich war
    if ! mountpoint -q "$MOUNT_POINT"; then
        echo "Fehler: Konnte die Festplatte nicht mounten. Bitte überprüfe die Verbindung und den Gerätenamen."
        exit 1
    fi
    echo "Festplatte erfolgreich eingehängt."
# else
    # echo "Festplatte ist bereits unter $MOUNT_POINT eingehängt."
fi

echo "."
# Prüfen, ob das Verzeichnis existiert
if [ -d "$BACKUP_DIR" ]; then
    echo "Backup-Verzeichnis gefunden. Starte Backup..."
    restic unlock --repo "$BACKUP_DIR" --insecure-no-password --verbose 
    restic --repo "$BACKUP_DIR" --insecure-no-password --verbose backup ~ --skip-if-unchanged --exclude-caches --exclude-file="$EXCLUDE_FILE"
    echo "."
    restic --repo "$BACKUP_DIR" --insecure-no-password --verbose backup /etc --skip-if-unchanged --exclude-caches --exclude-file="$EXCLUDE_FILE"
    echo "."
    echo "Backup abgeschlossen."
    echo "."
    restic unlock --repo "$BACKUP_DIR" --insecure-no-password --verbose 
    restic --repo "$BACKUP_DIR" --insecure-no-password --verbose forget --prune --keep-daily 12 --keep-weekly 4 --keep-monthly 6 
    echo "."
    echo "Cleanup abgeschlossen"
else
    echo "Fehler: Das Backup-Verzeichnis '$BACKUP_DIR' wurde nicht gefunden."
    exit 1
fi
