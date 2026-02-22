# KWin

Configuration et correctifs pour KWin, le gestionnaire de fenêtres de KDE.

- [KWin](#kwin)
  - [Souris bloquée entre les écrans](#souris-bloquée-entre-les-écrans)
    - [Modifier la configuration](#modifier-la-configuration)
    - [Recharger KWin](#recharger-kwin)


## Souris bloquée entre les écrans

Par défaut, KWin ajoute une résistance sur les bords d'écran (`EdgeBarrier`), ce qui bloque
la souris lors du passage d'un moniteur à l'autre. Pour désactiver ce comportement,
modifier le fichier `~/.config/kwinrc` :

### Modifier la configuration

```ini
[EdgeBarrier]
CornerBarrier=false
EdgeBarrier=0
```


### Recharger KWin

Pour appliquer sans redémarrer la session :

```bash
qdbus6 org.kde.KWin /KWin org.kde.KWin.reconfigure
```
