# KDE — Configuration générale

Configuration et correctifs pour KDE Plasma.

- [KDE — Configuration générale](#kde--configuration-générale)
  - [Pavé numérique actif au démarrage](#pavé-numérique-actif-au-démarrage)
    - [SDDM (écran de connexion)](#sddm-écran-de-connexion)
    - [Session KDE (après connexion)](#session-kde-après-connexion)


## Pavé numérique actif au démarrage

Par défaut, le pavé numérique est désactivé au boot. Le fix se fait en deux étapes :
une pour l'écran de connexion (SDDM), une pour la session KDE.

### SDDM (écran de connexion)

Créer le fichier `/etc/sddm.conf.d/numlock.conf` :

```bash
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/numlock.conf <<'EOF'
[General]
Numlock=on
EOF
```

### Session KDE (après connexion)

Ajouter dans `~/.config/kcminputrc` :

```ini
[Keyboard]
NumLock=0
```

> `NumLock=0` = activer, `NumLock=1` = désactiver, `NumLock=2` = laisser tel quel.

Le changement prend effet à la prochaine connexion, sans redémarrage nécessaire.
