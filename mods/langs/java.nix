{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mods.langs.java.enable = lib.mkEnableOption "enable java";

  config = lib.mkIf config.mods.langs.java.enable {
    home.packages = with pkgs; [
      jdk
    ];
  };
}
