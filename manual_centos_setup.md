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
sudo yum install php-cli php-fpm php-pgsql php-json php-opcache php-mbstring php-xml php-gd php-curl git
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
```
