# Arch
1. `sudo pacman -Syu`

## Dual Booting
This section assumes that you are using the GRUB bootloader
1. `sudo pacman -S os-prober`
2. `sudo grub-mkconfig -o /boot/grub/grub.cgf`

# Hyperland
1. `sudo pacman -S uwsm`
2. `vim $HOME/.config/hypr/hyprland.conf`
3. `vim $HOME/.bash_profile` and add the following code

```sh
if uwsm check may-start && uwsm select; then
    exec uwsm start default
fi
```

