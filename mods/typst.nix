{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mods.typst.enable = lib.mkEnableOption "enable typst";

  config = lib.mkIf config.mods.typst.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      typst
      typstyle
    ];
  };
}
