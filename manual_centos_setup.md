## Install PostgreSQL 12 

Install on c4l20node1

Reference: [PostgreSQL Project](https://www.postgresql.org/download/linux/redhat/)

```bash
sudo yum install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install postgresql12-server
sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
sudo systemctl enable postgresql-12
sudo systemctl start postgresql-12
```

## Install Solr 8.4.1

Install on c4l20node1

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

Install on c4l20node2 and c4l20node3

Reference: [Drupal Install Documentation](https://www.drupal.org/docs/8/install)

### PHP and Webserver

```bash
sudo yum install -y epel-release yum-utils
sudo yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi-php72
sudo yum update
sudo yum install -y php-cli php-fpm php-pgsql php-json php-opcache php-mbstring php-xml php-gd php-curl php-zip git unzip zip
```

To add NGINX yum repository, create a file named `/etc/yum.repos.d/nginx.repo` and paste this configuration below:

```ini
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
```

Then run the following:

```bash
sudo yum update
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
```

By default PHP FPM will run as user apache on port 9000. We’ll change the user to nginx and switch from TCP socket to Unix socket. To do so open the `/etc/php-fpm.d/www.conf` file and edit the lines below:

```ini
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

### Download and install Drupal

```bash
cd /tmp
wget https://ftp.drupal.org/files/projects/drupal-8.8.2.tar.gz
tar xzvf drupal-8.8.2.tar.gz
sudo mv drupal-8.8.2/* /usr/share/nginx/html/
```

## Install HaProxy

Install on c4l20node4 (or c4l20node3)

```bash
yum install epel-release -y
yum install haproxy -y
```

## Install Netdata

Install on all VMs

```bash
sudo yum -y install epel-release pygpgme yum-utils
```

Create a file named `/etc/yum.repos.d/netdata_netdata.repo` that contains the repository configuration below:

```ini
[netdata_netdata]
name=netdata_netdata
baseurl=https://packagecloud.io/netdata/netdata/el/7/$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/netdata/netdata/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[netdata_netdata-source]
name=netdata_netdata-source
baseurl=https://packagecloud.io/netdata/netdata/el/7/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/netdata/netdata/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
```

Update the local yum cache and install netdata by running:

```bash
sudo yum -q makecache -y --disablerepo='*' --enablerepo='netdata_netdata'
sudo yum -y install netdata
```


The following steps install the basic software and depending on time in the class we will [configure the software](manual_centos_configure.md) to work together. The whole point of the workshop is to automate the aforementioned steps and be sure you will get the same results every time. If you are ahead of the rest of the class do go ahead and configure the software
