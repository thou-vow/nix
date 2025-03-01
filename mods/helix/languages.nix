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
              language-servers = [ "nixd" ];
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
          ]
          ++ lib.optionals config.mods.dash.enable [
            {
              name = "bash";
              indent = commonIndent;
              language-servers = [ "bash-language-server" ];
            }
          ];

        language-server = {
          bash-language-server = lib.mkIf config.mods.dash.enable {
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
          nixd = lib.mkIf config.mods.nix.enable {
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
