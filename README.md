# HyprNix
My Nix configs

## Disclaimer
- This configuration and documentation isn't finished (yet).
- This repo is for inspiration.
- It includes flakes, disko, nix-sops, nix-colors, home-manager and impermanance.
- Because the root partition gets wiped at every boot, some things may not work with it.
- Check out my new [nix-config](https://github.com/SchweGELBin/nix-config).

## Configuration
```
Window Manager       - HyprLand
Terminal             - Kitty
Browser              - FireFox
Application Launcher - Rofi
Bar                  - Waybar
Wallpaper Engine     - SWWW
Audio                - Pipewire
Boot Manager         - Grub
Editor               - Neovim
Theme                - Catppuccin Machiatto (Mauve)
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
