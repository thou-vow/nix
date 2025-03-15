{
  config,
  lib,
  ...
}:

{
  options.mods.gh.enable = lib.mkEnableOption "enable gh";

  config = lib.mkIf config.mods.gh.enable {
    programs.gh = {
      enable = true;
    };
  };
}
