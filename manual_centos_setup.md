## Install PostgreSQL 12 

Install on c4l202

Reference: [PostgreSQL Project](https://www.postgresql.org/download/linux/redhat/)

```bash
sudo yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install postgresql12-server
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl enable postgresql-12
sudo systemctl start postgresql-12
```

## Install Solr 8.4.1

Install on c4l202

Reference: [Apache Solr](https://lucene.apache.org/solr/guide/8_4/installing-solr.html)

```bash
sudo yum -y install java-11-openjdk
cd /tmp
wget http://apache.org/dist/lucene/solr/8.4.1/solr-8.4.1.tgz
tar xzf solr-8.4.1.tgz solr-8.4.1/bin/install_solr_service.sh --strip-components=2
sudo bash ./install_solr_service.sh solr-8.4.1.tgz
sudo service solr start
```

## Install Drupal 8

Install on c4l203 and c4l204

Reference: [Drupal Install Documentation](https://www.drupal.org/docs/8/install)

### PHP and Webserver

```bash
sudo yum install epel-release yum-utils
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi-php72
sudo yum update
sudo yum install php-cli php-fpm php-pgsql php-json php-opcache php-mbstring php-xml php-gd php-curl php-zip git unzip
```

To add NGINX yum repository, create a file named `/etc/yum.repos.d/nginx.repo` and paste this configuration below:

```yaml
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
```

Then run the following:

```bash
sudo yum update
sudo yum install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
```

By default PHP FPM will run as user apache on port 9000. We’ll change the user to nginx and switch from TCP socket to Unix socket. To do so open the `/etc/php-fpm.d/www.conf` file and edit the lines below:

```yaml
...
user = nginx
...
listen = /run/php-fpm/www.sock
...
listen.owner = nginx
listen.group = nginx
```

Make sure the `/var/lib/php` directory has the following ownership:

```bash
sudo chown -R root:nginx /var/lib/php
```

Enable the php-fpm service

```bash
sudo systemctl enable php-fpm
sudo systemctl start php-fpm
```

### Install Composer

Composer is a dependency manager for PHP. We will download the Drupal template and install all necessary Drupal components with composer.

The following command will install composer globally by downloading the Composer installer with curl and moving the file to the `/usr/local/bin` directory:

```bash
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
```

Edit `/etc/php/php.ini`

```ini
memory_limit = 2G
```

Install Drupal using:

```bash
sudo mkdir -p /var/www/html/my_drupal
sudo chown -R vagrant:vagrant /var/www/html/my_drupal
/usr/local/bin/composer create-project drupal-composer/drupal-project:8.x-dev /var/www/my_drupal --no-interaction
```
