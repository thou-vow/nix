{
  config,
  lib,
  pkgs,
  ...
}: {
  options.mods.rust.enable = lib.mkEnableOption "enable rust";

  config = lib.mkIf config.mods.rust.enable {
    home.packages = with pkgs; [
      cargo
      clippy
      rustc
      rustfmt
      rustycli # Playground
    ];
  };
}
