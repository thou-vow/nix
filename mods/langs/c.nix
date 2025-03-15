{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.mods.langs.c.enable = lib.mkEnableOption "enable c";

  config = lib.mkIf config.mods.langs.c.enable {
    home.packages = with pkgs; [
    ];
  };
}
