#!/data/data/com.termux/files/usr/bin/bash

clear

echo "Instalando Slow Security Scanner..."

pkg update -y
pkg install figlet -y
pkg install git -y

chmod +x scanner.sh

echo ""
echo "Instalação concluída!"
echo "Execute com:"
echo "bash scanner.sh"
