#!/bin/bash

#Atualizar o sistema
echo "Atualizar o sistema"
sudo dnf update -y

#Instalar o Serviço FTP
echo "Instalação do Servidor FTP"
sudo yum install vsftpd -y

#Iniciar e Ativar o Serviço
echo "Iniciar o Serviço"
sudo systemctl enable vsftpd
sudo systemctl start vsftpd

#Verificar o Status
echo "Mostra o servidor ftp se esta ativo"
sudo systemctl status vsftpd

#Abrir as portas 20 na firewall
echo "Adiciona o serviço à firewall e abre as portas"
sudo firewall-cmd --permanent --add-service=ftp
sudo firewall-cmd --permanent --add-port=20/tcp
sudo firewall-cmd --permanent --add-port=21/tcp
sudo firewall-cmd --permanent --add-port=40000-50000/tcp
sudo firewall-cmd --reload
sudo systemctl restart vsftpd
sudo firewall-cmd --list-ports

#Editar o vsftpd.conf
echo "Abre o ficheiro principal da configuração"
cat >> /etc/vsftpd/vsftpd.conf <<END

listen=YES
listen_ipv6=NO
pam_service_name=vsftpd
userlist_enable=YES
listen_port=20
ftp_data_port=20
pasv_enable=YES
pasv_min_port=40000
pasv_max_port=50000
write_enable=YES
END

#Reinicia o Serviço
echo "Recarrega as configurações editadas"
sudo systemctl restart vsftpd
