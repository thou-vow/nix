{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.mods.langs.rust.enable = lib.mkEnableOption "enable rust";

  config = lib.mkIf config.mods.langs.rust.enable {
    home.packages = with pkgs; [
      cargo
      clippy
      rustc
      rustfmt
      rustycli # Playground
    ];
  };
}
