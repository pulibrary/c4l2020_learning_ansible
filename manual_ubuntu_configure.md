## postgresql 

Edit `/etc/postgresql/12/main/postgresql.conf` (about line 59)

```ini
...
listen_addresses = '*'
...
``` 

Edit `/etc/postgresql/12/main/pg_hba.conf` and add

```ini
# allow web machines
host	all		all		10.0.15.23/32		md5
host	all		all		10.0.15.24/32		md5
```
