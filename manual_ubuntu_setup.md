## Install PostgreSQL 12 

Install on c4l202

Reference: [PostgreSQL Project](https://wiki.postgresql.org/wiki/Apt)

```bash
sudo apt-get install -y curl ca-certificates gnupg
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```

Create `/etc/apt/sources.list.d/pgdg.list`. Our distribution is called bionic-pgdg using:

```bash
deb http://apt.postgresql.org/pub/repos/apt bionic-pgdg main
```

Finally, update the package lists, and start installing packages:


```bash
sudo apt-get -y update
sudo apt-get -y install postgresql-12
sudo systemctl enable postgresql
sudo systemctl start postgresql
```

## Install Solr 8.4.1

Install on c4l202

Reference: [Apache Solr](https://lucene.apache.org/solr/guide/8_4/installing-solr.html)

```bash
sudo apt-get install -y openjdk-11-jdk
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
sudo apt-get -y update
sudo apt-get -y install php7.2-cli php7.2-fpm php7.2-gd php7.2-opcache php7.2-json php7.2-xml php7.2-curl php7.2-zip php7.2-mbstring unzip git
```

Create nginx upstream repo file at `/etc/apt/sources.list.d/nginx.list` with the following content

```bash
deb http://nginx.org/packages/ubuntu/ bionic nginx
deb-src http://nginx.org/packages/ubuntu/ bionic nginx
```

```bash
sudo apt-get -y update
sudo apt-get -y install nginx
```

If a W: GPG error: http://nginx.org/packages/ubuntu xenial Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY $key is encountered during the NGINX repository update, execute the following:

```bash
export key=<error key above> # for example ABF5BD827BD9BF62 will be export key=ABF5BD827BD9BF62
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $key
sudo apt-get -y update
sudo apt-get -y install nginx
```

By default PHP FPM will run as user `www-data`. We’ll change the user to nginx. To do so open the `/etc/php/7.2/fpm/pool.d/www.conf` file and edit the lines below:

```yaml
...
user = nginx
...
listen.owner = nginx
listen.group = nginx
```

Enable the php-fpm service

```bash
sudo systemctl enable php7.2-fpm
sudo systemctl start php7.2-fpm
```

### Install Composer

Composer is a dependency manager for PHP. We will download the Drupal template and install all necessary Drupal components with composer.

The following command will install composer globally by downloading the Composer installer with curl and moving the file to the `/usr/local/bin` directory:

```bash
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
```

Install Drupal using:

```bash
sudo mkdir -p /var/www/html/my_drupal
sudo chown -R vagrant:vagrant /var/www/html/my_drupal
/usr/local/bin/composer create-project drupal-composer/drupal-project:8.x-dev /var/www/html/my_drupal --no-interaction
```
