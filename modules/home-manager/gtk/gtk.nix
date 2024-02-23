{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Standard-Green-Dark";
      package = pkgs.catppuccin-gtk;
    };
  };
}
