{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mods.typst.enable = lib.mkEnableOption "enable typst";

  config = lib.mkIf config.mods.typst.enable {
    home.packages = with pkgs; [
      typst
      typst-fmt
    ];
  };
}

