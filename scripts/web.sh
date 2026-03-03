#!/bin/bash
apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mysql

# 1. Copiamos el archivo PHP
cp /vagrant/config-files/index.php /var/www/html/index.php

# 2. BORRAMOS el archivo por defecto de Apache (¡Ojo al nombre!)
rm -f /var/www/html/index.html

# 3. Reiniciamos para aplicar cambios
systemctl restart apache2