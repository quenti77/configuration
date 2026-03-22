# TD-07 Audio Setup — Linux (PipeWire)

## Objectif

Entendre le son de la batterie Roland TD-07 **et** le son système (YouTube, etc.) dans le casque Corsair VOID Elite, en simultané.

---

## Matériel

| Élément    | Détail                                                                                            |
| ---------- | ------------------------------------------------------------------------------------------------- |
| Batterie   | Roland TD-07                                                                                      |
| Connexion  | Câble jack 3.5mm (ou RCA→jack) : sortie stéréo TD-07 → **prise bleue (line-in)** de la carte mère |
| Casque     | Corsair VOID Elite Wireless (USB dongle)                                                          |
| Carte mère | Intel HDA ALC1220 (`pci-0000_00_1f.3`)                                                            |

---

## Comment ça fonctionne

Un module **loopback PipeWire** capture en permanence le signal de la prise bleue et le renvoie vers le casque :

```
[Prise bleue / Line-in ALC1220]
        ↓
[loopback-td07-capture]  ←— PipeWire loopback
        ↓
[loopback-td07-playback]
        ↓
[Corsair VOID Elite]
```

Le son YouTube passe par le chemin normal (navigateur → Corsair), donc les deux se mélangent automatiquement dans le casque.

---

## Fichier de configuration PipeWire

**Chemin :** `~/.config/pipewire/pipewire.conf.d/loopback-td07.conf`

```conf
context.modules = [
    {   name = libpipewire-module-loopback
        args = {
            audio.position = [ FL FR ]
            capture.props = {
                node.name = "loopback-td07-capture"
                audio.position = [ FL FR ]
                target.object = "alsa_input.pci-0000_00_1f.3.analog-stereo"
            }
            playback.props = {
                node.name = "loopback-td07-playback"
                audio.position = [ FL FR ]
                target.object = "alsa_output.usb-Corsair_CORSAIR_VOID_ELITE_Wireless_Gaming_Dongle-00.analog-stereo"
                stream.dont-remix = true
            }
        }
    }
]
```

Ce fichier est **permanent** — il se charge automatiquement à chaque démarrage de PipeWire.

---

## Problème récurrent : le bruit de fond

### Symptôme
Un bruit (grésille, souffle, ronflement) est audible dans le casque même quand la batterie ne joue pas.

### Cause
Le gain ALSA de la prise line-in est trop élevé :
- **Line Boost** : réglé à +30dB (amplifie le bruit électromagnétique)
- **Capture** : réglé à +30dB (double amplification)

### Fix (à relancer si le bruit revient)

```bash
# Réduire le boost de la prise line-in à 0dB
amixer -c PCH sset 'Line Boost' 0

# Réduire le gain de capture (ajuster entre 40-60% selon le volume de la TD-07)
amixer -c PCH sset 'Capture' 50%,50%
```

Vérifier le résultat :
```bash
amixer -c PCH scontents | grep -A5 "Line Boost\|^Simple.*Capture"
```

### Pourquoi ça revient (et pourquoi `alsactl store` ne suffit pas)

`alsa-restore.service` restore les valeurs à ~08:40:15, mais **PipeWire démarre à ~08:40:34 et réécrase les volumes ALSA** en initialisant les périphériques. `alsactl store` ne sert donc à rien.

### Fix permanent : service systemd utilisateur

**Fichier :** `~/.config/systemd/user/alsa-td07-gain.service`

Ce service se lance **après** `pipewire.service` (avec 2s de délai supplémentaire) et applique les bons niveaux :

```bash
# Activer le service (déjà fait, pour référence)
systemctl --user enable alsa-td07-gain.service

# Lancer manuellement (si besoin sans redémarrer)
systemctl --user start alsa-td07-gain.service

# Vérifier l'état
systemctl --user status alsa-td07-gain.service
```

### Fix automatique au branchement/débranchement du jack : règle udev

Quand le jack est débranché puis rebranché, PipeWire réinitialise les niveaux ALSA. Une règle udev relance automatiquement `alsa-td07-gain.service` à chaque changement d'état du jack line-in.

**Fichier :** `/etc/udev/rules.d/99-td07-line-in.rules`

```
ACTION=="change", SUBSYSTEM=="input", ATTR{name}=="HDA Intel PCH Line", RUN+="/usr/local/bin/td07-alsa-fix-udev.sh"
```

**Script appelé :** `/usr/local/bin/td07-alsa-fix-udev.sh`

```bash
#!/bin/bash
sleep 1
/usr/bin/systemctl --user --machine=quentin@ start alsa-td07-gain.service
```

```bash
# Recharger les règles udev après modification
sudo udevadm control --reload-rules
```

---

## Toggle loopback (activer/désactiver le son TD-07)

**Script :** `~/td07-toggle.sh` (ou `/usr/local/bin/td07-toggle`)

Active ou désactive le loopback en renommant le fichier de config PipeWire et en redémarrant PipeWire. Affiche une notification système.

```bash
# Utilisation directe
~/td07-toggle.sh

# Raccourci KDE :
# Paramètres système → Raccourcis → Raccourcis personnalisés → Nouveau → Commande/URL
# Commande : /home/quentin/td07-toggle.sh
```

---

## Commandes utiles

```bash
# Vérifier que le loopback est bien actif
pw-cli ls Node | grep td07

# Vérifier les volumes actuels de la ligne
amixer -c PCH scontents | grep -A6 "Line Boost\|Capture"

# Voir le volume de la source line-in dans PipeWire
pactl get-source-volume alsa_input.pci-0000_00_1f.3.analog-stereo

# Redémarrer PipeWire si le loopback ne fonctionne plus
systemctl --user restart pipewire pipewire-pulse

# Voir toutes les sources audio disponibles
pactl list sources short
```

---

## Checklist si ça ne marche pas

- [ ] La TD-07 est allumée et connectée à la prise **bleue** (line-in) de la carte mère
- [ ] Le loopback est actif : `pw-cli ls Node | grep td07` doit retourner 2 lignes
- [ ] Le volume de la prise bleue dans les paramètres audio du système est > 0
- [ ] Line Boost est à **0%** (pas de boost) : `amixer -c PCH sget 'Line Boost'`
- [ ] Le casque Corsair est bien la sortie par défaut : `pactl info | grep sink`

---

## Niveaux recommandés

| Paramètre ALSA | Valeur recommandée | Commande                               |
| -------------- | ------------------ | -------------------------------------- |
| Line Boost     | 0% (0dB)           | `amixer -c PCH sset 'Line Boost' 0`    |
| Capture        | 50-70%             | `amixer -c PCH sset 'Capture' 60%,60%` |
