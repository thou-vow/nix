{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mods.tmux.enable = lib.mkEnableOption "enable";

  config = lib.mkIf config.mods.tmux.enable {
    home.packages = with pkgs; [
      dash
    ];

    programs.tmux = {
      enable = true;
      package = pkgs.tmux;

      extraConfig = ''
        run "${config.home.homeDirectory}/nix/assets/tmux/startup.sh"
      '';
    };
  };
}
