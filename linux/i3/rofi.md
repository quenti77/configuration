## Rofi

Installation simple avec la commande :
```bash
sudo apt install rofi
```

Il faut créer les fichiers de configurations :
```bash
touch ~/.config/rofi/config
touch ~/.config/rofi/config.rasi
```

Pour lancer rofi à la place de dmenu il faut remplacer :
```ini
# Ouvre le start menu
bindsym $mod+d exec dmenu_run
```
Par :
```ini
# Ouvre le start menu
bindsym $mod+d exec rofi -show drun
```

La config de rofi :
```scss
configuration {
	modi: "window,run,ssh,drun";
	width: 50;
	lines: 20;
	font: "Cascadia Code 12";
	show-icons: true;
	sidebar-mode: true;
	fake-transparency: true;
}
@import "~/.config/rofi/personal.rasi"
```

```scss
/**
 * ROFI Color theme
 * User: quentin
 */

* {
    selected-normal-foreground:  rgba ( 2, 20, 63, 100 % );
    foreground:                  rgba ( 86, 200, 206, 100 % );
    normal-foreground:           @foreground;
    alternate-normal-background: rgba ( 0, 0, 0, 0 % );
    red:                         rgba ( 220, 50, 47, 100 % );
    selected-urgent-foreground:  rgba ( 2, 20, 63, 100 % );
    blue:                        rgba ( 38, 139, 210, 100 % );
    urgent-foreground:           rgba ( 255, 129, 255, 100 % );
    alternate-urgent-background: rgba ( 0, 0, 0, 0 % );
    active-foreground:           rgba ( 138, 196, 255, 100 % );
    lightbg:                     rgba ( 238, 232, 213, 100 % );
    selected-active-foreground:  rgba ( 2, 20, 63, 100 % );
    alternate-active-background: rgba ( 0, 0, 0, 0 % );
    background:                  rgba ( 29, 29, 38, 75 % );
    bordercolor:                 rgba ( 219, 223, 188, 100 % );
    alternate-normal-foreground: @foreground;
    normal-background:           rgba ( 0, 0, 208, 0 % );
    lightfg:                     rgba ( 88, 104, 117, 100 % );
    selected-normal-background:  rgba ( 189, 129, 253, 100 % );
    border-color:                @foreground;
    spacing:                     0;
    separatorcolor:              @foreground;
    urgent-background:           rgba ( 0, 0, 208, 0 % );
    selected-urgent-background:  rgba ( 255, 129, 127, 100 % );
    alternate-urgent-foreground: @urgent-foreground;
    background-color:            rgba ( 0, 0, 0, 0 % );
    alternate-active-foreground: @active-foreground;
    active-background:           rgba ( 0, 0, 208, 0 % );
    selected-active-background:  rgba ( 138, 196, 255, 100 % );
}
#window {
    background-color: @background;
    border:           1;
    padding:          0;
}
#mainbox {
    border:  0;
    padding: 0;
}
#message {
    border:       2px 0px 0px ;
    border-color: @separatorcolor;
    padding:      1px ;
}
#textbox {
    text-color: @foreground;
}
#listview {
    fixed-height: 0;
    border:       2px 0px 0px ;
    border-color: @separatorcolor;
    spacing:      2px ;
    scrollbar:    true;
    padding:      0px 0px 0px ;
}
#element {
    border:  0;
    padding: 4px 0px 4px 0px;
    margin: 0px 0px 0px 8px;
}
#element.normal.normal {
    background-color: @normal-background;
    text-color:       @normal-foreground;
}
#element.normal.urgent {
    background-color: @urgent-background;
    text-color:       @urgent-foreground;
}
#element.normal.active {
    background-color: @active-background;
    text-color:       @active-foreground;
}
#element.selected.normal {
    background-color: @selected-normal-background;
    text-color:       @selected-normal-foreground;
}
#element.selected.urgent {
    background-color: @selected-urgent-background;
    text-color:       @selected-urgent-foreground;
}
#element.selected.active {
    background-color: @selected-active-background;
    text-color:       @selected-active-foreground;
}
#element.alternate.normal {
    background-color: @alternate-normal-background;
    text-color:       @alternate-normal-foreground;
}
#element.alternate.urgent {
    background-color: @alternate-urgent-background;
    text-color:       @alternate-urgent-foreground;
}
#element.alternate.active {
    background-color: @alternate-active-background;
    text-color:       @alternate-active-foreground;
}
#scrollbar {
    width:        4px ;
    border:       0;
    handle-width: 8px ;
    padding:      0;
}
#mode-switcher {
    border:       2px 0px 0px ;
    border-color: @separatorcolor;
}
#button.selected {
    background-color: @selected-normal-background;
    text-color:       @selected-normal-foreground;
}
#inputbar {
    spacing:    0;
    text-color: @normal-foreground;
    padding:    1px ;
}
#case-indicator {
    spacing:    0;
    text-color: @normal-foreground;
}
#entry {
    spacing:    0;
    text-color: @normal-foreground;
}
#prompt, button{
    spacing:    0;
    text-color: @normal-foreground;
}
#inputbar {
    children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
}
#textbox-prompt-colon {
    expand:     false;
    str:        ":";
    margin:     0px 0.3em 0em 0em ;
    text-color: @normal-foreground;
}
```
