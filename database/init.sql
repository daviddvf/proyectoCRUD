CREATE DATABASE IF NOT EXISTS proyectolempro CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON proyectolempro.* TO 'user'@'%';
FLUSH PRIVILEGES;
