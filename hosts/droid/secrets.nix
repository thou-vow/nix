{
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;

    secrets = {
      "git/personal/email" = { };
      "git/personal/name" = { };
      "github/personal/private".mode = "0400";
      "github/personal/public" = { };
    };
  };

  home = {
    file.".config/git/personal".text = ''
      [user]
        email = $(GITHUB_PERSONAL_EMAIL)
        name = $(GITHUB_PERSONAL_NAME)
    '';
    sessionVariables = {
      "GIT_PERSONAL_EMAIL" = "$(cat ${config.sops.secrets."git/personal/email".path})";
      "GIT_PERSONAL_NAME" = "$(cat ${config.sops.secrets."git/personal/name".path})";
    };
  };

  programs = {
    git = {
      extraConfig = {
        includeIf."gitdir:~/projects/personal/".path = "~/.config/git/personal";
      };
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "github.com-personal" = {
          identityFile = config.sops.secrets."github/personal/private".path;
          user = "git";
        };
      };
    };
  };

  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
