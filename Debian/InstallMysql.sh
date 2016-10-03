sudo apt-get install -y nodejs
sudo apt-get install -y nginx

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password linux'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password linux'
sudo apt-get -y install mysql-server
sudo apt-get install -y mysql-client 
mysql -u root -plinux -e "create database teste;"
mysql -D teste -u root -plinux << EOF
create table teste(linha varchar(1000));
EOF
sudo apt-get -y install mysql-workbench
sudo apt-get install -y npm


#pagina inicial                        /var/www/html/index.nginx-debian.html
#arquivo de configuração do diretorio  /etc/nginx/sites-enabled/default
