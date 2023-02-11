{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = ''
      Host *
              IdentityAgent ~/.1password/agent.sock
    '';
  };
}
