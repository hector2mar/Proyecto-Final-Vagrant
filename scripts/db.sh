#!/bin/bash
apt-get install -y mysql-server
# Permitir conexiones remotas
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql

# Crear DB, usuario y tabla
mysql -u root <<EOF
CREATE DATABASE proyecto;
CREATE USER 'admin'@'%' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON proyecto.* TO 'admin'@'%';
USE proyecto;
CREATE TABLE visitas (id INT AUTO_INCREMENT PRIMARY KEY, fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP, servidor VARCHAR(50));
INSERT INTO visitas (servidor) VALUES ('Inicialización');
EOF