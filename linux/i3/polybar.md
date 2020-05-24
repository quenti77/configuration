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

# Attention à vérifié si ce n'est pas un fichier *.gz
cp /usr/share/doc/polybar/config ~/.config/polybar/config
```

```bash
sudo apt install fonts-font-awesome
```

Fichier de configuration polybar :
```ini
[colors]
;background = ${xrdb:color0:#222}
background = #222
background-alt = #444
;foreground = ${xrdb:color7:#222}
foreground = #dfdfdf
foreground-alt = #bbb
primary = #ffb52a
secondary = #e60053
alert = #bd2c40

[bar/default]
;monitor = ${env:MONITOR:HDMI-1}
width = 100%
height = 27
;offset-x = 1%
;offset-y = 1%
radius = 0
fixed-center = false

background = ${colors.background}
foreground = ${colors.foreground}

line-size = 3
line-color = #f00

border-size = 1
border-color = #00000000

padding-left = 0
padding-right = 2

module-margin-left = 1
module-margin-right = 2

font-0 = DejaVu Sans:pixelsize=10;1
font-1 = FontAwesome:size=10;0
font-2 = siji:pixelsize=10;1

modules-left = i3 xwindow
modules-center =
modules-right = pulseaudio xkeyboard memory cpu eth date powermenu

tray-position = right
tray-padding = 2

cursor-click = pointer
cursor-scroll = ns-resize

[module/xwindow]
type = internal/xwindow
label = %title:0:30:...%

[module/xkeyboard]
type = internal/xkeyboard
blacklist-0 = num lock

format-prefix = " "
format-prefix-foreground = ${colors.foreground-alt}
format-prefix-underline = ${colors.secondary}

label-layout = %layout%
label-layout-underline = ${colors.secondary}

label-indicator-padding = 2
label-indicator-margin = 1
label-indicator-background = ${colors.secondary}
label-indicator-underline = ${colors.secondary}

[module/filesystem]
type = internal/fs
interval = 25

mount-0 = /

label-mounted = %{F#0a81f5}%mountpoint%%{F-}: %percentage_used%%
label-unmounted = %mountpoint% not mounted
label-unmounted-foreground = ${colors.foreground-alt}

[module/i3]
type = internal/i3
format = <label-state> <label-mode>
index-sort = true
wrapping-scroll = false

; Only show workspaces on the same output as the bar
;pin-workspaces = true

label-mode-padding = 2
label-mode-foreground = #000
label-mode-background = ${colors.primary}

; focused = Active workspace on focused monitor
label-focused = %index% %icon%
label-focused-background = ${colors.background-alt}
label-focused-underline= ${colors.primary}
label-focused-padding = 2

; unfocused = Inactive workspace on any monitor
label-unfocused = %index% %icon%
label-unfocused-padding = 2

; visible = Active workspace on unfocused monitor
label-visible = %index% %icon%
label-visible-background = ${self.label-focused-background}
label-visible-underline = ${self.label-focused-underline}
label-visible-padding = ${self.label-focused-padding}

; urgent = Workspace with urgency hint set
label-urgent = %index% %icon%
label-urgent-background = ${colors.alert}
label-urgent-padding = 2

; Separator in between workspaces
; label-separator = |
ws-icon-0= 1;
ws-icon-1= 2;
ws-icon-2= 3;

[module/xbacklight]
type = internal/xbacklight

format = <label> <bar>
label = BL

bar-width = 10
bar-indicator = |
bar-indicator-foreground = #fff
bar-indicator-font = 2
bar-fill = ─
bar-fill-font = 2
bar-fill-foreground = #9f78e1
bar-empty = ─
bar-empty-font = 2
bar-empty-foreground = ${colors.foreground-alt}

[module/backlight-acpi]
inherit = module/xbacklight
type = internal/backlight
card = intel_backlight

[module/cpu]
type = internal/cpu
interval = 2
format-prefix = " "
format-prefix-foreground = ${colors.foreground-alt}
format-underline = #f90000
label = %percentage:2%%

[module/memory]
type = internal/memory
interval = 2
format-prefix = " "
format-prefix-foreground = ${colors.foreground-alt}
format-underline = #4bffdc
label = %percentage_used%%

[module/eth]
type = internal/network
interface = enp0s31f6
interval = 3.0

format-connected-underline = #55aa55
format-connected-prefix = " "
format-connected-prefix-foreground = ${colors.foreground-alt}
label-connected = %local_ip%

format-disconnected =

[module/date]
type = internal/date
interval = 5

date =
date-alt = " %Y-%m-%d"

time = %H:%M
time-alt = %H:%M:%S

format-prefix = 
format-prefix-foreground = ${colors.foreground-alt}
format-underline = #0a6cf5

label = %date% %time%

[module/pulseaudio]
type = internal/pulseaudio

format-volume = <label-volume> <bar-volume>
label-volume = VOL %percentage%%
label-volume-foreground = ${root.foreground}

label-muted = 🔇 muted
label-muted-foreground = #666

bar-volume-width = 10
bar-volume-foreground-0 = #55aa55
bar-volume-foreground-1 = #55aa55
bar-volume-foreground-2 = #55aa55
bar-volume-foreground-3 = #55aa55
bar-volume-foreground-4 = #55aa55
bar-volume-foreground-5 = #f5a70a
bar-volume-foreground-6 = #ff5555
bar-volume-gradient = false
bar-volume-indicator = |
bar-volume-indicator-font = 2
bar-volume-fill = ─
bar-volume-fill-font = 2
bar-volume-empty = ─
bar-volume-empty-font = 2
bar-volume-empty-foreground = ${colors.foreground-alt}

[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 60

format = <ramp> <label>
format-underline = #f50a4d
format-warn = <ramp> <label-warn>
format-warn-underline = ${self.format-underline}

label = %temperature-c%
label-warn = %temperature-c%
label-warn-foreground = ${colors.secondary}

ramp-0 = 
ramp-1 = 
ramp-2 = 
ramp-foreground = ${colors.foreground-alt}

[module/powermenu]
type = custom/menu

expand-right = true

format-spacing = 1

label-open = 
label-open-foreground = ${colors.secondary}
label-close = 
label-close-foreground = ${colors.secondary}
label-separator = |
label-separator-foreground = ${colors.foreground-alt}

menu-0-0 =  reboot
menu-0-0-exec = menu-open-1
menu-0-1 =  power off
menu-0-1-exec = menu-open-2

menu-1-0 = cancel
menu-1-0-exec = menu-open-0
menu-1-1 =  reboot
menu-1-1-exec = sudo reboot

menu-2-0 =  power off
menu-2-0-exec = sudo poweroff
menu-2-1 = cancel
menu-2-1-exec = menu-open-0

[settings]
screenchange-reload = true

[global/wm]
margin-top = 5
margin-bottom = 5
```
