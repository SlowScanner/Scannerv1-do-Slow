#!/bin/bash

mkdir -p relatorios

RELATORIO="relatorios/scan_$(date +%H-%M-%S).txt"

# Detectar caminho do storage automaticamente
if [ -d "/storage/emulated/0" ]; then
BASE="/storage/emulated/0"
elif [ -d "$HOME/storage/shared" ]; then
BASE="$HOME/storage/shared"
else
echo "ERRO: armazenamento não encontrado."
echo "Execute: termux-setup-storage"
exit
fi

banner(){
clear
echo "======================================="
echo "      SLOW SECURITY SCANNER V5"
echo "======================================="
echo "Storage detectado: $BASE"
echo
}

scan_storage(){

banner
echo "Iniciando scan profundo..."
echo

apk=0
script=0
sus=0
hidden=0
zipf=0

echo "========== APKs =========="

find "$BASE" -type f -iname "*.apk" 2>/dev/null | while read file
do
echo "[APK] $file"
echo "[APK] $file" >> $RELATORIO
((apk++))
done

echo
echo "========== SCRIPTS =========="

find "$BASE" -type f \( -iname "*.sh" -o -iname "*.py" -o -iname "*.lua" -o -iname "*.js" \) 2>/dev/null | while read file
do
echo "[SCRIPT] $file"
echo "[SCRIPT] $file" >> $RELATORIO
((script++))
done

echo
echo "========== SUSPEITOS =========="

find "$BASE" -type f \( -iname "*mod*" -o -iname "*cheat*" -o -iname "*hack*" -o -iname "*inject*" \) 2>/dev/null | while read file
do
echo "[SUSPEITO] $file"
echo "[SUSPEITO] $file" >> $RELATORIO
((sus++))
done

echo
echo "========== OCULTOS =========="

find "$BASE" -type f -name ".*" 2>/dev/null | while read file
do
echo "[OCULTO] $file"
echo "[OCULTO] $file" >> $RELATORIO
((hidden++))
done

echo
echo "========== COMPRIMIDOS =========="

find "$BASE" -type f \( -iname "*.zip" -o -iname "*.rar" -o -iname "*.7z" \) 2>/dev/null | while read file
do
echo "[ZIP] $file"
echo "[ZIP] $file" >> $RELATORIO
((zipf++))
done

echo
echo "================================="
echo "SCAN FINALIZADO"
echo "Relatório salvo em: $RELATORIO"
echo

read -p "Pressione ENTER para voltar"
}

apps_instalados(){

banner
echo "Apps instalados no sistema:"
echo

pm list packages

echo
read -p "ENTER para voltar"
}

menu(){

while true
do

banner

echo "[1] Scan completo do storage"
echo "[2] Apps instalados"
echo "[0] Sair"

echo
read -p "Escolha: " op

case $op in

1) scan_storage ;;
2) apps_instalados ;;
0) exit ;;

esac

done

}

menu
