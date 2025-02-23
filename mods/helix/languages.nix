{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.mods.helix.enable {
    programs.helix = {
      languages = {
        language =
          let
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
              auto-format = true;
              language-servers = [
                # "nil"
                "nixd"
              ];
            }
          ]
          ++ lib.optionals config.mods.rust.enable [
            {
              name = "rust";
              indent = commonIndent;
              language-servers = [ "rust-analyzer" ];
            }
          ]
          ++ lib.optionals config.mods.typst.enable [
            {
              name = "typst";
              indent = commonIndent;
              formatter.command = "${lib.getExe pkgs.typst-fmt}";
              language-servers = [ "tinymist" ];
            }
          ];

        language-server = {
          # nil = lib.mkIf config.mods.nix.enable {
          #   command = "${lib.getExe pkgs.nil}";
          #   config.nil = {
          #     formatting.command = ["${lib.getExe pkgs.alejandra}" "--quiet" "-"];
          #     nix.flake.autoEvalInputs = true;
          #   };
          # };
          nixd = lib.mkIf config.mods.nix.enable {
            command = "${lib.getExe pkgs.nixd}";
            args = [ "--inlay-hints=true" ];
            config.nixd = {
              nixpkgs.expr = "import (builtins.getFlake \"${config.home.homeDirectory}/nix\").inputs.nixpkgs {}";
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
              options."nix-on-droid.default".expr =
                "(builtins.getFlake \"${inputs.self}\").nixOnDroidConfigurations.default.options";
            };
          };
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
          tinymist = lib.mkIf config.mods.typst.enable {
            command = "${lib.getExe pkgs.tinymist}";
            config = {
              exportPdf = "onSave";
              formatterMode = "typstyle";
            };
          };
        };
      };
    };
  };
}
