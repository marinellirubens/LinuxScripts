sudo apt-get update
sudo apt-get install -y apache2
sudo apt-get install -y curl
sudo apt-get install -y mysql-server php5-mysql mysql-client
sudo apt-get install -y php5 libapache2-mod-php5 php5-mcrypt
sudo nano /etc/apache2/mods-enabled/dir.conf
sudo apt-get install phpmyadmin
sudo cp -r /usr/share/phpmyadmin/ /var/www/html/phpmyadmin
sudo chmod 777 -R  /var/www/html
sudo systemctl restart apache2


