{ config, lib, ... }:

{
  config = lib.mkIf config.mods.helix.enable {
    programs.helix.settings.editor = {
      mouse = false;
      bufferline = "always";
      cursorcolumn = true;
      cursorline = true;
      line-number = "relative";
      completion-trigger-len = 1;
      completion-timeout = 0;
      idle-timeout = 0;
      auto-pairs = true;
      text-width = 120;
      color-modes = true;
      popup-border = "all";
      scrolloff = 5;
      end-of-line-diagnostics = "hint";
      shell = lib.mkIf config.mods.fish.enable [
        "fish"
        "-c"
      ];
      inline-diagnostics = {
        cursor-line = "disable";
        other-lines = "disable";
      };
      statusline = {
        left = [
          "mode"
          "separator"
          "workspace-diagnostics"
          "spinner"
          "separator"
          "read-only-indicator"
          "separator"
          "selections"
          "separator"
          "register"
        ];
        center = [
          "file-name"
          "separator"
          "version-control"
        ];
        right = [
          "diagnostics"
          "separator"
          "position"
          "separator"
          "position-percentage"
        ];
        separator = "";
        mode.normal = "NOR";
        mode.insert = "INS";
        mode.select = "SEL";
      };
      lsp = {
        enable = true;
        display-messages = true;
        display-inlay-hints = true;
      };
      file-picker.hidden = false;
      search.smart-case = false;
      whitespace = {
        render = {
          space = "none";
          tab = "none";
          nbsp = "none";
          nnbsp = "none";
          newline = "none";
        };
        characters = {
          space = "·";
          nbsp = "⍽";
          nnbsp = "␣";
          tab = "→";
          newline = "⏎";
          tabpad = "·";
        };
      };
      indent-guides = {
        render = false;
        character = "▏";
        skip-levels = 1;
      };
      soft-wrap.enable = false;
    };
  };
}
