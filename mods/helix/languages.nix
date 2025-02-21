{
  config,
  inouts,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.mods.helix.enable {
    programs.helix = {
      languages = {
        language = let
          commonIndent = {
            tab-width = 2;
            unit = " ";
          };
        in
          [
            {
              name = "kdl";
              indent = commonIndent;
            }
            {
              name = "toml";
              indent = commonIndent;
            }
          ]
          ++ lib.optionals config.mods.nix.enable [
            {
              name = "nix";
              indent = commonIndent;
              language-servers = [
                "nil"
                # "nixd"
              ];
              auto-format = true;
            }
          ]
          ++ lib.optionals config.mods.rust.enable [
            {
              name = "rust";
              indent = commonIndent;
              language-servers = ["rust-analyzer"];
            }
          ] ++ lib.optionals config.mods.typst.enable [
            {
              name = "typst";
              indent = commonIndent;
              formatter.command = "${lib.getExe pkgs.typst-fmt}";
            }
          ];

        language-server = {
          nil = lib.mkIf config.mods.nix.enable {
            command = "${lib.getExe pkgs.nil}";
            formatting.command = ["${lib.getExe pkgs.alejandra}" "--quiet" "-"];
            nix = {
              maxMemoryMB = 1024;
              flake.autoEvalInputs = true;
            };
          };
          # nixd = lib.mkIf config.mods.nix.enable {
          #   command = "${pkgs.nixd}/bin/nixd";
          #   args = ["--inlay-hints=true"];
          #   config.nixd = {
          #     nixpkgs.expr = "import (builtins.getFlake \"${config.home.homeDirectory}/nix\").inputs.nixpkgs {}";
          #     formatting = {
          #       command = ["${pkgs.alejandra}/bin/alejandra" "--quiet" "-"];
          #     };
          #     options = {
          #       "nix-on-droid.default".expr = "(builtins.getFlake \"${config.home.homeDirectory}/home/nix\").nixOnDroidConfigurations.default.options";
          #       # "home-manager.default".expr = "(builtins.getFlake \"${config.home.homeDirectory}/nix\").nixOnDroidConfigurations.default.options.home-manager.users.type.getSubOptions []";
          #     };
          #   };
          # };
          rust-analyzer = lib.mkIf config.mods.rust.enable {
            command = "${lib.getExe pkgs.rust-analyzer}";
            config = {
              lru.capacity = 128;
              cachePriming.enable = false;
              diagnostics.experimental.enable = true;
              checkOnSave.command = "clippy";
              cargo.allFeatures = true;
              numThreads = 2;
            };
          };
        };
      };
    };
  };
}
