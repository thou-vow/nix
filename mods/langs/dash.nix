{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mods.langs.dash.enable = lib.mkEnableOption "enable dash";

  config = lib.mkIf config.mods.langs.dash.enable {
    home.packages = with pkgs; [
      dash
      shfmt
    ];
  };
}
