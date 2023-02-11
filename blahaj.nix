{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  programs.ssh = {
    enable = true;
  };

  programs.fish = {
    loginShellInit = ''
      set -gx NIX_PATH $NIX_PATH:$HOME/.nix-defexpr/channels
    '';
  };
}
