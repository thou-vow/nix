{
  config,
  lib,
  ...
}:

{
  options.mods.gitui.enable = lib.mkEnableOption "enable gitui";

  config = lib.mkIf config.mods.gitui.enable {
    programs.gitui = {
      enable = true;
    };
  };
}
