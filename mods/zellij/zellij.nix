{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
  options.mods.zellij.enable = lib.mkEnableOption "enable zellij";

  config = lib.mkIf config.mods.zellij.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = lib.mkIf config.mods.fish.enable true;
      package = pkgs.zellij;
    };

    xdg.configFile."zellij/config.kdl".text = ''
      pane_frames false

      default_mode "locked"

      keybinds clear-defaults=true {
      	normal {
          bind "Esc" { SwitchToMode "Locked"; }
          bind "1" { GoToTab 1; SwitchToMode "Locked"; }
          bind "2" { GoToTab 2; SwitchToMode "Locked"; }
          bind "3" { GoToTab 3; SwitchToMode "Locked"; }
          bind "4" { GoToTab 4; SwitchToMode "Locked"; }
          bind "5" { GoToTab 5; SwitchToMode "Locked"; }
          bind "6" { GoToTab 6; SwitchToMode "Locked"; }
          bind "7" { GoToTab 7; SwitchToMode "Locked"; }
          bind "8" { GoToTab 8; SwitchToMode "Locked"; }
          bind "9" { GoToTab 9; SwitchToMode "Locked"; }
          bind "0" { GoToTab 10; SwitchToMode "Locked"; }
          bind "-" { Resize "Decrease"; SwitchToMode "Locked"; }
          bind "+" { Resize "Increase"; SwitchToMode "Locked"; }
          bind "q" { CloseFocus; SwitchToMode "Locked"; }
          bind "Shift q" { CloseTab; SwitchToMode "Locked"; }
          bind "y" { NewPane "Right"; SwitchToMode "Locked"; }
          bind "Shift y" { NewPane "Left"; SwitchToMode "Locked"; }
          bind "[" { GoToPreviousTab; SwitchToMode "Locked"; }
          bind "h" { MoveFocus "Left"; SwitchToMode "Locked"; }
          bind "j" { MoveFocus "Down"; SwitchToMode "Locked"; }
          bind "k" { MoveFocus "Up"; SwitchToMode "Locked"; }
          bind "l" { MoveFocus "Right"; SwitchToMode "Locked"; }
          bind "]" { GoToNextTab; SwitchToMode "Locked"; }
          bind "x" { NewPane "Down"; SwitchToMode "Locked"; }
          bind "Shift x" { NewPane "Up"; SwitchToMode "Locked"; }
          bind "n" { NewTab; SwitchToMode "Locked"; }
          bind "Shift h" { MovePane "Left"; SwitchToMode "Locked"; }
          bind "Shift j" { MovePane "Down"; SwitchToMode "Locked"; }
          bind "Shift k" { MovePane "Up"; SwitchToMode "Locked"; }
          bind "Shift l" { MovePane "Right"; SwitchToMode "Locked"; }
          bind "Left" { Resize "Increase Left"; SwitchToMode "Locked"; }
          bind "Down" { Resize "Increase Down"; SwitchToMode "Locked"; }
          bind "Up" { Resize "Increase Up"; SwitchToMode "Locked"; }
          bind "Right" { Resize "Increase Right"; SwitchToMode "Locked"; }
          bind "Shift Left" { Resize "Decrease Left"; SwitchToMode "Locked"; }
          bind "Shift Down" { Resize "Decrease Down"; SwitchToMode "Locked"; }
          bind "Shift Up" { Resize "Decrease Up"; SwitchToMode "Locked"; }
          bind "Shift Right" { Resize "Decrease Right"; SwitchToMode "Locked"; }
      	}
      	locked {
      		bind "Ctrl b" { SwitchToMode "Normal"; }
      	}
      }

      theme "rose-pine"

      themes {
      	rose-pine {
      		bg "#403d52"
      		fg "#e0def4"
      		red "#eb6f92"
      		green "#31748f"
      		blue "#9ccfd8"
      		yellow "#f6c177"
      		magenta "#c4a7e7"
      		orange "#fe640b"
      		cyan "#ebbcba"
      		black "#26233a"
      		white "#e0def4"
      	}
      }

      plugins {
        zjstatus location="file:${inputs.zjstatus.packages.${pkgs.system}.default}/bin/zjstatus.wasm" {
          hide_frame "true"

          format_left  "{mode}"
          format_center "{tabs}"
          format_right "#[bold]{session}"

          mode_normal "#[fg=white,bg=blue,bold]NORMAL#[fg=blue]"
          mode_locked "#[fg=white,bg=red,bold] LOCK #[fg=red]"

          tab_normal " {index}{sync_indicator}{fullscreen_indicator}{floating_indicator} "
          tab_active "#[fg=yellow,bold] {index}{sync_indicator}{fullscreen_indicator}{floating_indicator} "

          tab_sync_indicator       " "
          tab_fullscreen_indicator "□ "
          tab_floating_indicator   "󰉈 "
        }
      }
    '';

    xdg.configFile."zellij/layouts" =
      let
        layoutsPath = "${config.home.homeDirectory}/nix/mods/zellij/layouts";
      in
      {
        source = config.lib.file.mkOutOfStoreSymlink layoutsPath;
      };
  };
}
