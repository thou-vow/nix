{
  config,
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
              language-servers = ["nil"];
              formatter = {
                command = "${pkgs.alejandra}/bin/alejandra";
                args = ["--quiet" "-"];
              };
              auto-format = true;
            }
          ]
          ++ lib.optionals config.mods.rust.enable [
            {
              name = "rust";
              indent = commonIndent;
              language-servers = ["rust-analyzer"];
            }
          ];

        language-server = {
          nil = lib.mkIf config.mods.nix.enable {
            command = "${pkgs.nil}/bin/nil";
          };
          # nixd = lib.mkIf config.mods.nix.enable {
          #   command = "nixd";
          #   args = [ "--inlay-hints=true" ];
          #   # timeout = 60;
          #   config.nixd = {
          #     nixpkgs.expr = "import <nixpkgs> { }";
          #     options = {
          #       home-manager.expr = "(builtins.getFlake ~/nix ).nixOnDroidConfigurations.default.options.home-manager.users.type.getSubOptions []";
          #       nix-on-droid.expr = "(builtins.getFlake ~/nix )).nixOnDroidConfigurations.default.options";
          #     };
          #     formatting.command = "nixfmt";
          #   };
          # };
          # rust-analyzer = lib.mkIf config.mods.rust.enable {
          #   config = {
          #     lru.capacity = 128;
          #     cachePriming.enable = false;
          #     diagnostics.experimental.enable = true;
          #     checkOnSave.command = "clippy";
          #     cargo.allFeatures = true;
          #     numThreads = 2;
          #   };
          # };
        };
      };
    };
  };
}
