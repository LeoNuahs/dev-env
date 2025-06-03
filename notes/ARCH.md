# Arch
1. `sudo pacman -Syu`

## Dual Booting
This section assumes that you are using the GRUB bootloader
1. `sudo pacman -S os-prober`
2. `sudo grub-mkconfig -o /boot/grub/grub.cgf`

# Hyperland
1. `sudo pacman -S uwsm`
2. `vim $HOME/.config/hypr/hyprland.conf` for changes
    - make sure to copy changes to `$HOME/personal/linux-setup/env/.config/hypr/hyprland.conf`
        - use `cp`/`rsync` for manual/automatic copy
3. `vim $HOME/.bash_profile` and add the following code

```sh
if uwsm check may-start && uwsm select; then
    exec uwsm start default
fi
```

# Audio
1. `sudo pacman -S pipewire wireplumber pipewire-pulse pipewire-alsa alsa-utils`    # alsamixer TUI
2. `sudo pacman -S pavucontrol` # pavucontrol GUI
3. Add `options snd-intel-dspcfg dsp_driver=1` to `/etc/modprobe.d/alsa-base.conf` for audio.

# Bluetooth
1. `sudo pacman -S bluez bluez-utils bluetui`   # bluetui TUI
2. `sudo systemctl --now enable bluetooth.service`

# NetworkManager
1. `sudo pacman -S networkmanager`
2. `sudo systemctl enable --now NetworkManager.service`

# Waybar
1. `sudo pacman -S waybar`
2. `sudo pacman -S ttf-jetbrains-mono-nerd ttf-font-awesome ttf-nerd-fonts-symbols`    # font-styles and icons for Waybar
3. `fc-cache -f -v`     # clear font cache
