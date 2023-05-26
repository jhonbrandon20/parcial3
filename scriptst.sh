#Update
echo "Instalar parametros de configuracion"
sudo yum update
sudo yum install wget -y
sudo yum install vim -y
sudo yum install net-tools -y
sudo yum install httpd -y
#----------------------------------------------------------------------------------------------------------------------#
echo "Instalacion java y streama"
wget --no-cookies --no-check-certificate --header "Cookie:oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"
yum -y localinstall jdk-8u131-linux-x64.rpm
wget https://github.com/dularion/streama/releases/download/v1.1/streama-1.1.war
#----------------------------------------------------------------------------------------------------------------------#
echo "configuracion streama"
sudo mkdir /opt/streama
sudo mv streama-1.1.war /opt/streama/streama.war
sudo mkdir /opt/streama/media
sudo chmod 664 /opt/streama/media
sudo touch /etc/systemd/system/streama.service
#----------------------------------------------------------------------------------------------------------------------#
echo "streama en segundo plano"
cat <<TEST> /etc/systemd/system/streama.service
[Unit]
Description=Streama Server
After=syslog.target
After=network.target

[Service]
User=root
Type=simple
ExecStart=/bin/java -jar /opt/streama/streama.war
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=Streama

[Install]
WantedBy=multi-user.target
TEST
#----------------------------------------------------------------------------------------------------------------------#
echo "modificar SELinux para que empiece deshabilitado"
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
#----------------------------------------------------------------------------------------------------------------------#
echo "configuracion firewall"
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --reload
#----------------------------------------------------------------------------------------------------------------------#
echo "reiniciar y habilitar servicios de streama y httpd"
sudo systemctl start streama
sudo systemctl enable streama
sudo systemctl start  httpd
sudo systemctl enable httpd
