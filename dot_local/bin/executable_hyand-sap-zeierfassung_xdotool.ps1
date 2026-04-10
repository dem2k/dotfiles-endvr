#!/usr/bin/pwsh

param([parameter(mandatory=$true)]$CsvFile)

function Set-FocusThisWindow {
    xdotool search --class "Alacritty" windowactivate
}

xdotool search --name "SAP Business ByDesign" windowactivate windowsize 3000 2000

# CSV-Daten einlesen
$data = Import-Csv "$CsvFile" -Delimiter ";"

# Leere Datumszellen mit dem letzten gefüllten Datum auffüllen
$currentDate = ""
$processedData = @()

foreach ($row in $data) {
    # Wenn Datum gefüllt ist, aktualisieren wir das aktuelle Datum
    if ($row.Datum -ne "" -and $row.Datum -ne $null) {
        $currentDate = $row.Datum
    }

    # Erstelle eine Kopie der Zeile und setze das Datum
    $newRow = $row.PSObject.Copy()
    $newRow.Datum = $currentDate
    $processedData += $newRow
}

# Methode 5: Ermittlung der frühesten Ein- und spätesten Aus-Zeit pro Tag
Write-Host "`n=== Früheste Ein-Zeit und späteste Aus-Zeit pro Tag ===" -ForegroundColor DarkCyan
$processedData | Group-Object -Property Datum | ForEach-Object {
    $dayInfo = $_.Group[0]
    $workEntries = $_.Group | Where-Object { $_.Ein -ne "" -and $_.Aus -ne "" }

    if ($workEntries) {
        # Konvertiere Zeitstrings zu DateTime für Vergleich
        $einZeiten = $workEntries | ForEach-Object {
            [datetime]::ParseExact($_.Ein, "HH:mm", $null)
        }
        $ausZeiten = $workEntries | ForEach-Object {
            [datetime]::ParseExact($_.Aus, "HH:mm", $null)
        }

        # Finde früheste Ein-Zeit und späteste Aus-Zeit
        $ein = ($einZeiten | Measure-Object -Minimum).Minimum.ToString("HH:mm")
        $aus = ($ausZeiten | Measure-Object -Maximum).Maximum.ToString("HH:mm")

        $_.Group | ft | out-host
        # Write-Host " --------------------------------------------------- "
        Write-Host " Arbeitszeit :      $ein - $aus"
        # Write-Host

        Set-FocusThisWindow

        $choise = Read-Host "Markiere den Tag und drücke <Enter/J> zum ausführen. (<N> zum überspringen) [J/n] "
        if($choise -eq "" -or $choise -ieq "j"){
            @"
# zeiterfass. hinzufügen klicken
search --name "SAP Business ByDesign" windowactivate sleep 0.1 mousemove --window %1 265 900   click 1 sleep 2
# arbeitspaket auswahl
search --name "SAP Business ByDesign" windowactivate sleep 0.1 mousemove --window %1 1455 630  click 1 sleep 2
# paket klicken
search --name "SAP Business ByDesign" windowactivate sleep 0.1 mousemove --window %1 1335 955  click 1 sleep 2
key  --delay 50 --repeat 4 Tab
type --delay 50 $ein
key Tab
type --delay 50 $aus
key  --delay 50 --repeat 2 Tab
type --delay 50 ZDE29
sleep 1.5
key  --delay 50 Return
sleep 1
key  --delay 50 --repeat 8 Tab
type "Ticketbearbeitung und Fehlerbehebung."
# ok button klicken
search --name "SAP Business ByDesign" windowactivate sleep 0.1 mousemove --window %1 2145 1665 click 1 sleep 2
"@ | xdotool -
        }

        # Sortiere Arbeitsblöcke nach Ein-Zeit
        $sortedWorkEntries = $workEntries | Sort-Object { [datetime]::ParseExact($_.Ein, "HH:mm", $null) }

if ($sortedWorkEntries.Count -gt 1) {
    $pausen = @()

    # Vergleiche jeden Arbeitsblock mit dem nächsten
    for ($i = 0; $i -lt $sortedWorkEntries.Count - 1; $i++) {
        $ausZeit = [datetime]::ParseExact($sortedWorkEntries[$i].Aus, "HH:mm", $null)
        $einZeit = [datetime]::ParseExact($sortedWorkEntries[$i + 1].Ein, "HH:mm", $null)

        # Wenn zwischen Aus und Ein eine Lücke ist, ist das eine Pause
        if ($einZeit -gt $ausZeit) {
            $pauseVon = $ausZeit.ToString("HH:mm")
            $pauseBis = $einZeit.ToString("HH:mm")
            $pauseDauer = ($einZeit - $ausZeit).TotalMinutes

            $pausen += [PSCustomObject]@{
                Von = $pauseVon
                Bis = $pauseBis
                Dauer = $pauseDauer
            }
        }
    }

    # Zeige Pausen an
    $pausen | ForEach-Object {
        Write-Host
        Set-FocusThisWindow
        Write-Host "       Pause :      $($_.Von) - $($_.Bis) ($($_.Dauer) Min)"
        $choise = Read-Host "Markiere den Tag und drücke <Enter/J> zum ausführen. (<N> zum überspringen) [J/n] "
        if($choise -eq "" -or $choise -ieq "j"){
            @"
# zeiterfass. hinzufügen klicken
search --name "SAP Business ByDesign" windowactivate sleep 0.1 mousemove --window %1 275 895 click 1 sleep 1
key --delay 50 --repeat 3 Tab
type --delay 50 DE0081
sleep 1
key --delay 50 Enter
key --delay 50 --repeat 2 Tab
type --delay 50 $($_.Von)
key --delay 50 Tab
type --delay 50 $($_.Bis)
# sleep 1
search --name "SAP Business ByDesign" windowactivate sleep 0.1 mousemove --window %1 2145 1665 click 1 sleep 1
"@ | xdotool -            
        }
    }
}

        Write-Host
        Set-FocusThisWindow
        $choise = Read-Host "Nächster Tag? <Enter/J> zum ausführen. (<N> zum überspringen) [J/n] "
        if($choise -eq "" -or $choise -ieq "j"){
            $countNextDay = if ($dayInfo.Tag -eq "Fr") { 3 } else { 1 }
            while($countNextDay -gt 0) {
                xdotool search --name "SAP Business ByDesign" windowactivate mousemove --window %1 1350 895 sleep 1 click 1
                $countNextDay-=1
            }
        }

        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
        Write-Host
    }
}
