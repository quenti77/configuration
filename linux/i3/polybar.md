## Polybar

Ajouter une source list pour apt `/etc/apt/source.list.d/ubuntu.list`
```bash
deb http://fr.archive.ubuntu.com/ubuntu groovy main universe
```

Puis faire :
```bash
sudo apt update
sudo apt install polybar

mkdir -p ~/.config/polybar/
```

Puis suivre la doc pour choisir votre thème polybar :
[Polybar theme](https://github.com/adi1090x/polybar-themes)

> Attention pour la font et la couleur de certain thème qui ne marche pas.
> Il faudra peut-être les chercher manuellement.

Pour lancer polybar avec i3 il faut ajouter dans la configuration de i3 ceci :
```
exec_always --no-startup-id "killall polybar; ~/.config/polybar/launch.sh"
```
