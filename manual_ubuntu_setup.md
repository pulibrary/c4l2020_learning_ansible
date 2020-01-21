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
