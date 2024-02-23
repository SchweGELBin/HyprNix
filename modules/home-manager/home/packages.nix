{ config, pkgs, inputs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "rebuild" ''
      echo "Needs root"
      echo "Rebuilds your system, make sure to use \"git pull\" once in a while"
      echo "Make sure to place your dotfiles in ~/HyprNix/"
      git add /etc/nixos/HyprNix
      nix flake update
      nixos-rebuild switch --flake /etc/nixos/HyprNix/#default
    '')
    (pkgs.writeShellScriptBin "inject-payload" ''
      echo "Injects the newest Switch payload"
      echo "Make sure, you have an unpatched switch with the jig inserted"
      echo "Connect your switch to your pc via a charging cable, power off your switch, hold Volume up + down for a second"
      echo "Now, you can run \"inject-payload\""
      cd ~ && wget https://github.com/Atmosphere-NX/Atmosphere/releases/download/1.6.2/fusee.bin && fusee-nano ~/fusee.bin && rm ~/fusee.bin
    '')
    (pkgs.writeShellScriptBin "usb-mount" ''
      echo "Needs root"
      echo "Use cd /media/usb to view the contents"
      echo "use usb-unmount to unmount the usb"
      mkdir -p /media/usb
      mount /dev/sda1 /media/usb
    '')
    (pkgs.writeShellScriptBin "usb-unmount" ''
      echo "Needs root"
      umount /dev/sda1
    '')
    (pkgs.writeShellScriptBin "nvchad" ''
      rm -r ~/.config/nvim
      mkdir ~/.config/nvim
      git clone --depth 1 https://github.com/NvChad/NvChad.git ~/.config/nvim
    '')
    (pkgs.writeShellScriptBin "fix-homemanager-impermanence" ''
      echo "Needs root"
      mkdir /persist/home/
      chmod 777 /persist/home
    '') 
  ];
}
