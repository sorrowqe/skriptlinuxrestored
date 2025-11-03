#!/bin/bash
# Kontrollime, kas vajalikud teenused on paigaldatud
for pkg in apache2 php mysql-server git wget tar; do
  if ! dpkg -l | grep -q $pkg; then
    echo "$pkg puudub — paigaldan..."
    sudo apt install -y $pkg
  fi
done

# Apache ja MySQL käivitamine
systemctl enable apache2
systemctl start apache2
systemctl enable mysql
systemctl start mysql

# Andmebaasi loomine
mysql -u root -p'qwerty' <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'qwerty';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# WordPressi allalaadimine ja seadistamine
cd /var/www/html/
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php

# Muudame wp-config.php andmebaasi seaded
sed -i "s/database_name_here/wordpress/g" wordpress/wp-config.php
sed -i "s/username_here/wpuser/g" wordpress/wp-config.php
sed -i "s/password_here/qwerty/g" wordpress/wp-config.php

# Õiguste seadistamine
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

echo "WordPress on paigaldatud! Ava oma brauseris: http://localhost/wordpress"
