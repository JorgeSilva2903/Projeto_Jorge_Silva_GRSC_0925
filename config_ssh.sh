#!/bin/bash

set -e

#Mudar de Diretoria
cd /etc/ssh

#Copiar o Ficheiro de configuração
sudo cp /etc/ssh/sshd_config "$HOME/sshd_config_backup"

#Editar o ficheiro
sudo sed -i '21s/^\s*#\s*//' "sshd_config"
sudo sed -i '40s/^\s*#\s*//' "sshd_config"
sudo sed -i '42s/^\s*#\s*//' "sshd_config"
sudo sed -i '43s/^\s*#\s*//' "sshd_config"
sudo sed -i '45s/^\s*#\s*//' "sshd_config"
sudo sed -i '65s/^\s*#\s*//' "sshd_config"
sudo sed -i '66s/^\s*#\s*//' "sshd_config"

#Reiniciar o sistema
echo "A reiniciar o sistema"
sudo systemctl restart sshd
sudo systemctl status sshd

#Permissoes de leitura e escrita
sudo chmod 664 sshd_config

#Criação da chave RSA
mkdir -p "$HOME/.ssh"
ssh-keygen -t rsa -f "$HOME/.ssh/id_rsa"
cat "$HOME/.ssh/id_rsa.pub" >> "$HOME/.ssh/authorized_keys"

#Reiniciar de novo o sistema
sudo systemctl restart sshd
