#!/bin/bash

BASE="/storage/emulated/0"

USER_LOGIN="slow"
USER_PASS="luccaz"

banner() {

clear

echo "======================================="
echo "        SLOW SECURITY SCANNER V1"
echo "======================================="
echo
echo "   ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
echo "   █  SLOW ANALISES PAINEL  █"
echo "   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
echo
echo "            by SlowScanner"
echo

}

login() {

while true
do

banner

read -p "Usuario: " user
read -s -p "Senha: " pass
echo

if [[ "$user" == "$USER_LOGIN" && "$pass" == "$USER_PASS" ]]; then

echo
echo "Acesso permitido..."
sleep 2
break

else

echo
echo "Login incorreto"
sleep 2

fi

done

}

scan_storage() {

banner

echo "Iniciando scan do armazenamento..."
echo

apk=0
script=0
sus=0
hidden=0

echo "======== APKs ========"

find $BASE -type f -iname "*.apk" 2>/dev/null | while read file
do
echo "[APK] $file"
((apk++))
done

echo
echo "======== SCRIPTS ========"

find $BASE -type f \( -iname "*.sh" -o -iname "*.py" -o -iname "*.lua" -o -iname "*.js" \) 2>/dev/null | while read file
do
echo "[SCRIPT] $file"
((script++))
done

echo
echo "======== SUSPEITOS ========"

find $BASE -type f \( -iname "*mod*" -o -iname "*cheat*" -o -iname "*hack*" \) 2>/dev/null | while read file
do
echo "[SUSPEITO] $file"
((sus++))
done

echo
echo "======== OCULTOS ========"

find $BASE -type f -name ".*" 2>/dev/null | while read file
do
echo "[OCULTO] $file"
((hidden++))
done

echo
echo "Scan finalizado"

read -p "ENTER para voltar"

}

apps_instalados(){

banner

echo "Apps instalados:"
echo

cmd package list packages 2>/dev/null | sed 's/package://'

echo
read -p "ENTER para voltar"

}

buscar_zips(){

clear
echo "================================="
echo "      BUSCANDO ARQUIVOS ZIP"
echo "================================="
echo

find /storage/emulated/0 -type f -iname "*.zip" 2>/dev/null

echo
echo "Busca finalizada."
echo
read -p "Pressione ENTER para voltar"

}


menu(){

while true
do

banner

echo "[1] Scan completo do storage"
echo "[2] Apps instalados"
echo "[3] Buscar arquivos baixados"
echo "[0] Sair"

echo
read -p "Escolha: " op

case $op in

1) scan_storage ;;
2) apps_instalados ;;
3) buscar_zips ;;
0) exit ;;

esac

done

}

login
menu
