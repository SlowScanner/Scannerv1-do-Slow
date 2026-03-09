#!/system/bin/sh

# Slow Security Scanner
# Adaptado para APK com botões

REPORT_DIR="/storage/emulated/0/SlowScanner"

mkdir -p $REPORT_DIR

scan_storage() {

echo "Escaneando armazenamento..."

find /storage/emulated/0 -type f > $REPORT_DIR/scan_files.txt 2>/dev/null

echo "Scan completo"
echo "Arquivo salvo em $REPORT_DIR/scan_files.txt"

}

hidden_files() {

echo "Detectando arquivos ocultos..."

find /storage/emulated/0 -type f -name ".*" > $REPORT_DIR/hidden_files.txt 2>/dev/null

echo "Scan completo"
echo "Arquivo salvo em $REPORT_DIR/hidden_files.txt"

}

apks() {

echo "Procurando APKs..."

find /storage/emulated/0 -type f -name "*.apk" > $REPORT_DIR/apk_list.txt 2>/dev/null

echo "Lista de APKs salva em $REPORT_DIR/apk_list.txt"

}

installed_apps() {

echo "Listando aplicativos instalados..."

pm list packages > $REPORT_DIR/installed_apps.txt

echo "Lista salva em $REPORT_DIR/installed_apps.txt"

}

suspicious_scripts() {

echo "Procurando scripts suspeitos..."

find /storage/emulated/0 -type f \( -name "*.sh" -o -name "*.py" -o -name "*.js" \) > $REPORT_DIR/scripts.txt 2>/dev/null

echo "Lista salva em $REPORT_DIR/scripts.txt"

}

generate_report() {

echo "Gerando relatório..."

cat $REPORT_DIR/*.txt > $REPORT_DIR/report.txt

echo "Relatório salvo em $REPORT_DIR/report.txt"

}

case "$1" in

scan)
scan_storage
;;

hidden)
hidden_files
;;

apks)
apks
;;

apps)
installed_apps
;;

scripts)
suspicious_scripts
;;

report)
generate_report
;;

*)
echo "Slow Security Scanner"
echo ""
echo "Comandos disponíveis:"
echo "scan"
echo "hidden"
echo "apks"
echo "apps"
echo "scripts"
echo "report"
;;

esac
