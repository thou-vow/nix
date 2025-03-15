{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mods.langs.typst.enable = lib.mkEnableOption "enable typst";

  config = lib.mkIf config.mods.langs.typst.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      typst
      typstyle
    ];
  };
}
