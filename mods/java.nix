{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mods.java.enable = lib.mkEnableOption "enable java";

  config = lib.mkIf config.mods.java.enable {
    home.packages = with pkgs; [
      jdk
    ];
  };
}
