#!/usr/bin/env bash
#echo "Welcome to the magento 2 automation environment building program with docker tool"
## define build environment magento 2
#echo -n "Enter Nginx version : "
#read nginxversion
#
#echo -n "Enter PHP version : "
#read phpversion
#
#echo -n "Enter MariaDB version : "
#read mariadbversion

nginxversion=1.14
phpversion=7.1
mariadbversion=10.1.26


instance="Nginx"${nginxversion}"-PHP"${phpversion}"-Mariadb"${mariadbversion}

# source environment
source ./$instance/env

# create source magento 2
echo "Delete "$PWD"/"$instance"/magento/source" $PWD"/"$instance"/data"
rm -rf $PWD"/"$instance"/magento/source" $PWD"/"$instance"/data"
mkdir -p $PWD"/"$instance"/magento/source"
cd $PWD"/"$instance"/magento/source"
chmod -R 777 ./
wget https://github.com/magento/magento2/archive/2.2.6.tar.gz
wget https://github.com/magento/magento2-sample-data/archive/2.2.6.tar.gz
tar -xzvf 2.2.6.tar.gz
tar -xzvf 2.2.6.tar.gz.1
mv -v magento2-2.2.6/* ./
mv -v magento2-2.2.6/.* ./
cp -avr magento2-sample-data-2.2.6/* ./
rm -rf magento2-2.2.6/ magento2-sample-data-2.2.6/ 2.2.6.tar.gz 2.2.6.tar.gz.1

# Change or modify the directory permission to fit Apache2 configuration.
find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chown -R ubuntu:www-data .
chmod u+x bin/magento

# Install PHP Composer
apt-get install -y composer

# Install Magento components using the PHP composer. Ignore platform request when not compatible with PHP
composer install --ignore-platform-reqs

# docker compose
docker-compose up -d

# install magento with
containerphpfpm=$(echo "${instance//.}" | tr '[:upper:]' '[:lower:]')"_fpm"$(echo "${nginxversion//.}" | tr '[:upper:]' '[:lower:]')$(echo "${phpversion//.}" | tr '[:upper:]' '[:lower:]')"_1"
containermysql=$(echo "${instance//.}" | tr '[:upper:]' '[:lower:]')"_db_1"

# create databases
# until container mysql status do not == healthy then sleep
until [ $(docker inspect -f '{{.State.Health.Status}}' "$containermysql") == "healthy" ]; do
    sleep 1;
done

# when the DB
docker exec -u www-data -it $containermysql sh -c "echo 'create database "$PMA_DB";' | mysql -u"$PMA_USER" -p"$PMA_PASSWORD"";
echo "Database "$PMA_DB" is created on DB "$containermysql"";

# install magento site with command line
if [ $(docker inspect -f '{{.State.Running}}' "$containerphpfpm") == "true" ]; then
        docker exec -u www-data -it $containerphpfpm /var/www/html/install_magento $PMA_DB http://192.168.120.75:8710/
    else
        echo "Container '$containerphpfpm' is not running, you are need start service now"
fi