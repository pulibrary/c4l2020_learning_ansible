## postgresql (on c4l20node1)

Edit `/var/lib/pgsql/12/data/postgresql.conf` (about line 59)

```ini
...
listen_address = '*'
...
```

Edit `/var/lib/pgsql/12/data/pg_hba.conf` and add

```ini
# allow web machines
host    all        all        10.0.15.12/32        md5
host    all        all        10.0.15.13/32        md5
```
