echo "Instalando NodeJs"
sudo apt-get install -y nodejs
echo "Instalando Nginx"
sudo apt-get install -y nginx

echo "Configurando senha Mysql"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password linux'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password linux'
echo "Instalando Mysql"
sudo apt-get -y install mariadb-server
sudo apt-get install -y mariadb-client

echo "Configurando Mysql" 
mysql -u root -plinux -e "create database teste;"
mysql -D teste -u root -plinux << EOF
use mysql;
UPDATE user SET plugin='mysql_native_password' WHERE User='root';
FLUSH PRIVILEGES;
exit;
create table teste(linha varchar(1000));
EOF
service mysql restart

echo "Instalando Mysql Workbench"
sudo apt-get -y install mysql-workbench
echo "Instalando npm"
sudo apt-get install -y npm


#pagina inicial                        /var/www/html/index.nginx-debian.html
#arquivo de configuração do diretorio  /etc/nginx/sites-enabled/default
