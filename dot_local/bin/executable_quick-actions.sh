#!/bin/bash

# Dateiname aus Parameter
dateipfad="$1"
dateiname=$(basename "$dateipfad")

# Prüfen, ob ein Parameter übergeben wurde
if [ -z "$dateipfad" ]; then
  echo "Bitte einen Dateinamen angeben."
  exit 1
fi

# Funktion zum Prüfen, ob das Verzeichnis ".git" existiert
check_git_repo() {
  local dir="$1"
  while [ "$dir" != "/" ]; do
    if [ -d "$dir/.git" ]; then
      return 0  # .git gefunden
    fi
    dir=$(dirname "$dir")  # Wechsle zum übergeordneten Verzeichnis
  done
  return 1  # .git nicht gefunden
}

# Variable für die Warten auf Tasteneingabe
WAIT_FOR_KEY="echo ''; echo ''; read -p 'Drücke eine Taste zum Schließen...'"

# Überprüfungen und Aktionen
if [[ "$dateiname" == *.xxx ]]; then
  xterm -e bash -c "unzip \"$dateipfad\"; $WAIT_FOR_KEY"
  
elif [[ "$dateiname" == *g21c5w* ]]; then
  xterm -e bash -c "g21viewer \"$dateipfad\"; $WAIT_FOR_KEY"
  
elif check_git_repo "$dateipfad"; then
  alacritty -e bash -c "lazygit; echo 'Beende LazyGit...'; sleep 1"
  
else
  xterm -e bash -c "echo \"Keine Aktion für Datei definiert: $dateiname\"; $WAIT_FOR_KEY"
fi
