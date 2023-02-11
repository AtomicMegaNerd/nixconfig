{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  programs.ssh = {
    enable = true;
  };
}
