{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./bindings.nix
  ];
  
  options.mods.tmux.enable = lib.mkEnableOption "enable tmux";

  config = lib.mkIf config.mods.tmux.enable {
    programs.tmux = {
      enable = true;
      package = pkgs.tmux;

      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      historyLimit = 500000;
      terminal = "tmux-256color";

      extraConfig = ''
        set status-position top
        set status-justify centre
        set status-style 'bg=black'
        set status-left '#[fg=white,bg=red]#S#[fg=red,bg=default]'
        set status-left-length 10
        set status-right-length 0 
        
        set window-status-style 'fg=white dim'
        set window-status-format '  #I  '
        set window-status-current-style 'fg=yellow bold'
        set window-status-current-format '  #I  '
      '';
    };
  };
}

