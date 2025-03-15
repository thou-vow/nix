{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./bindings.nix
    ./editor.nix
    ./languages.nix
  ];

  options.mods.helix.enable = lib.mkEnableOption "enable helix";

  config = lib.mkIf config.mods.helix.enable {
    home.shellAliases = {
      "h" = "hx";
      "helix" = "hx";
    };

    programs.helix = {
      enable = true;
      package = pkgs.helix;
      settings.theme = "my-default";
    };

    xdg.configFile."helix/themes".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/assets/helix/themes";

  };
}
