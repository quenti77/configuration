## Chose à retenir

Voici les choses à retenir pour qu'il n'y ait pas de problème dans les machines virtuelles,
ou pour activer des options de QoL.

- [Chose à retenir](#chose-à-retenir)
  - [Fix lag clavier (VMWare Workstation 17)](#fix-lag-clavier-vmware-workstation-17)
  - [Fix missing tools](#fix-missing-tools)


### Fix lag clavier (VMWare Workstation 17)

Dans VMWare Workstation 17, par défaut, il utilise un mapping clavier de type PS/2.
Le clavier effectue du polling et non pas de l'intéruption, ce qui provoquent des latences lors de la saisie.
Pour régler le problème il faut modifier le fichier `.vmx` associé à la VM. Voici la ligne à ajouter :

```ini
keyboard.vusb.enable = "TRUE"
```


### Fix missing tools

Il est possible qu'avec le gestionnaire i3, que le copier coller entre la VM et l'hôte ne fonctionne plus.
Vérifier que les outils sont bien installé et démarrer :

```zsh
sudo pacman -S open-vm-tools
sudo systemctl enable vmtoolsd
sudo systemctl start vmtoolsd

# si besoin, lancer cette commande
vmware-user
```
