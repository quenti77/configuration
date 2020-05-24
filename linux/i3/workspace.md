## Workspace i3

Dans le fichier de config de i3 :

```ini
set $leftMonitor Virtual1
set $rightMonitor Virtual2

workspace $ws1 output $leftMonitor
workspace $ws3 output $leftMonitor
workspace $ws5 output $leftMonitor
workspace $ws7 output $leftMonitor
workspace $ws9 output $leftMonitor

workspace $ws2 output $rightMonitor
workspace $ws4 output $rightMonitor
workspace $ws6 output $rightMonitor
workspace $ws8 output $rightMonitor
workspace $ws10 output $rightMonitor
```

Pour avoir le nom de vos moniteurs il faut entrer la commande :
```bash
xrandr # A installer si besoin
```
