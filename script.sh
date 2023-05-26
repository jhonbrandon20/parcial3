#Update
echo "Instalar parametros de configuracion"
sudo yum update
sudo yum install wget -y
sudo yum install vim -y
sudo yum install net-tools -y
sudo yum install httpd -y
#----------------------------------------------------------------------------------------------------------------------#
echo "modificar SELinux para que empiece deshabilitado"
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
#----------------------------------------------------------------------------------------------------------------------#
echo "configuracion firewall para redireccionamiento IP publica streama"
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --zone=public --add-forward-port=port=80:proto=tcp:toaddr=192.168.67.49:toport=8080 --permanent
sudo firewall-cmd --zone=public --add-interface=eth2 --permanent
sudo firewall-cmd --zone=public --add-masquerade --permanent
sudo firewall-cmd --zone=public --add-masquerade --permanent
sudo firewall-cmd --reload
#----------------------------------------------------------------------------------------------------------------------#
echo "reiniciar y habilitar servicios de httpd y firewalld"
sudo systemctl start  httpd
sudo systemctl enable httpd
sudo systemctl start firewalld
sudo systemctl enable firewalld




