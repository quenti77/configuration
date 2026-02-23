## Docker

Installation et configuration de Docker et Docker Compose.

- [Docker](#docker)
  - [Installation](#installation)
- [Structure d'un fichier compose](#structure-dun-fichier-compose)
- [Variables d'environnement](#variables-denvironnement)
- [Réseaux et volumes](#réseaux-et-volumes)
- [Fichier override](#fichier-override)
- [Commandes](#commandes)
- [Configuration](#configuration)
  - [Changer le répertoire de stockage des images](#changer-le-répertoire-de-stockage-des-images)
  - [Commandes utiles](#commandes-utiles)

### Installation

Installer les packages :

```bash
sudo pacman -S docker docker-compose
```

Permet d'utiliser Docker sans `sudo` :

```bash
sudo usermod -aG docker $USER
newgrp docker
```

> Un redémarrage de session peut être nécessaire pour que le changement prenne effet.

Activer le service puis le lancer

```bash
sudo systemctl enable docker
sudo systemctl start docker

# Vérification
sudo systemctl status docker
```

## Structure d'un fichier compose

Exemple complet avec les options les plus courantes :

```yaml
services:
  app:
    image: nginx:alpine                  # image depuis Docker Hub
    # build: .                           # ou build depuis un Dockerfile local
    container_name: mon_app
    restart: unless-stopped
    ports:
      - "8080:80"                        # hôte:conteneur
    volumes:
      - ./html:/usr/share/nginx/html:ro  # montage en lecture seule
      - app_data:/var/data               # volume nommé
    environment:
      - APP_ENV=production
    env_file:
      - .env                             # variables depuis un fichier
    depends_on:
      - db
    networks:
      - frontend
      - backend

  db:
    image: postgres:16
    container_name: mon_db
    restart: unless-stopped
    volumes:
      - db_data:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: ${DB_NAME}
    networks:
      - backend

volumes:
  app_data:
  db_data:

networks:
  frontend:
  backend:
```

## Variables d'environnement

Les variables peuvent être définies dans un fichier `.env` à la racine du projet. Elles sont automatiquement chargées par Docker Compose :

```ini
# .env
DB_USER=admin
DB_PASSWORD=secret
DB_NAME=mydb
APP_PORT=8080
```

Référence dans le `compose.yml` :

```yaml
ports:
  - "${APP_PORT}:80"
```

> Ajouter `.env` au `.gitignore` pour ne pas versionner les secrets.

## Réseaux et volumes

Par défaut, tous les services d'un même fichier Compose partagent un réseau. Les réseaux et volumes nommés sont gérés par Docker et persistent après `docker compose down`.

```bash
# Supprimer également les volumes lors de l'arrêt
docker compose down -v

# Lister les volumes Docker
docker volume ls

# Inspecter un volume
docker volume inspect <nom_volume>

# Lister les réseaux Docker
docker network ls
```

## Fichier override

`docker-compose.override.yml` est fusionné automatiquement avec `docker-compose.yml`. Utile pour surcharger la config en développement sans modifier le fichier principal :

```yaml
# docker-compose.override.yml  (dev uniquement)
services:
  app:
    build: .
    volumes:
      - .:/app              # montage du code source en live
    environment:
      - APP_ENV=development
    ports:
      - "5173:5173"         # port Vite / hot-reload
```

Pour utiliser un fichier spécifique :

```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

## Commandes

```bash
# Lancer les services en arrière-plan
docker compose up -d

# Lancer uniquement certains services
docker compose up -d app db

# Arrêter et supprimer les conteneurs
docker compose down

# Arrêter, supprimer les conteneurs et les volumes
docker compose down -v

# Rebuild les images avant de démarrer
docker compose up -d --build

# Voir les logs de tous les services
docker compose logs -f

# Voir les logs d'un service spécifique
docker compose logs -f app

# Voir l'état des services
docker compose ps

# Exécuter une commande dans un service
docker compose exec app bash

# Relancer un service
docker compose restart app

# Scaler un service (plusieurs instances)
docker compose up -d --scale app=3

# Valider la syntaxe du fichier compose
docker compose config
```


## Configuration

### Changer le répertoire de stockage des images

Par défaut, Docker stocke ses données dans `/var/lib/docker`. Pour déplacer ce répertoire (ex: vers un disque plus grand) :

```bash
sudo systemctl stop docker.socket docker

sudo nano /etc/docker/daemon.json
```

```json
{
  "data-root": "/nouveau/chemin/docker"
}
```

```bash
# Copier les données existantes
sudo rsync -aP /var/lib/docker/ /nouveau/chemin/docker

sudo systemctl start docker

# Vérification
docker info | grep "Docker Root Dir"
```


### Commandes utiles

```bash
# Lister les conteneurs actifs
docker ps

# Lister tous les conteneurs (incluant stoppés)
docker ps -a

# Lister les images
docker images

# Supprimer les ressources inutilisées (conteneurs arrêtés, images non utilisées, réseaux)
docker system prune -a

# Idem + suppression des volumes
docker system prune -a --volumes

# Inspecter un conteneur
docker inspect <nom_ou_id>

# Accéder à un shell dans un conteneur en cours
docker exec -it <nom_ou_id> bash

# Voir les logs d'un conteneur
docker logs -f <nom_ou_id>
```
