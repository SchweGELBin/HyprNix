{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options = {
    main-user.enable
      = lib.mkEnableOption "Enable user module";

    main-user.userName = lib.mkOption {
      default = "michi";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      #initialPassword = "1234";
      description = "michi";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
      #shell = pkgs.zsh;
      shell = pkgs.bash;
    };
  };
}
