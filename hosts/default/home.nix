{ config, pkgs, inputs, ... }:

{
  home.username = "michi";
  home.homeDirectory = "/home/michi";
  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; 
 
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ../../modules/home-manager/default.nix 
  ]; 

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato; 
}
