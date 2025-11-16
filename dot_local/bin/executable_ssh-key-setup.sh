#!/bin/bash

# Standardwerte setzen
USER=""
HOST=""

# Funktion zur Anzeige der Hilfe
show_help() {
    echo "Verwendung: $0 -u user -h host"
    echo "  -u user    Benutzername auf dem Zielserver"
    echo "  -h host    Hostname oder IP-Adresse des Zielservers"
    echo "  -?         Diese Hilfe anzeigen"
    exit 1
}

# Parameter verarbeiten
while getopts "u:h:?" opt; do
    case $opt in
        u)
            USER="$OPTARG"
            ;;
        h)
            HOST="$OPTARG"
            ;;
        ?)
            show_help
            ;;
        \?)
            echo "Ungültige Option: -$OPTARG" >&2
            show_help
            ;;
    esac
done

# Überprüfen, ob beide Parameter angegeben wurden
if [ -z "$USER" ] || [ -z "$HOST" ]; then
    echo "Fehler: Benutzername und Hostname müssen angegeben werden."
    show_help
fi

# HOST bereinigen: Sonderzeichen durch Unterstriche ersetzen
#HOST_CLEAN=$(echo "$HOST" | tr -c '[:alnum:]' '_' | sed 's/_$//')
HOST_CLEAN="${HOST//[^a-zA-Z0-9]/_}"

# SSH-Key-Dateiname mit Benutzer und Host
KEY_NAME="id_ed25519_${USER}_${HOST_CLEAN}"
KEY_PATH="$HOME/.ssh/$KEY_NAME"

# Überprüfen, ob der Schlüssel bereits existiert
if [ -f "$KEY_PATH" ]; then
    echo "Ein SSH-Schlüssel für $USER@$HOST existiert bereits unter $KEY_PATH."
    read -p "Möchtest du einen neuen Schlüssel erstellen? (j/n): " ANSWER
    if [ "$ANSWER" != "j" ]; then
        echo "Abbruch. Bestehender Schlüssel wird verwendet."
        PUB_KEY="$KEY_PATH.pub"
    fi
fi

# Neuen SSH-Schlüssel erstellen, wenn keiner existiert oder ersetzt werden soll
if [ -z "$PUB_KEY" ]; then
    echo "Erstelle neuen Ed25519 SSH-Schlüssel ohne Passwort für $USER@$HOST..."
    mkdir -p "$HOME/.ssh"
    ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" -C "$(whoami)@$(hostname)"
    
    if [ $? -ne 0 ]; then
        echo "Fehler bei der Erstellung des SSH-Schlüssels."
        exit 1
    fi
    
    PUB_KEY="$KEY_PATH.pub"
    echo "SSH-Schlüssel wurde erstellt: $KEY_PATH"
fi

# Öffentlichen Schlüssel auf den Server kopieren
echo "Kopiere den öffentlichen Schlüssel auf $USER@$HOST..."
echo "Du wirst nach dem Passwort für den Benutzer $USER auf $HOST gefragt."

if ! ssh-copy-id -i "$PUB_KEY" "$USER@$HOST"; then
    echo "Fehler beim Kopieren des öffentlichen Schlüssels."
    echo "Stattdessen versuche ich, den Schlüssel manuell zu kopieren..."
    
    # Manuelles Kopieren des Schlüssels als Fallback
    SSH_DIR=".ssh"
    AUTH_KEYS="authorized_keys"
    
    # Erstelle .ssh Verzeichnis falls nicht vorhanden und setze Berechtigungen
    ssh "$USER@$HOST" "mkdir -p $SSH_DIR && chmod 700 $SSH_DIR"
    
    # Kopiere den Schlüssel
    cat "$PUB_KEY" | ssh "$USER@$HOST" "cat >> $SSH_DIR/$AUTH_KEYS && chmod 600 $SSH_DIR/$AUTH_KEYS"
    
    if [ $? -ne 0 ]; then
        echo "Fehler beim manuellen Kopieren des Schlüssels."
        exit 1
    fi
fi

echo "SSH-Schlüssel wurde erfolgreich auf $USER@$HOST kopiert."

# Automatisch Eintrag in SSH-Config erstellen
CONFIG_FILE="$HOME/.ssh/config"
HOST_ALIAS="${USER}_${HOST_CLEAN}"

echo "Füge SSH-Konfiguration automatisch hinzu..."
# Überprüfen, ob die Config-Datei existiert, und gegebenenfalls erstellen
touch "$CONFIG_FILE"
chmod 600 "$CONFIG_FILE"

# Überprüfen, ob bereits ein Eintrag für diesen Host existiert
if grep -q "Host $HOST_ALIAS" "$CONFIG_FILE"; then
    echo "Es existiert bereits ein Eintrag für $HOST_ALIAS in der SSH-Konfigurationsdatei."
else
    echo -e "\nHost $HOST\n  HostName $HOST\n  User $USER\n  IdentityFile $KEY_PATH\n  IdentitiesOnly yes" >> "$CONFIG_FILE"
    echo "Konfiguration wurde hinzugefügt."
fi

echo "Du kannst dich jetzt ohne Passwort verbinden mit:"
echo "ssh $HOST"
echo "oder"
echo "ssh -i $KEY_PATH $USER@$HOST"

echo "Fertig!"
