{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home" = {
    directories = [
      "Documents"
      "Downloads"
      "Pictures"
      "HyprNix"
      ".mozilla"
      ".minecraft"
      ".config/nvim"
      ".config/sops"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      
    ];
    allowOther = false;
  }; 
}
