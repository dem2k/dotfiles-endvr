#!/bin/bash

# Überprüfe, ob eine Prozess-ID als Parameter übergeben wurde
if [ $# -ne 1 ]; then
    echo "Verwendung: $0 <prozess-id>"
    echo "Beispiel: $0 1234"
    exit 1
fi

PROCESS_ID=$1

# Prüfe, ob die angegebene Prozess-ID existiert
if ! ps -p $PROCESS_ID > /dev/null; then
    echo "Der Prozess mit der ID $PROCESS_ID existiert nicht."
    exit 1
fi

echo "Warte auf Beendigung des Prozesses mit ID $PROCESS_ID..."

# Warte auf den Prozess
while ps -p $PROCESS_ID > /dev/null; do
    sleep 5
done

# Funktion zum Erzeugen eines Tons
play_sound() {
    # Versuche verschiedene Methoden, einen Ton zu erzeugen
    
    # 1. Versuche mit paplay (PulseAudio)
    if command -v paplay &> /dev/null; then
        if [ -f /usr/share/sounds/freedesktop/stereo/complete.oga ]; then
            paplay /usr/share/sounds/freedesktop/stereo/complete.oga
            return
        fi
    fi
    
    # 2. Versuche mit aplay (ALSA)
    if command -v aplay &> /dev/null; then
        aplay -q /dev/null 2>/dev/null & sleep 0.1 ; kill $! 2>/dev/null
        return
    fi
    
    # 3. Versuche mit speaker-test (ALSA)
    if command -v speaker-test &> /dev/null; then
        speaker-test -t sine -f 1000 -l 1 -p 100 2>/dev/null & sleep 0.5 ; kill $! 2>/dev/null
        return
    fi
    
    # 4. Versuche mit beep (benötigt Kernel-Modul pcspkr)
    if command -v beep &> /dev/null; then
        beep
        return
    fi
    
    # Wenn keine Audio-Befehle funktionieren, wiederhole visuelle Benachrichtigung
    for i in {1..5}; do
        echo -e "\n[!] PROZESS BEENDET [!]\n"
        sleep 0.3
    done
}

# Erzeuge den Ton
play_sound

# Zeige eine Nachricht
echo "Prozess $PROCESS_ID wurde beendet! $(date)"
