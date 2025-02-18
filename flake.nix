{
  description = "NixOS and Multi-User Home-Manager Config";

  nixConfig = {
    cores = 1;
    max-jobs = 1;
    max-substitution-jobs = 2;

    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  inputs = {
    ## Nix system
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:t184256/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Zellij configurable status bar
    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs =
    { nixpkgs, nix-on-droid, ... }@inputs:
    {
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = { inherit inputs; };

        pkgs = import nixpkgs {
          system = "aarch64-linux";

          config.allowUnfree = true;
        };

        modules = [ ./hosts/nix-on-droid/nix-on-droid.nix ];
      };

    };
}
