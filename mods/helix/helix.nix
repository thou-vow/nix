{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./editor.nix
    ./keys.nix
    ./languages.nix
  ];

  options.mods.helix.enable = lib.mkEnableOption "enable helix";

  config = lib.mkIf config.mods.helix.enable {
    programs.helix = {
      enable = true;
      package = pkgs.helix;
      settings.theme = "rose_pine";
    };

    xdg.configFile = let
      themesPath = "${config.home.homeDirectory}/nix/mods/helix/themes";
    in {
      "helix/themes".source = config.lib.file.mkOutOfStoreSymlink themesPath;
    };
  };
}
