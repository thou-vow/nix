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

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      nix-on-droid,
      ...
    }@inputs:
    let
      pkgs = import nixpkgs {
        system = builtins.currentSystem;

        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations = {
        termux = home-manager.lib.homeConfiguration {
          extraSpecialArgs = {
            inherit inputs;
          };

          inherit pkgs;

          modules = [ ./hosts/termux/home.nix ];
        };
      };

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        extraSpecialArgs = {
          inherit inputs;
        };

        inherit pkgs;

        modules = [ ./hosts/nix-on-droid/nix-on-droid.nix ];
      };

    };
}
