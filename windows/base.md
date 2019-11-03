## Configuration explorateur de fichier

### Options des dossiers

- Général :
    - Changer accès rapide vers Ce PC
    - Désactiver l'affichage des fichiers et dossiers récents
    - Cliquer sur le bouton "Effacer"
- Affichage :
    - Afficher les fichiers, dossiers cachés
    - Décocher les cases pour masquer "conflits de fusion, extensions de fichier, fichiers protégés"
    - Cocher la case pour "Restaurer les fenêtres ..."

### Options windows

- Désactiver le démarrage rapide dans les options d'alimentation
- Régler les paramètres du son
- Déplacer le dossier roaming

### Drivers

- Carte graphique :
    - [driver nvidia](https://www.nvidia.fr/Download/index.aspx?lang=fr)
- Disque :
    - [Samsung Magicien](https://www.samsung.com/semiconductor/minisite/ssd/download/tools/)
- Carte mère :
    - [Drivers](https://www.gigabyte.com/Motherboard/Z370-AORUS-Ultra-Gaming-rev-10/support#support-dl-driver)


### Defenders

```bash
setx /M MP_FORCE_USE_SANDBOX 1
```

Powershell
```powershell
Get-MpPreference
Set-MpPreference -PUAProtection 1
```

Protection ransomwares
