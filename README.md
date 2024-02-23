# HyprNix
My Nix configs

## Configuration
```
Window Manager       - HyprLand
Terminal             - Kitty
File Manager         - Dolphin
Browser              - FireFox
Application Launcher - Rofi
Bar                  - Waybar
Wallpaper Engine     - SWWW
Audio                - Pipewire
Boot Manager         - Grub
Editor               - Neovim
Theme                - Catppuccin
```

## Apply
- Install latest NixOS without a desktop
- ```sudo nix-shell -p git && cd /etc/nixos && git clone https://github.com/SchweGELBin/HyprNix && cd HyprNix && sudo nixos-rebuild switch --flake ./#default```
- Run ```sudo mkdir /persist/home && chmod 777 /persist/home``` to fix the impermanence setup
- Reboot
- To upgrade your system: ```sudo rebuild```
- Run ```git pull``` once in a while

## Credits
- Thank you **[vimjoyer](https://github.com/vimjoyer)** for your help!
- Please check out his [Youtube Channel](https://youtube.com/@vimjoyer)
