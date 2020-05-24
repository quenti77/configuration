## LogStash

Installation du openjdk 11

```bash
sudo apt install openjdk-11-jdk
```

Installation de logstash

```bash
# Si c'est le premier package de la stack ELK
sudo apt install apt-transport-https
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic.list

sudo apt update

# Package
sudo apt install logstash
```

Voir ou se trouve les dossier de logstash : [https://www.elastic.co/guide/en/logstash/7.4/dir-layout.html](https://www.elastic.co/guide/en/logstash/7.4/dir-layout.html)

> Pour xubuntu c'était dans :
> - /usr/share/logstash
> - /etc/logstash

Fichier de configuration pour syslog :

```nginx
input {
    syslog {
        host => "127.0.0.1"
        port => 514
    }
}
output {
    elasticsearch {
    }
}
```

Commande utile : [argument du CLI](https://www.elastic.co/guide/en/logstash/7.4/running-logstash-command-line.html)

```bash
sudo bin/logstash \
    -f /etc/logstash/conf.d/01-syslog-base.conf \
    --path.settings /etc/logstash
# -t pour tester la configuration
# --debug pour voir tous les messages
```

```bash
sudo systemctl enable logstash.service
sudo systemctl start logstash.service
```
