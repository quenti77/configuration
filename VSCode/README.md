# VSCode — Configuration de base

## Profil de base (`BaseProfile.code-profile`)

Ce profil sert de point de départ pour tout nouveau profil VSCode. Il regroupe les settings UI/éditeur et les extensions génériques utiles quel que soit le projet.

### Importer le profil

`Ctrl+Shift+P` → **Profiles: Import Profile...** → sélectionner `BaseProfile.code-profile`.

### Prérequis

La police **JetBrainsMono Nerd Font** doit être installée sur la machine :

```bash
# CachyOS / Arch
yay -S ttf-jetbrains-mono-nerd
```

### Settings inclus

| Catégorie | Paramètres notables |
| --------- | ------------------- |
| Éditeur | JetBrainsMono Nerd Font, ligatures, taille 16, line height 30 |
| UI | Numéros de ligne relatifs, minimap désactivée, sticky scroll (2 lignes) |
| Thème | JetBrains Rider New UI Lighter + icônes JetBrains |
| Fichiers | Auto-save on focus change, pas de corbeille |
| Git | Ouverture automatique des repos dans les dossiers parents |

### Extensions incluses

| Extension | Utilité |
| --------- | ------- |
| GitLens | Historique Git avancé, blame, comparaisons |
| Error Lens | Affichage inline des erreurs/warnings |
| Markdown All in One | Raccourcis, TOC, preview Markdown |
| Markdown Preview Enhanced | Preview avancée (Mermaid, LaTeX…) |
| Markdown Preview Mermaid Support | Diagrammes Mermaid dans la preview native |
| Markdown Table | Aide à la création/édition de tables |
| Ascii Tree Generator | Génère des arbres de répertoires en ASCII |
| Rainbow CSV | Coloration des colonnes CSV |
| Edit CSV | Édition CSV en tableau |
| Fish | Coloration syntaxique pour Fish shell |
| JetBrains Icon Theme | Icônes de fichiers style JetBrains |
| JetBrains Rider New UI theme | Thème clair style Rider |

### Créer un profil projet à partir de la base

1. Importer `BaseProfile.code-profile` en lui donnant un nouveau nom (ex: `PHP`, `Python`…)
2. Ajouter les extensions spécifiques au langage/framework
3. Exporter via `Ctrl+Shift+P` → **Profiles: Export Profile...** et versionner dans ce repo

### Notes

- Le `globalState` embarqué dans le fichier `.code-profile` contient de l'état de session (panneaux, historique de commandes) — il est ignoré à l'import si les valeurs locales existent déjà.
- Les settings `php.suggest.basic` et `php.validate.enable` sont désactivés dans la base pour éviter les faux positifs ; à surcharger si besoin dans un profil PHP dédié.
