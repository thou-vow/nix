{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mods.dash.enable = lib.mkEnableOption "enable dash";

  config = lib.mkIf config.mods.dash.enable {
    home.packages = with pkgs; [
      dash
      shfmt
    ];
  };
}
