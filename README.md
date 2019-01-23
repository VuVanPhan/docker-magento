# Install Magento with Nginx

### Config Host - user vitual host
```sh
127.0.0.1   m2.io
Or echo "127.0.0.1 m2.io | tee -a /etc/hosts"
# LAN_IP    m2.io
# Example : 192.168.120.45 m2.io
```

## 1 - Install Magento
```sh
1 - Open the terminal on the Nginx directory
2 - Go to the directory "Nginx...-PHP...-Mariadb10.1.26/magento/"
# Example : $ cd Nginx1.13-PHP7.1-Mariadb10.1.26/magento/
3 - Create folder "source" and up code Magento to here
4 - Return to the directory contain the docker-composer.yml - the directory "Nginx...-PHP...-Mariadb10.1.26"
# Example : Here, is the directory "Nginx1.13-PHP7.1-Mariadb10.1.26"
# $ cd ../
5 - Run "docker-compose up"

# Note : you can edit port services in the two file :
# - Nginx...-PHP...-Mariadb10.1.26/docker-composer.yml
# - Nginx...-PHP...-Mariadb10.1.26/nginx/default.php.conf
# Example :
# - Nginx1.13-PHP7.1-Mariadb10.1.26/docker-composer.yml
# - Nginx1.13-PHP7.1-Mariadb10.1.26/nginx/default.php.conf
```

```sh
# Information Service
- phpMyAdmin : http://m2.io:8080/
- email      : http://m2.io:8025
```

## 2 - Create Database
```sh
1 - Go to phpMyAdmin : http://m2.io:8080
2 - Create database
# Example : nginx113php71_magentoce226
```

## 3 - Install Magento
```sh
# Access to SSH to run
# $ docker exec -u www-data -it {container_name} bash
# $ docker exec -u www-data -it {container_id} bash
$ docker exec -u www-data -it nginx113-php71-mariadb10126_fpm11371_1 bash
$ cd source
# $ ../install_magento DATABASE_NAME URL
$ ../install_magento nginx113php71_magentoce226 http://m2.io:8710/
```

```sh
# Now, you can access the website
# Frontend URL
#- Nginx 1.13|1.14 PHP 7.0 : http://m2.io:8700/
- Nginx 1.13|1.14 PHP 7.1 : http://m2.io:8710/

# Admin URL
#- Nginx 1.13|1.14 PHP 7.0 : http://m2.io:8700/admin
- Nginx 1.13|1.14 PHP 7.1 : http://m2.io:8710/admin
- User/Pass : admin/admin123
```

## SSH To Container
```sh
# $ docker exec -u www-data -it {container_name} bash
# $ docker exec -u www-data -it {container_id} bash
$ docker exec -u www-data -it nginx113-php71-mariadb10126_fpm11371_1 /bash
```
