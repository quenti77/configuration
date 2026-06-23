## Chose à retenir

Voici les choses à retenir pour qu'il n'y ait pas de problème dans les machines virtuelles,
ou pour activer des options de QoL.

- [Chose à retenir](#chose-à-retenir)
  - [Fix lag clavier (VMWare Workstation 17)](#fix-lag-clavier-vmware-workstation-17)
  - [Fix missing tools](#fix-missing-tools)
  - [Fix copier-coller sous Wayland](#fix-copier-coller-sous-wayland)
  - [Dossiers partagés (Shared Folders)](#dossiers-partagés-shared-folders)


### Fix lag clavier (VMWare Workstation 17)

Dans VMWare Workstation 17, par défaut, il utilise un mapping clavier de type PS/2.
Le clavier effectue du polling et non pas de l'intéruption, ce qui provoquent des latences lors de la saisie.
Pour régler le problème il faut modifier le fichier `.vmx` associé à la VM. Voici la ligne à ajouter :

```ini
keyboard.vusb.enable = "TRUE"
```


### Fix missing tools

Il est possible que le copier-coller entre la VM et l'hôte ne fonctionne plus.
Vérifier que les outils sont bien installés et démarrés :

```bash
sudo pacman -S open-vm-tools gtkmm3
sudo systemctl enable vmtoolsd
sudo systemctl start vmtoolsd
sudo systemctl restart vmtoolsd
```

> `gtkmm3` est indispensable : sans lui, le plugin clipboard `libdndcp.so` ne se charge pas
> (les libs `libgtkmm-3.0`, `libgdkmm-3.0`, `libglibmm-2.4` restent en "not found").


### Fix copier-coller sous Wayland

Sous KDE Wayland, le copier-coller entre l'hôte et la VM ne fonctionne pas car `vmtoolsd -n vmusr`
(le démon qui gère le presse-papiers) est lancé avec `WAYLAND_DISPLAY` défini. Son plugin clipboard
utilise X11 (XWayland), et la présence de `WAYLAND_DISPLAY` crée un conflit de synchronisation.

**Fix immédiat (sans redémarrer) :**

```bash
pkill -f "vmtoolsd -n vmusr"
DISPLAY=:0 WAYLAND_DISPLAY= /usr/bin/vmware-user-suid-wrapper &
```

**Fix permanent** — override de l'autostart KDE dans `~/.config/autostart/vmware-user.desktop` :

```ini
[Desktop Entry]
Type=Application
Exec=env WAYLAND_DISPLAY= /usr/bin/vmware-user-suid-wrapper
Name=VMware User Agent
NoDisplay=true
X-KDE-autostart-phase=1
```

Ce fichier prend la priorité sur `/etc/xdg/autostart/vmware-user.desktop` (qui ne passe pas `WAYLAND_DISPLAY=`).


### Dossiers partagés (Shared Folders)

Les dossiers partagés entre l'hôte Windows et la VM Linux sont accessibles via `/mnt/hgfs/`.

**Prérequis :** `open-vm-tools` installé et `vmtoolsd` actif (voir [Fix missing tools](#fix-missing-tools)).

**Activer les dossiers partagés dans VMWare :**

VM → Settings → Options → Shared Folders → Always enabled → Ajouter le dossier souhaité.

**Dossiers configurés :**

| Nom du partage | Chemin dans la VM         |
| -------------- | ------------------------- |
| Linux-Partage  | `/mnt/hgfs/Linux-Partage` |

**Montage manuel si `/mnt/hgfs/` est vide au démarrage :**

```bash
sudo vmhgfs-fuse .host:/ /mnt/hgfs/ -o allow_other
```

**Montage automatique au démarrage** via `/etc/fstab` :

```
.host:/   /mnt/hgfs   fuse.vmhgfs-fuse   allow_other,defaults   0   0
```
