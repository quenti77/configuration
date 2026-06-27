# Input Remapper

Outil de remapping de boutons pour périphériques d'entrée (souris, clavier, manette).
Fonctionne indépendamment du fabricant, utile pour les souris non supportées par libratbag ou rivalcfg.

- [Input Remapper](#input-remapper)
  - [Installation](#installation)
  - [Lancement](#lancement)
  - [SteelSeries Sensei — clic droit rapide](#steelseries-sensei--clic-droit-rapide)
    - [Preset](#preset)
    - [Charger automatiquement](#charger-automatiquement)


## Installation

```bash
yay -S input-remapper
sudo systemctl enable --now input-remapper
```


## Lancement

```bash
input-remapper-gtk
```


## SteelSeries Sensei — clic droit rapide

La souris (USB `1038:1361`) n'est pas supportée par libratbag ni rivalcfg.
Preset configuré pour mapper le bouton 4 (BTN_SIDE) en clic droit rapide.

### Preset

Fichier : `~/.config/input-remapper-2/presets/La-VIEW Technology SteelSeries Sensei/Speed right click.json`

- **Input** : Mouse Button 4 (`BTN_SIDE`, code 275)
- **Output** : `repeat(100, key(BTN_RIGHT))`
- **Target** : mouse

### Charger automatiquement

Activer le toggle **"Charger automatiquement"** dans l'interface pour que le preset s'applique au démarrage de la session.
