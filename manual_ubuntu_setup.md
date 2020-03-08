## Login to vagrant sandbox instances

```bash
vagrant status
vagrant ssh root@<machine_name>
```


## Install PostgreSQL 12 

Install on c4l20node1

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

Install on c4l20node1

Reference: [Apache Solr](https://lucene.apache.org/solr/guide/8_4/installing-solr.html)

```bash
sudo apt-get install -y openjdk-11-jdk
cd /tmp
wget http://apache.org/dist/lucene/solr/8.4.1/solr-8.4.1.tgz
tar xzf solr-8.4.1.tgz solr-8.4.1/bin/install_solr_service.sh --strip-components=2
sudo bash ./install_solr_service.sh solr-8.4.1.tgz
sudo service solr start
```

### Troubleshooting

Should one encounter `Hash mismatch` errors when attempting to invoke `apt-get install -y openjdk-11-jdk`, please refer to [the `apt` troubleshooting guide](APT_TROUBLESHOOTING_UBUNTU.md).

## Install Drupal

Install on c4l20node2 and c4l20node3

Reference: [Drupal Install Documentation](https://www.drupal.org/docs/8/install)

### PHP and Webserver

```bash
sudo apt-get -y update
sudo apt-get -y install php7.2-cli php7.2-fpm php7.2-gd php7.2-opcache php7.2-pgsql php7.2-json php7.2-xml php7.2-curl php7.2-zip php7.2-mbstring unzip git zip
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

By default PHP FPM will run as user `www-data`. We’ll change the user to `nginx`. To do so open the `/etc/php/7.2/fpm/pool.d/www.conf` file and edit the lines below:

```ini
...
user = nginx
group = nginx
...
listen.owner = nginx
listen.group = nginx
```

Enable the php-fpm service

```bash
sudo systemctl enable php7.2-fpm
sudo systemctl start php7.2-fpm
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
sudo add-apt-repository ppa:vbernat/haproxy-1.8
sudo apt-get -y update
sudo apt-get -y install haproxy
```

## Install Netdata

Install on all VMs

```bash
curl -L https://packagecloud.io/netdata/netdata/gpgkey | sudo apt-key add -
```

Create a file named `/etc/apt/sources.list.d/netdata_netdata.list` that contains the repository configuration below:

```yaml
deb https://packagecloud.io/netdata/netdata/ubuntu/ bionic main
deb-src https://packagecloud.io/netdata/netdata/ubuntu/ bionic main
```

Run the following to install netdata:

```bash
sudo apt-get -y update 
sudo apt-get -y install netdata
```

The following steps install the basic software and depending on time in the class we will [configure the software](manual_ubuntu_configure.md) to work together. The whole point of the workshop is to automate the aforementioned steps and be sure you will get the same results every time. If you are ahead of the rest of the class do go ahead and configure the software
