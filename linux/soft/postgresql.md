## PostgreSQL

Installation et connection sur le compte de postgresql

```bash
sudo apt install postgresql postgresql-contrib
sudo -i -u postgres
```

Commande pour créer un utilisateur et une base de données associé

```sql
create user <username> with encrypted password '<password>';

-- A faire pour chaque base de données
create database <dbname>;
grant all privileges on database <dbname> to <username>;
flush privileges

create extension if not exists "uuid-ossp"; -- uuid functions
```

### Configuration

```bash
sudo vim /etc/postgresql/{version_number}/main/pg_hba.conf
```

```conf
# TYPE  DATABASE        USER            ADDRESS             METHOD
local   all             postgres                            peer
host    all             all             127.0.0.1/32        md5
```

```sql
\du                     -- => Liste les rôles
\l                      -- => List des bases de données
\c db                   -- => Connection sur une autre bdd
SET ROLE <username>     -- => Change l'utilisateur actif
```

### PGADMIN ([https://wiki.postgresql.org/wiki/Apt](https://wiki.postgresql.org/wiki/Apt))

```bash
sudo apt install ca-certificates gnupg
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Dans le fichier /etc/apt/sources.list.d/pgadmin.list
deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main

sudo apt update
sudo apt upgrade

sudo apt install pgadmin4
```
