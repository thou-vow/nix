{ config, lib, pkgs, ... }:

let
  commonIndent = {
    tab-width = 2;
    unit = " ";
  };
in
{
  config = lib.mkIf config.mods.helix.enable {
    programs.helix = {
      extraPackages = with pkgs; lib.optionals config.mods.nix.enable [
        nil
        nixd
        nixfmt-rfc-style
      ];
      
      languages = {
        language = [
          {
            name = "kdl";
            indent = commonIndent;
          }
          {
            name = "toml";
            indent = commonIndent;
          }
        ] ++ lib.optionals config.mods.nix.enable [
          {
            name = "nix";
            indent = commonIndent;
            language-servers = [ "nil" "nixd" ];
          }
        ] ++ lib.optionals config.mods.rust.enable [
          {
            name = "rust";
            indent = commonIndent;
            language-servers = [ "rust-analyzer" ];
          }
        ];

        language-server = {
          nil = lib.mkIf config.mods.nix.enable {
            command = "nil";
          };
          nixd = lib.mkIf config.mods.nix.enable {
            command = "nixd";
            args = [ "--inlay-hints=true" ];
            config.nixd = {
              nixpkgs.expr = "import <nixpkgs> { }";
              options = {
                home-manager.expr = "(builtins.getFlake ~/nix ).nixOnDroidConfigurations.default.options.home-manager.users.type.getSubOptions []";
                nix-on-droid.expr = "(builtins.getFlake ~/nix )).nixOnDroidConfigurations.default.options";
              };
              formatting.command = "nixfmt";
            };
          };
          rust-analyzer = lib.mkIf config.mods.rust.enable {
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
