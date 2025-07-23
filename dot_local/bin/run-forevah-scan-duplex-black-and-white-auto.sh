
wait_time=5
max_wait_time=60

while true; do
# ---------------------
cd ~/scanner
rm ~/scanner/*.tiff 2>/dev/null
rm ~/scanner/*.pdf  2>/dev/null

scanimage --batch=page%03d.tiff --progress --format=tiff -x 210 -y 297 \
          --source="Automatic Document Feeder(center aligned,Duplex)" \
          --mode="Black & White" --resolution="300" --AutoDocumentSize="yes" --AutoDeskew="yes" && wait_time=5

img2pdf page*.tiff -o Scan_$(date +%Y-%m-%d_%H%M%S).pdf 2>/dev/null

mv ~/scanner/*.pdf /opt/paperless/consume 2>/dev/null

wait_time=$((wait_time + 5))
if [ "$wait_time" -gt "$max_wait_time" ]; then
   wait_time=$max_wait_time
fi

echo "."
echo "$(date +%T): Warte $wait_time Sekunden bis zum nächsten Versuch..."
echo "."

sleep "$wait_time"
# ----------------------
done
