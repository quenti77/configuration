# LogStash

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
sudo apt install elasticsearch
```

```
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
```

Exemple de requête :
```bash
curl -XGET 'localhost:9200/_cat/indices?v'

# logstash-2019.11.10-000001 = index vu par l'url au dessus
curl -XGET 'localhost:9200/logstash-2019.11.10-000001/_search?pretty=true&q=*:*' | jq
```
