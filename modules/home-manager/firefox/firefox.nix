{config, inputs, pkgs, ...}:
{
  programs.firefox = {
    enable = true;
    profiles.michi = {
      bookmarks = [
        {
          name = "Searx";
	  url = "https://searx.be/";
	  tags = [ "search" ];
	  keyword = "searx";
	}{
          name = "Packages";
	  url = "https://search.nixos.org/packages/";
	  tags = [ "search" ];
	  keyword = "nixpkgs";
	}{
          name = "Icons";
	  url = "https://fontawesome.com/icons/";
	  tags = [ "search" ];
	  keyword = "icons";
	}{
          name = "Kavin Rocks";
	  url = "https://piped.kavin.rocks/";
	  tags = [ "piped" ];
	  keyword = "kavin";
	}{
          name = "SMNZ";
	  url = "https://piped.smnz.de/";
	  tags = [ "piped" ];
	  keyword = "smnz";
	}
      ];
      #extensions = with pkgs.inputs.firefox-addons; [
      #  ublock-origin
      #  darkreader
      #];
      settings = {};
    };
  };
}
