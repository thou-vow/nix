{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.mods.tmux.enable = lib.mkEnableOption "enable tmux";

  config = lib.mkIf config.mods.tmux.enable {
    programs.tmux = {
      enable = true;
      package = pkgs.tmux;

      baseIndex = 1;
      clock24 = true;
      historyLimit = 20000;
    };
  };
}

