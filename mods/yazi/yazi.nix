{
  config,
  lib,
  pkgs,
  ...
}:
 {
  options.mods.yazi.enable = lib.mkEnableOption "enable yazi";

  config = lib.mkIf config.mods.yazi.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = lib.mkIf config.mods.fish.enable true;
      package = pkgs.yazi;
      settings = {
        manager = {
          show_hidden = true;
          sort_by = "natural";
          sort_translit = true;
          mouse_events = [];
        };
      };
    };
  };
}
