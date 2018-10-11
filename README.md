# docker-magento

## Config Host
```
127.0.0.1   m2.io
# LAN_IP    m2.io
```

## Base Services
```sh
docker-compose up
```

- phpMyAdmin: http://m2.io:8080/
- email: http://m2.io:8025/

## Multiple Services
```sh
bin/init
docker-compose -f docker-compose.yml \
    -f docker-compose.apache.php56.yml \
    -f docker-compose.apache.php70.yml \
    -f docker-compose.apache.php71.yml \
    -f docker-compose.nginx.php56.yml \
    -f docker-compose.nginx.php70.yml \
    -f docker-compose.nginx.php71.yml \
    up
```

- Apache PHP 5.6: http://m2.io:8056/
- Apache PHP 7.0: http://m2.io:8070/
- Apache PHP 7.1: http://m2.io:8071/

- Nginx PHP 5.6 - CE 2.1.13: http://m2.io:8560/
- Nginx PHP 5.6 - EE 2.1.15: http://m2.io:8561/
- Nginx PHP 7.0 - CE 2.1.13: http://m2.io:8700/
- Nginx PHP 7.0 - EE 2.1.15: http://m2.io:8701/
- Nginx PHP 7.1 - CE 2.2.6: http://m2.io:8710/
- Nginx PHP 7.1 - EE 2.2.6: http://m2.io:8711/

## SSH To Container
```sh
docker exec -u www-data -it {container_name} /bin/bash
# Example: docker exec -u www-data -it docker-magento_apache70_1 /bin/bash
# Example: docker exec -u www-data -it docker-magento_fpm70_1 /bin/bash
```

## Install Magento
```sh
# Access to SSH to run
# docker exec -u www-data -it docker-magento_apache56_1 /bin/bash
# docker exec -u www-data -it docker-magento_fpm56_1 /bin/bash
cd Magento-CE-2.1.13
../install_magento DATABASE_NAME URL
# ../install_magento apache56_magentoce2113 "http://m2.io:8056/$(basename $PWD)/"
# ../install_magento nginx56_magentoce2113 http://m2.io:8560/
```

- Admin URL: http://m2.io:8056/Magento-CE-2.1.13/admin
- User/Pass: admin/admin123
