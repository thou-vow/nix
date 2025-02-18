{ config, lib, ... }:

let
  commonIndent = {
    tab-width = 2;
    unit = " ";
  };
in
{
  config = lib.mkIf config.mods.helix.enable {
    programs.helix.languages = {
      language = [
        {
          name = "kdl";
          indent = commonIndent;
        }
        {
          name = "nix";
          indent = commonIndent;
          language-servers = [ "nixd" ];
        }
        {
          name = "rust";
          indent = commonIndent;
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "toml";
          indent = commonIndent;
        }
      ];

      language-server = {
        nixd = {
          command = "nixd";
          args = [ "--inlay-hints=true" ];
        };
        rust-analyzer.config = {
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
}
