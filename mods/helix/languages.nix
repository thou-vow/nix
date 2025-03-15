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
              name = "nix";
              indent = commonIndent;
              auto-format = true;
              language-servers = [ "nixd" ];
            }
            {
              name = "ron";
              indent = commonIndent;
            }
            {
              name = "toml";
              indent = commonIndent;
            }
          ]
          ++ lib.optionals config.mods.langs.c.enable [
            {
              name = "c";
              indent = commonIndent;
              auto-format = true;
              file-types = [
                "c"
                "h"
              ];
              language-servers = [ "ccls" ];
            }
          ]
          ++ lib.optionals config.mods.langs.dash.enable [
            {
              name = "bash";
              indent = commonIndent;
              language-servers = [ "bash-language-server" ];
            }
          ]
          ++ lib.optionals config.mods.langs.rust.enable [
            {
              name = "rust";
              indent = commonIndent;
              language-servers = [ "rust-analyzer" ];
            }
          ]
          ++ lib.optionals config.mods.langs.typst.enable [
            {
              name = "typst";
              indent = commonIndent;
              formatter.command = "${lib.getExe pkgs.typst-fmt}";
              language-servers = [ "tinymist" ];
            }
          ];

        language-server = {
          bash-language-server = lib.mkIf config.mods.langs.dash.enable {
            command = "${lib.getExe pkgs.bash-language-server}";
            args = [ "start" ];
            config = {
              enableSourceErrorDiagnostics = true;
              shellcheckPath = "${lib.getExe pkgs.shellcheck}";
              shfmt = {
                path = "${lib.getExe pkgs.shfmt}";
                binaryNextLine = true;
                caseIndent = true;
                simplifyCode = true;
                spaceRedirects = true;
              };
            };
          };
          ccls = lib.mkIf config.mods.langs.c.enable {
            command = "ccls";
          };
          nixd = {
            command = "${lib.getExe pkgs.nixd}";
            args = [ "--inlay-hints=true" ];
            config.nixd = {
              nixpkgs.expr = "import (builtins.getFlake \"${config.home.homeDirectory}/nix\").inputs.nixpkgs {}";
              formatting = {
                command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
              };
              options."nix-on-droid".expr =
                "(builtins.getFlake \"${inputs.self}\").nixOnDroidConfigurations.default.options";
            };
          };
          rust-analyzer = lib.mkIf config.mods.langs.rust.enable {
            command = "${lib.getExe pkgs.rust-analyzer}";
            config = {
              cachePriming.enable = false;
              cargo.allFeatures = true;
              checkOnSave.command = "clippy";
              diagnostics.experimental.enable = true;
              lru.capacity = 128;
              numThreads = 2;
            };
          };
          tinymist = lib.mkIf config.mods.langs.typst.enable {
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
