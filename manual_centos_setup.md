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
